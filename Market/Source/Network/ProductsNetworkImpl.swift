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

class ProductsNetworkImpl: ProductsNetwork {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getProdcuts(page: (Int?, Int?)) -> Observable<Result<[Product], ProductsNetworkError>> {
        guard let url = makeGetProductsComponents(page: page.0).url else {
            let error = ProductsNetworkError.error("유효하지 않은 URL입니다.")
            return .just(.failure(error))
        }
        
        return session.rx.data(request: URLRequest(url: url))
            .map { data in
                do {
                    let response = try JSONDecoder().decode(ProductResponse<[Product]>.self, from: data)
                    // TODO: response.statusCode 받아서 처리 로직 추가
                    return .success(response.body)
                } catch {
                    return .failure(.error("getProducts API 에러"))
                }
            }
    }
    
    func getProdcut(id: Int) -> Observable<Result<Product, ProductsNetworkError>> {
        guard let url = makeGetProductComponents(id: id).url else {
            let error = ProductsNetworkError.error("유효하지 않은 URL입니다.")
            return .just(.failure(error))
        }
        
        return session.rx.data(request: URLRequest(url: url))
            .map { data in
                do {
                    let products = try JSONDecoder().decode(Product.self, from: data)
                    return .success(products)
                } catch {
                    return .failure(.error("getProduct API 에러"))
                }
            }
    }
}

extension ProductsNetworkImpl {
    struct ProductAPI {
        static let scheme = "https"
        static let host = "2jt4kq01ij.execute-api.ap-northeast-2.amazonaws.com"
        static let path = "/prod"
    }
    
    func makeGetProductsComponents(page: Int?) -> URLComponents {
        var components = URLComponents()
        components.scheme = ProductAPI.scheme
        components.host = ProductAPI.host
        components.path = ProductAPI.path + "/products"
        if let page = page {
            components.queryItems = [
                URLQueryItem(name: "page", value: "\(page)")
            ]
        }
        else {
            components.queryItems = [
                URLQueryItem(name: "page", value: "1")
            ]
        }
        
        return components
    }
    
    func makeGetProductComponents(id: Int) -> URLComponents {
        var components = URLComponents()
        components.scheme = ProductAPI.scheme
        components.host = ProductAPI.host
        components.path = ProductAPI.path + "/products/\(id)"
        
        return components
    }
}
