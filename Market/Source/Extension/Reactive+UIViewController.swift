//
//  Reactive+UIViewController.swift
//  Market
//
//  Created by 김효원 on 11/12/2019.
//  Copyright © 2019 김효원. All rights reserved.
//

import RxSwift
import RxCocoa
import Toaster

extension Reactive where Base: UIViewController {
    func toast(delay: TimeInterval = 0, duration: TimeInterval = 0.8) -> Binder<String> {
        return Binder(base) { _, text in
            Toast(text: text, delay: delay, duration: duration).show()
        }
    }
}
