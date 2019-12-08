//
//  MarketViewModel.swift
//  Market
//
//  Created by 김효원 on 02/12/2019.
//  Copyright © 2019 김효원. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxOptional

struct ProductListViewModel: ProductListViewBindable {
    let disposeBag = DisposeBag()
    
    let viewWillAppear = PublishRelay<Void>()
    let willDisplayCell = PublishRelay<IndexPath>()
    let cellData: Driver<[ProductListCell.Data]>
    let reloadList: Signal<Void>
    let errorMessage: Signal<String>
    
    private var cells = BehaviorRelay<[Product]>(value: [])
    
    init(model: ProductListModel = ProductListModel()){
        let productListResult = viewWillAppear
            .flatMap(model.getProductList)
            .asObservable()
            .share()
        
        let productListValue = productListResult
            .map { result -> [Product]? in
            print("productListValue 호출")
                guard case .success(let value) = result else {
                    return nil
                }
                print("productListValue 성공")
                return value
            }
            .filterNil()
        
        let productListError = productListResult
            .map { result -> String? in
                guard case .failure(let error) = result else {
                    return nil
                }
                print("productListValue 실패")
                return error.message
            }
            .filterNil()
        
//        Observable
//            .merge(productListValue)
//            .bind(to: cells)
//            .disposed(by: disposeBag)
//
//        self.cellData = cells
//            .map(model.pasrseData)
//            .asDriver(onErrorDriveWith: .empty())

        self.cellData = Observable
            .merge(productListValue)
            .map(model.pasrseData)
            .asDriver(onErrorDriveWith: .empty())

        self.reloadList = Observable
            .merge(productListValue)
            .map { _ in Void() }
            .asSignal(onErrorSignalWith: .empty())

        self.errorMessage = Observable
            .merge(productListError)
            .asSignal(onErrorJustReturn: ProductsNetworkError.defaultError.message ?? "")
    }
}
