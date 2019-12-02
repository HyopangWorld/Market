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
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getProdcuts(page: Int?) -> Observable<Result<[Product], ProductsApiError>> {
        let error = ProductsApiError.defaultError
        return .just(.failure(error))
    }
    
    func getProdcut(id: Int?) -> Observable<Result<Product, ProductsApiError>> {
        let error = ProductsApiError.defaultError
        return .just(.failure(error))
    }
    
}
