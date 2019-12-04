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
    let productsApi: ProductsApi
    
    init(productsApi: ProductsApi = ProductsApiImpl()) {
        self.productsApi = productsApi
    }
    
    func getProductList() -> Observable<Result<[Product], ProductsApiError>> {
        return productsApi.getProdcuts(page: (nil, nil))
    }
    
    func pasrseData(value: [Product]) -> [ProductListCell.Data] {
        return value.map {
            (id: $0.id ?? 0, thumbnailURL: $0.thumbnailURL ?? "", title: $0.title ?? "", seller: $0.seller ?? "")
        }
    }
    
    func fetchMoreData(from: Int) -> Observable<Result<[Product], ProductsApiError>> {
        // 한 page당 50개
        // from에서 10개 , from+1에서 10개
        if from % 50 == 10 {
            return productsApi.getProdcuts(page: (from, from+1))
        }
        // 다음 페이지
        else if (from / 20) % 5 == 1 {
            return productsApi.getProdcuts(page: (from+1, nil))
        }
        // 같은 페이지
        else {
            return productsApi.getProdcuts(page: (from, nil))
        }
    }
}
