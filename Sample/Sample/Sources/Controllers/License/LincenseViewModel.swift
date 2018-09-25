//
//  LincenseViewModel.swift
//  Sample
//
//  Created by Takuma Horiuchi on 2018/09/23.
//  Copyright © 2018年 Takuma Horiuchi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class LicenseViewModel: ReactiveCompatible {

    var licenses: Observable<[LicenseViewSectionModel]> {
        return _licenses.asObservable()
    }

    private let _licenses = BehaviorRelay<[LicenseViewSectionModel]>(value: [])

    init(settingsTap: ControlEvent<Void>) {
        if let acknowledgementsPath = Bundle.main.path(forResource: "Sample-Acknowledgements", ofType: "plist"),
            let acknowledgements = NSDictionary(contentsOfFile: acknowledgementsPath),
            let preferenceSpecifiers = acknowledgements.object(forKey: "PreferenceSpecifiers") as? [[String: String]] {
            let licenses = preferenceSpecifiers.compactMap { LicenseViewSectionModel(libName: $0["Title"], legalText: $0["FooterText"]) }
            _licenses.accept(licenses)
        }

        settingsTap
            .subscribe(onNext: {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            })
            .disposed(by: rx.disposeBag)
    }
}
