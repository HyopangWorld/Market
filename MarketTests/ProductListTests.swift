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
    let network = ProductsNetworkMockUp()
    var viewModel: ProductListViewModel!
    var model: ProductListModel!

    override func setUp() {
        self.model = ProductListModel(productsNetwork: network)
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
        guard let productsData = ProductsDummyData.productsJSONString.data(using: .utf8) else { return }
        guard let product = try? JSONDecoder().decode(ProductResponse<[Product]>.self, from: productsData) else { return }
        guard let data = product.body.first else { return }
        let parsedData = model.parseData(value: [data])
        assert(parsedData.first?.id == 1, "Product List ID Parsing Success")
    }
}
