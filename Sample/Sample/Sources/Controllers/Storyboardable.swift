//
//  Storyboardable.swift
//  Sample
//
//  Created by Takuma Horiuchi on 2018/09/24.
//  Copyright © 2018年 Takuma Horiuchi. All rights reserved.
//

import UIKit

protocol Storyboardable: NSObjectProtocol {
    static var storyboardName: String { get }
    static var identifier: String { get }
    static var storyboard: UIStoryboard { get }
    static func makeFromStoryboard() -> Self
}

extension Storyboardable {
    static var storyboardName: String {
        return className
    }

    static var identifier: String {
        return className
    }

    static var storyboard: UIStoryboard {
        return UIStoryboard(name: storyboardName, bundle: Bundle(identifier: identifier))
    }

    static func makeFromStoryboard() -> Self {
        return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
    }
}
