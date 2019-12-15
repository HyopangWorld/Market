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
    
    func getProductDetail(id: Int) -> Observable<Result<[Product], ProductsNetworkError>> {
        return productsNetwork.getProduct(id: id)
    }
    
    func parseData(value: [Product]) -> DetailData? {
        let val = value.first
        return (id: val?.id ?? 0,
        thumbnail_720: val?.thumbnail_720 ?? "",
        thumbnailList: val?.thumbnailList ?? [],
        title: val?.title ?? "",
        seller: val?.seller ?? "",
        cost: val?.cost ?? "",
        discount_cost: val?.discount_cost ?? "",
        discount_rate: val?.discount_rate ?? "",
        description: val?.description ?? "")
    }
}
