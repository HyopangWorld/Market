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
    
    init(model: ProductListModel = ProductListModel()){
        let productListResult = viewWillAppear
            .flatMap(model.getProductList)
            .asObservable()
            .share()
        
        let productListValue = productListResult
            .map { result -> [Product]? in
                guard case .success(let value) = result else {
                    return nil
                }
                return value
            }
            .filterNil()
        
        let productListError = productListResult
            .map { result -> String? in
                guard case .failure(let error) = result else {
                    return nil
                }
                return error.message
            }
            .filterNil()
        
        let fetchMore = willDisplayCell
            .filter { $0.row % 50 >= 49 }
            .map { return ($0.row/50) + 2 }
        
        let fetchListResult = fetchMore
            .distinctUntilChanged()
            .flatMapLatest(model.getProductList(page:))
            .asObservable()
            .share()
        
        let fetchListValue = fetchListResult
            .map { result -> [Product]? in
                guard case .success(let value) = result else {
                    return nil
                }
                return value
            }
            .filterNil()
        
        let fetchListError = fetchListResult
            .map { result -> String? in
                guard case .failure(let error) = result else {
                    return nil
                }
                return error.message
            }
            .filterNil()

        self.cellData = Observable
            .merge(productListValue, fetchListValue)
            .scan([]){ prev, newList in
                return newList.isEmpty ? [] : prev + newList
            }
            .map(model.pasrseData)
            .asDriver(onErrorDriveWith: .empty())

        self.reloadList = Observable
            .zip(productListValue, fetchListValue)
            .map { _ in Void() }
            .asSignal(onErrorSignalWith: .empty())

        self.errorMessage = Observable
            .merge(productListError, fetchListError)
            .asSignal(onErrorJustReturn: ProductsNetworkError.defaultError.message ?? "")
    }
}
