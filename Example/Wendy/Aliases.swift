//
//  Aliases.swift
//  Wendy
//
//  Created by Levi Bostian on 12/17/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import protocol Wendy.PendingTask

// Exists to be able to make mock for tests
protocol WendyPendingTask: Wendy.PendingTask, AutoMockable {
    var taskId: Double? { get set } // Simply links a PendingTask to a PersistedPendingTask. This identifies a PendingTask. It is *not* used as the sort order for when tasks will be run.
    var dataId: String? { get set }
    var manuallyRun: Bool { get set }
    var groupId: String? { get set }
    var tag: String { get }
    var createdAt: Date? { get set } // How the order is determined by the task runner. Just like taskId, this is nil until the PendingTask is added to Wendy.

    func runTask(complete: @escaping (Bool) -> Void)
    func isReadyToRun() -> Bool
}

import protocol Wendy.TaskRunnerListener
import enum Wendy.ReasonPendingTaskSkipped

// Exists to be able to make mock for tests
protocol WendyTaskRunnerListener: Wendy.TaskRunnerListener, AutoMockable {
    func newTaskAdded(_ task: PendingTask)
    func taskSkipped(_ task: PendingTask, reason: ReasonPendingTaskSkipped)
    func taskComplete(_ task: PendingTask, successful: Bool)
    func runningTask(_ task: PendingTask)
    func allTasksComplete()
    func errorRecorded(_ task: PendingTask, errorMessage: String?, errorId: String?)
    func errorResolved(_ task: PendingTask)
}
