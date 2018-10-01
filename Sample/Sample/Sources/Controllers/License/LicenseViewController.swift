//
//  LicenseViewController.swift
//  Sample
//
//  Created by Takuma Horiuchi on 2018/09/21.
//  Copyright © 2018年 Takuma Horiuchi. All rights reserved.
//

import UIKit

final class LicenseViewController: UIViewController, Storyboardable {

    @IBOutlet private weak var tableView: UITableView!

    private var settingsButtonItem: UIBarButtonItem {
        let item = UIBarButtonItem(title: "Settings", style: .plain, target: nil, action: nil)
        navigationItem.setRightBarButton(item, animated: true)
        return item
    }

    private let dataSource = LicenseViewDataSource()
    private let viewModel = LicenseViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource.configure(tableView: tableView, licenses: viewModel.licenses)

        let input = LicenseViewModel.Input(settingsTap: settingsButtonItem.rx.tap)
        viewModel.bind(input)
    }
}
