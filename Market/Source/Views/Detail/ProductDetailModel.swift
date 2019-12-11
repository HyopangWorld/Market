//
//  ProductDetailModel.swift
//  Market
//
//  Created by 김효원 on 10/12/2019.
//  Copyright © 2019 김효원. All rights reserved.
//

import Foundation
import RxSwift

struct ProductDetailModel {
    private let productsNetwork: ProductsNetwork
    
    init(productsNetwork: ProductsNetwork = ProductsNetworkImpl()) {
        self.productsNetwork = productsNetwork
    }
    
    func getProductDetail(id: Int) -> Observable<Result<Product, ProductsNetworkError>> {
        return productsNetwork.getProdcut(id: id)
    }
    
    func pasrseData(value: Product) -> DetailData? {
        return (id: value.id ?? 0,
        thumbnail_720: value.thumbnail_720 ?? "",
        thumbnailList: value.thumbnailList ?? [],
        title: value.title ?? "",
        seller: value.seller ?? "",
        cost: value.cost ?? "",
        discount_cost: value.discount_cost ?? "",
        discount_rate: value.discount_rate ?? "",
        description: value.description ?? "")
    }
}
