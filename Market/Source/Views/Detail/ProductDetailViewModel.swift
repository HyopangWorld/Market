//
//  ProductDetailViewModel.swift
//  Market
//
//  Created by 김효원 on 10/12/2019.
//  Copyright © 2019 김효원. All rights reserved.
//

import RxSwift
import RxCocoa

struct ProductDetailViewModel: ProductDetailBindable {
    let disposeBag = DisposeBag()
    
    let id: Int
    let viewWillAppear = PublishRelay<Int>()
    let productDetailData: Signal<DetailData>
    let errorMessage: Signal<String>
    
    init(model: ProductDetailModel = ProductDetailModel(), id: Int) {
        self.id = id
        
        let productDetailResult = viewWillAppear
            .flatMap(model.getProductDetail)
            .asObservable()
            .share()
        
        let productDetailValue = productDetailResult
            .map { result -> [Product]? in
                guard case .success(let value) = result else {
                    return nil
                }
                return value
            }
            .filterNil()
        
        let productDetailError = productDetailResult
            .map { result -> String? in
                guard case .failure(let error) = result else {
                    return nil
                }
                return error.message
            }
            .filterNil()
        
        self.productDetailData = Observable
            .merge(productDetailValue)
            .map(model.pasrseData)
            .filterNil()
            .asSignal(onErrorSignalWith: .empty())
        
        self.errorMessage = Observable
            .merge(productDetailError)
            .asSignal(onErrorJustReturn: "잠시 후 다시 시도해 주세요")
    }
}
