// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
import Wendy
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif














class WendyPendingTaskMock: WendyPendingTask {
    var taskId: Double?
    var dataId: String?
    var manuallyRun: Bool {
        get { return underlyingManuallyRun }
        set(value) { underlyingManuallyRun = value }
    }
    var underlyingManuallyRun: Bool!
    var groupId: String?
    var tag: String {
        get { return underlyingTag }
        set(value) { underlyingTag = value }
    }
    var underlyingTag: String!
    var createdAt: Date?

    //MARK: - runTask

    var runTaskCompleteCallsCount = 0
    var runTaskCompleteCalled: Bool {
        return runTaskCompleteCallsCount > 0
    }
    var runTaskCompleteReceivedComplete: ((Bool) -> Void)?
    var runTaskCompleteReceivedInvocations: [((Bool) -> Void)] = []
    var runTaskCompleteClosure: ((@escaping (Bool) -> Void) -> Void)?

    func runTask(complete: @escaping (Bool) -> Void) {
        runTaskCompleteCallsCount += 1
        runTaskCompleteReceivedComplete = complete
        runTaskCompleteReceivedInvocations.append(complete)
        runTaskCompleteClosure?(complete)
    }

    //MARK: - isReadyToRun

    var isReadyToRunCallsCount = 0
    var isReadyToRunCalled: Bool {
        return isReadyToRunCallsCount > 0
    }
    var isReadyToRunReturnValue: Bool!
    var isReadyToRunClosure: (() -> Bool)?

    func isReadyToRun() -> Bool {
        isReadyToRunCallsCount += 1
        return isReadyToRunClosure.map({ $0() }) ?? isReadyToRunReturnValue
    }

}
class WendyTaskRunnerListenerMock: WendyTaskRunnerListener {

    //MARK: - newTaskAdded

    var newTaskAddedCallsCount = 0
    var newTaskAddedCalled: Bool {
        return newTaskAddedCallsCount > 0
    }
    var newTaskAddedReceivedTask: PendingTask?
    var newTaskAddedReceivedInvocations: [PendingTask] = []
    var newTaskAddedClosure: ((PendingTask) -> Void)?

    func newTaskAdded(_ task: PendingTask) {
        newTaskAddedCallsCount += 1
        newTaskAddedReceivedTask = task
        newTaskAddedReceivedInvocations.append(task)
        newTaskAddedClosure?(task)
    }

    //MARK: - taskSkipped

    var taskSkippedReasonCallsCount = 0
    var taskSkippedReasonCalled: Bool {
        return taskSkippedReasonCallsCount > 0
    }
    var taskSkippedReasonReceivedArguments: (task: PendingTask, reason: ReasonPendingTaskSkipped)?
    var taskSkippedReasonReceivedInvocations: [(task: PendingTask, reason: ReasonPendingTaskSkipped)] = []
    var taskSkippedReasonClosure: ((PendingTask, ReasonPendingTaskSkipped) -> Void)?

    func taskSkipped(_ task: PendingTask, reason: ReasonPendingTaskSkipped) {
        taskSkippedReasonCallsCount += 1
        taskSkippedReasonReceivedArguments = (task: task, reason: reason)
        taskSkippedReasonReceivedInvocations.append((task: task, reason: reason))
        taskSkippedReasonClosure?(task, reason)
    }

    //MARK: - taskComplete

    var taskCompleteSuccessfulCallsCount = 0
    var taskCompleteSuccessfulCalled: Bool {
        return taskCompleteSuccessfulCallsCount > 0
    }
    var taskCompleteSuccessfulReceivedArguments: (task: PendingTask, successful: Bool)?
    var taskCompleteSuccessfulReceivedInvocations: [(task: PendingTask, successful: Bool)] = []
    var taskCompleteSuccessfulClosure: ((PendingTask, Bool) -> Void)?

    func taskComplete(_ task: PendingTask, successful: Bool) {
        taskCompleteSuccessfulCallsCount += 1
        taskCompleteSuccessfulReceivedArguments = (task: task, successful: successful)
        taskCompleteSuccessfulReceivedInvocations.append((task: task, successful: successful))
        taskCompleteSuccessfulClosure?(task, successful)
    }

    //MARK: - runningTask

    var runningTaskCallsCount = 0
    var runningTaskCalled: Bool {
        return runningTaskCallsCount > 0
    }
    var runningTaskReceivedTask: PendingTask?
    var runningTaskReceivedInvocations: [PendingTask] = []
    var runningTaskClosure: ((PendingTask) -> Void)?

    func runningTask(_ task: PendingTask) {
        runningTaskCallsCount += 1
        runningTaskReceivedTask = task
        runningTaskReceivedInvocations.append(task)
        runningTaskClosure?(task)
    }

    //MARK: - allTasksComplete

    var allTasksCompleteCallsCount = 0
    var allTasksCompleteCalled: Bool {
        return allTasksCompleteCallsCount > 0
    }
    var allTasksCompleteClosure: (() -> Void)?

    func allTasksComplete() {
        allTasksCompleteCallsCount += 1
        allTasksCompleteClosure?()
    }

    //MARK: - errorRecorded

    var errorRecordedErrorMessageErrorIdCallsCount = 0
    var errorRecordedErrorMessageErrorIdCalled: Bool {
        return errorRecordedErrorMessageErrorIdCallsCount > 0
    }
    var errorRecordedErrorMessageErrorIdReceivedArguments: (task: PendingTask, errorMessage: String?, errorId: String?)?
    var errorRecordedErrorMessageErrorIdReceivedInvocations: [(task: PendingTask, errorMessage: String?, errorId: String?)] = []
    var errorRecordedErrorMessageErrorIdClosure: ((PendingTask, String?, String?) -> Void)?

    func errorRecorded(_ task: PendingTask, errorMessage: String?, errorId: String?) {
        errorRecordedErrorMessageErrorIdCallsCount += 1
        errorRecordedErrorMessageErrorIdReceivedArguments = (task: task, errorMessage: errorMessage, errorId: errorId)
        errorRecordedErrorMessageErrorIdReceivedInvocations.append((task: task, errorMessage: errorMessage, errorId: errorId))
        errorRecordedErrorMessageErrorIdClosure?(task, errorMessage, errorId)
    }

    //MARK: - errorResolved

    var errorResolvedCallsCount = 0
    var errorResolvedCalled: Bool {
        return errorResolvedCallsCount > 0
    }
    var errorResolvedReceivedTask: PendingTask?
    var errorResolvedReceivedInvocations: [PendingTask] = []
    var errorResolvedClosure: ((PendingTask) -> Void)?

    func errorResolved(_ task: PendingTask) {
        errorResolvedCallsCount += 1
        errorResolvedReceivedTask = task
        errorResolvedReceivedInvocations.append(task)
        errorResolvedClosure?(task)
    }

}
