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
    let network = ProductsNetworkMockUp()
    var viewModel: ProductDetailViewModel!
    var model: ProductDetailModel!

    override func setUp() {
        self.model = ProductDetailModel(productsNetwork: network)
        self.viewModel = ProductDetailViewModel(model: model)
    }

    func testProductDetail() {
        model.getProductDetail(id: 1)
            .subscribe(onNext: { result in
                let product = try? result.get()
                assert(product != nil, "Product Detail Getting Success")
            })
            .disposed(by: disposeBag)
    }
    
    func testParseDetail() {
        let productData = ProductsDummyData.productJSONString.data(using: .utf8)!
        let product = try! JSONDecoder().decode(ProductResponse<[Product]>.self, from: productData)
        let parsedData = model.parseData(value: [product.body.first!])
        assert(parsedData?.id == 1, "Product Detail ID Parsing Success")
    }
}
