//
//  ProductDetailViewModel.swift
//  Market
//
//  Created by 김효원 on 10/12/2019.
//  Copyright © 2019 김효원. All rights reserved.
//

import Foundation

struct ProductDetailViewModel: ProductDetailBindable {
    let id: Int
    
    init(model: ProductDetailModel = ProductDetailModel(), id: Int) {
        self.id = id
    }
}
