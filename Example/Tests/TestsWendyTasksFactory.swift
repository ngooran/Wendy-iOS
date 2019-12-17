//
//  TestsWendyTasksFactory.swift
//  Wendy_Tests
//
//  Created by Levi Bostian on 12/17/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import Wendy

class TestsWendyTasksFactory: PendingTasksFactory {
    
    private let givenPendingTasks: [PendingTask]
    
    init(givenPendingTasks: [PendingTask]) {
        self.givenPendingTasks = givenPendingTasks
    }
    
    func getTask(tag: String) -> PendingTask? {
        let index: Int = Int(tag)!
        
        return givenPendingTasks[index]
    }
}
