@testable import Wendy
import XCTest

class ClearIntegrationTests: XCTestCase {
    
    // Yes, using a singleton in a test is not the best idea. However, in order to fix this, it will take much more work then just changing the constructor permissions. Therefore, this will do for now.
    private var wendy: Wendy {
        return Wendy.shared
    }
    private var taskRunnerListener: WendyTaskRunnerListenerMock!
    
    override func setUp() {
        super.setUp()
        
        taskRunnerListener = WendyTaskRunnerListenerMock()
        WendyConfig.addTaskRunnerListener(taskRunnerListener)

        // THIS is breaking the tests at this time. Core Data manager needs to have a Bundle provided to it. At this time, the tests crash because the Wendy framework Bundle is being used in the manager.
        try! CoreDataManager.shared.destroy()
    }
    
    override func tearDown() {
        try! CoreDataManager.shared.destroy()
        
        super.tearDown()
    }
    
    func test_givenManyTasks_givenNotManuallyRun_clear_expectAllTasksCancelledAndDeleted() {
        let givenPendingTasks: [PendingTask] = PendingTaskFakes.random(many: 5, manuallyRun: false, groupId: nil)
        Wendy.setup(tasksFactory: TestsWendyTasksFactory(givenPendingTasks: givenPendingTasks))
        
        givenPendingTasks.forEach {
            _ = wendy.addTask($0)
        }
        
        let expectTaskListenerToGetCalled = expectation(description: "Expect all tasks to complete")
        taskRunnerListener.allTasksCompleteClosure = {
            expectTaskListenerToGetCalled.fulfill()
        }
        
        wendy.clear()
        XCTAssertFalse(self.wendy.getAllTasks().isEmpty)
        
        waitForExpectations()
        
        XCTAssertTrue(self.wendy.getAllTasks().isEmpty)
    }
    
}
