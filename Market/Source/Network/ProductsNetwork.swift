//
//  ApiController.swift
//  Market
//
//  Created by 김효원 on 02/12/2019.
//  Copyright © 2019 김효원. All rights reserved.
//

import Foundation

import RxSwift

enum ProductsNetworkError: Error {
    case error(String)
    case defaultError
    
    var message: String? {
        switch self {
        case let .error(msg):
            return msg
        case .defaultError:
            return "네트워크 오류"
        }
    }
}

protocol ProductsNetwork {
    func getProdcuts(page: (Int?, Int?)) -> Observable<Result<[Product], ProductsNetworkError>>
    func getProdcut(id: Int) -> Observable<Result<Product, ProductsNetworkError>>
}
