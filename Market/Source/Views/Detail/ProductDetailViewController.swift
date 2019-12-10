//
//  ProductDetailViewController.swift
//  Market
//
//  Created by 김효원 on 10/12/2019.
//  Copyright © 2019 김효원. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxAppState
import RxDataSources
import SnapKit
import Then
import Toaster

protocol ProductDetailBindable {
    var id: Int { get }
    var viewWillAppear: PublishRelay<Void> { get }
}

class ProductDetailViewController: ViewController<ProductDetailBindable> {
    
    override func bind(_ viewModel: ProductDetailBindable) {
        self.disposeBag = DisposeBag()
        
        self.rx.viewWillAppear
            .map { _ in Void() }
            .bind(to: viewModel.viewWillAppear)
            .disposed(by: disposeBag)
    }
    
    override func attribute() {
        view.backgroundColor = .white
    }
    
    override func layout() {
        
    }
}
