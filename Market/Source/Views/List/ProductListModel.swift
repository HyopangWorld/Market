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
    let productsNetwork: ProductsNetwork
    
    init(productsNetwork: ProductsNetwork = ProductsNetworkImpl()) {
        self.productsNetwork = productsNetwork
    }
    
    func getProductList() -> Observable<Result<[Product], ProductsNetworkError>> {
        return productsNetwork.getProdcuts(page: (nil, nil))
    }
    
    func pasrseData(value: [Product]) -> [ProductListCell.Data] {
        print("\(value)")
        return value.map {
            (id: $0.id ?? 0, thumbnailURL: $0.thumbnailURL ?? "", title: $0.title ?? "", seller: $0.seller ?? "")
        }
    }
    
    func fetchMoreData(from: Int) -> Observable<Result<[Product], ProductsNetworkError>> {
        // from에서 10개, from+1에서 10개
        if from % 50 == 10 { return productsNetwork.getProdcuts(page: (from, from+1)) }
        // 5회 마다 다음 페이지에서
        else if (from / 20) % 5 == 1 { return productsNetwork.getProdcuts(page: (from+1, nil)) }
        else { return productsNetwork.getProdcuts(page: (from, nil)) }
    }
}
