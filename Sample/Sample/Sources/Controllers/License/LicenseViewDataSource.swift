//
//  LicenseViewDataSource.swift
//  Sample
//
//  Created by Takuma Horiuchi on 2018/09/23.
//  Copyright © 2018年 Takuma Horiuchi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Reusable
import RxDataSources

final class LicenseViewDataSource: NSObject {

    private let viewModel: LicenseViewModel

    init(viewModel: LicenseViewModel) {
        self.viewModel = viewModel
    }

    func configure(tableView: UITableView) {
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.register(cellType: LicenseCell.self)

        let dataSource = RxTableViewSectionedReloadDataSource<LicenseViewSectionModel>(
            configureCell: { _, tableView, indexPath, legalText in
                let cell: LicenseCell = tableView.dequeueReusableCell(for: indexPath)
                cell.legalTextLabel.text = legalText
                return cell
            },
            titleForHeaderInSection: { dataSource, index in
                return dataSource.sectionModels[index].libName
            }
        )

        viewModel.licenses
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
    }
}
