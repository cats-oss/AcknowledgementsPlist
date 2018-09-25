//
//  LicenseCell.swift
//  Sample
//
//  Created by Takuma Horiuchi on 2018/09/24.
//  Copyright © 2018年 Takuma Horiuchi. All rights reserved.
//

import UIKit
import AttributedLabel
import Reusable

final class LicenseCell: UITableViewCell, NibReusable {

    @IBOutlet weak var legalTextLabel: UILabel! {
        didSet {
            legalTextLabel.font = .systemFont(ofSize: 12)
            legalTextLabel.textAlignment = .left
            legalTextLabel.numberOfLines = 0
        }
    }
}
