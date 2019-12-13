//
//  Constants.swift
//  Market
//
//  Created by 김효원 on 13/12/2019.
//  Copyright © 2019 김효원. All rights reserved.
//

import Foundation
import UIKit


//MARK: - UI와 관련된 Constants
struct MarketUI {
    static let safeAreaInsetsTop = (UIApplication.shared.windows.first { $0.isKeyWindow })?.safeAreaInsets.top ?? 0
}
