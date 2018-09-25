//
//  NSObjectProtocolExtension.swift
//  Sample
//
//  Created by Takuma Horiuchi on 2018/09/24.
//  Copyright © 2018年 Takuma Horiuchi. All rights reserved.
//

import Foundation

extension NSObjectProtocol {
    static var className: String {
        return String(describing: self)
    }
}
