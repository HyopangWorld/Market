//
//  ProductDetailViewModel.swift
//  Market
//
//  Created by 김효원 on 10/12/2019.
//  Copyright © 2019 김효원. All rights reserved.
//

import RxSwift
import RxCocoa

struct ProductDetailViewModel: ProductDetailBindable {
    let disposeBag = DisposeBag()
    
    internal let id: Int
    let viewWillAppear = PublishRelay<Void>()
    
    init(model: ProductDetailModel = ProductDetailModel(), id: Int) {
        self.id = id
    }
}
