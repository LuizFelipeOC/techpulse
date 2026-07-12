//
//  SettingsOptionModel.swift
//  techpulse
//
//  Created by Luiz Felipe on 12/07/26.
//

import UIKit

struct SettingOption {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: () -> Void
}


struct SettingSection {
    let title: String
    let options: [SettingOption]
}
