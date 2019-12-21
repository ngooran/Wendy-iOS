//
//  DataExtensions.swift
//  Wendy
//
//  Created by Levi Bostian on 12/21/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

extension Data {
    var string: String {
        return String(data: self, encoding: .utf8)!
    }
}
