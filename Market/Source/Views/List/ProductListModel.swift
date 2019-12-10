//
//  MainModel.swift
//  Market
//
//  Created by 김효원 on 03/12/2019.
//  Copyright © 2019 김효원. All rights reserved.
//

import Foundation
import RxSwift

struct ProductListModel {
    private let productsNetwork: ProductsNetwork
    
    init(productsNetwork: ProductsNetwork = ProductsNetworkImpl()) {
        self.productsNetwork = productsNetwork
    }
    
    func getProductList() -> Observable<Result<[Product], ProductsNetworkError>> {
        return productsNetwork.getProdcuts(page: 1)
    }
    
    func getProductList(page: Int) -> Observable<Result<[Product], ProductsNetworkError>> {
        return productsNetwork.getProdcuts(page: page)
    }
    
    func pasrseData(value: [Product]) -> [ProductListCell.Data] {
        return value.map {
            (id: $0.id ?? 0, thumbnailURL: $0.thumbnailURL ?? "", title: $0.title ?? "", seller: $0.seller ?? "")
        }
    }
}
