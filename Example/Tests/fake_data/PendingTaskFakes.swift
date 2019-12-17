//
//  PendingTaskFakes.swift
//  Wendy_Tests
//
//  Created by Levi Bostian on 12/17/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

class PendingTaskFakes {
    
    static func random(many numberOfFakes: Int, manuallyRun: Bool, groupId: String?) -> [WendyPendingTaskMock] {
        var fakes: [WendyPendingTaskMock] = []
        
        for i in 0..<numberOfFakes {
            let fake = WendyPendingTaskMock()
            fake.underlyingManuallyRun = manuallyRun
            fake.dataId = String(describing: i)
            fake.groupId = groupId
            fake.underlyingTag = fake.dataId
            fake.isReadyToRunReturnValue = true
            
            fakes.append(fake)
        }
        
        return fakes
    }
    
}
