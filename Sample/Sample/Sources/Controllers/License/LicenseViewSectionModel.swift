//
//  LicenseViewSectionModel.swift
//  Sample
//
//  Created by Takuma Horiuchi on 2018/09/23.
//  Copyright © 2018年 Takuma Horiuchi. All rights reserved.
//

import UIKit
import RxDataSources

struct LicenseViewSectionModel {
    var libName: String
    var legalTexts: [String]

    init?(libName: String?, legalText: String?) {
        guard let libName = libName, let legalText = legalText else {
            return nil
        }
        self.libName = libName
        self.legalTexts = [legalText]
    }
}

extension LicenseViewSectionModel: SectionModelType {
    typealias Item = String

    var items: [String] {
        return legalTexts
    }

    init(original: LicenseViewSectionModel, items: [Item]) {
        self = original
        self.legalTexts = items
    }
}
