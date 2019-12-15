//
//  ProductDetailTest.swift
//  MarketTests
//
//  Created by 김효원 on 15/12/2019.
//  Copyright © 2019 김효원. All rights reserved.
//

import RxSwift
import XCTest
@testable import Market

class ProductDetailTests: XCTestCase {
    let disposeBag = DisposeBag()
    let networkMock = ProductsNetworkMockUp()
    var viewModel: ProductDetailViewModel!
    var model: ProductDetailModel!

    override func setUp() {
        self.model = ProductDetailModel(productsNetwork: networkMock)
        self.viewModel = ProductDetailViewModel(model: model)
    }

    func testProductList() {
        model.getProductDetail(id: 1)
            .subscribe(onNext: { result in
                let products = try? result.get()
                assert(products != nil, "Product Detail Getting Success")
            })
            .disposed(by: disposeBag)
    }
    
    func testParseData() {
        let productsData = ProductsDummyData.productsJSONString.data(using: .utf8)!
        let product = try! JSONDecoder().decode(ProductResponse<[Product]>.self, from: productsData)
        let parsedData = model.parseData(value: [product.body.first!])
        assert(parsedData?.id == 1, "Product Detail ID Parsing Success")
    }
}
