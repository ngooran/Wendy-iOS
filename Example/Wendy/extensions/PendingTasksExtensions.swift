//
//  PendingTasksExtensions.swift
//  Wendy
//
//  Created by Levi Bostian on 12/21/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import Wendy

extension PendingTask {
    // Only used in this example app as all pending tasks in this app are strings and we want to display the data in the example app.
    var dataString: String {
        return self.data!.string
    }
}
