//
//  StringsExtensions.swift
//  Wendy
//
//  Created by Levi Bostian on 12/21/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

extension String {
    var data: Data {
        return self.data(using: .utf8)!
    }
}
