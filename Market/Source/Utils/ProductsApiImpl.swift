//
//  ProductsApiImpl.swift
//  Market
//
//  Created by 김효원 on 02/12/2019.
//  Copyright © 2019 김효원. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

class ProductsApiImpl: ProductsApi {
    private let session: URLSession
    private let baseURL = "https://2jt4kq01ij.execute-api.ap-northeast-2.amazonaws.com/prod/"
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getProdcuts(page: (Int?, Int?)) -> Observable<Result<[Product], ProductsApiError>> {
        let error = ProductsApiError.defaultError
        return .just(.failure(error))
    }
    
    func getProdcut(id: Int?) -> Observable<Result<Product, ProductsApiError>> {
        let error = ProductsApiError.defaultError
        return .just(.failure(error))
    }
}
