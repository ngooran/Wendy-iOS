//
//  ThreadUtil.swift
//  Wendy
//
//  Created by Levi Bostian on 12/17/19.
//

import Foundation

internal protocol ThreadUtil {
    var isMain: Bool { get }
    var isBackground: Bool { get }

    func assertMain()
    func assertBackground()
}

internal class AppThreadUtil: ThreadUtil {
    var isMain: Bool {
        return Thread.isMainThread
    }

    var isBackground: Bool {
        return !isMain
    }

    func assertMain() {
        if !isMain {
            fatalError("You are not on the UI thread")
        }
    }

    func assertBackground() {
        if !isBackground {
            fatalError("You are not on a background thread")
        }
    }
}
