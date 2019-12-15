//
//  MarketTests.swift
//  MarketTests
//
//  Created by 김효원 on 02/12/2019.
//  Copyright © 2019 김효원. All rights reserved.
//

import RxSwift
import XCTest
@testable import Market

class ProductListTests: XCTestCase {
    let disposeBag = DisposeBag()
    let networkMock = ProductSNetworkMockUp()
    var viewModel: ProductListViewModel!
    var model: ProductListModel!

    override func setUp() {
        self.model = ProductListModel(productsNetwork: networkMock)
        self.viewModel = ProductListViewModel(model: model)
    }

    func testProductList() {
        model.getProductList(page: 1)
            .subscribe(onNext: { result in
                let products = try? result.get()
                assert(products != nil, "Product List Getting Success")
            })
            .disposed(by: disposeBag)
    }
    
    func testParseData() {
        let productsData = ProductsDummyData.productsJSONString.data(using: .utf8)!
        let product = try! JSONDecoder().decode(ProductResponse<[Product]>.self, from: productsData)
        let parsedData = model.parseData(value: [product.body.first!])
        assert(parsedData.first?.id == 1, "Product List ID Parsing Success")
    }
}
