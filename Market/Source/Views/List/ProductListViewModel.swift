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
    let dissposeBag = DisposeBag()
    
    let viewWillAppear: PublishSubject<Void>
    let willDisplayCell: PublishRelay<IndexPath>
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
        
        
        let shouldMoreFatch = Observable
            .combineLatest(willDisplayCell, cells) { (indexPath: $0, list: $1) }
            .map { data -> Int? in
                guard data.list.count > 20 else {
                    return nil
                }
                
                let lastCellCount = data.list.count
                if (lastCellCount - 1) == data.indexPath.row {
                    return data.indexPath.row
                }
                
                return nil
            }
            .filterNil()
        
        let fetchedResult = shouldMoreFatch
            .distinctUntilChanged()
            .flatMapLatest(model.fetchMoreData)
            .asObservable()
            .share()
        
        let fetchedList = fetchedResult
            .map { result -> [Product]? in
                guard case .success(let value) = result else {
                    return nil
                }
                return value
            }
            .filterNil()
        
        let fetchedError = fetchedResult
            .map { result -> String? in
                guard case .failure(let error) = result else {
                    return nil
                }
                return error.message
            }
            .filterNil()
        
        Observable
            .merge(productListValue, fetchedList)
            .scan([]){ prev, newList in
                return newList.isEmpty ? [] : prev + newList
            }
            .bind(to: cells)
            .disposed(by: dissposeBag)
        
        self.cellData = cells
            .map(model.pasrseData)
            .asDriver(onErrorDriveWith: .empty())
        
        self.reloadList = Observable
            .zip(productListValue, fetchedList)
            .map { _ in Void() }
            .asSignal(onErrorSignalWith: .empty())
        
        self.errorMessage = Observable
            .merge(productListError, fetchedError)
            .asSignal(onErrorJustReturn: ProductsApiError.defaultError.message ?? "")
    }
}
