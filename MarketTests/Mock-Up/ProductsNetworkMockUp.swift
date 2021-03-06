//
//  ProductsNetworkMock.swift
//  MarketTests
//
//  Created by 김효원 on 15/12/2019.
//  Copyright © 2019 김효원. All rights reserved.
//

import Foundation
import RxSwift

@testable import Market

struct ProductsNetworkMockUp: ProductsNetwork {
    func getProducts(page: Int) -> Observable<Result<[Product], ProductsNetworkError>> {
        guard let data = ProductsDummyData.productsJSONString.data(using: .utf8) else {
            return .just(.failure(.error("Dummy Data 에러")))
        }
        
         do {
             let response = try JSONDecoder().decode(ProductResponse<[Product]>.self, from: data)
             return .just(.success(response.body))
         } catch {
             return .just(.failure(.error("getProducts API 에러")))
         }
    }
    
    func getProduct(id: Int) -> Observable<Result<[Product], ProductsNetworkError>> {
        let data = ProductsDummyData.productJSONString.data(using: .utf8) else {
                   return .just(.failure(.error("Dummy Data 에러")))
        }
        
         do {
             let response = try JSONDecoder().decode(ProductResponse<[Product]>.self, from: data)
             return .just(.success(response.body))
         } catch {
            return .just(.failure(.error("getProduct API 에러 \(error)")))
         }
    }
}


