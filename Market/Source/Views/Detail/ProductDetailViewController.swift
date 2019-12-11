//
//  ProductDetailViewController.swift
//  Market
//
//  Created by 김효원 on 10/12/2019.
//  Copyright © 2019 김효원. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxAppState
import RxDataSources
import SnapKit
import Then

typealias DetailData = (id: Int, thumbnail_720: String, thumbnailList: [String], title: String, seller: String,
    cost: String, discount_cost: String, discount_rate: String, description: String)

protocol ProductDetailBindable {
    var id: Int { get }
    var viewWillAppear: PublishRelay<Int> { get }
    var productDetailData: Signal<DetailData> { get }
    var errorMessage: Signal<String> { get }
}

class ProductDetailViewController: ViewController<ProductDetailBindable> {
    let imageSlider = UIScrollView()
    
    override func bind(_ viewModel: ProductDetailBindable) {
        self.disposeBag = DisposeBag()
        
        self.rx.viewWillAppear
            .take(1)
            .map { _ in viewModel.id }
            .bind(to: viewModel.viewWillAppear)
            .disposed(by: disposeBag)
        
        viewModel.productDetailData
            .emit(to: self.rx.setData)
            .disposed(by: disposeBag)
        
        viewModel.errorMessage
            .emit(to: self.rx.toast())
            .disposed(by: disposeBag)
    }
    
    override func attribute() {
        view.backgroundColor = .white
        
        imageSlider.do {
            $0.backgroundColor = .brown
            $0.isPagingEnabled = true
            $0.showsVerticalScrollIndicator = false
            $0.bounces = false
        }
    }
    
    override func layout() {
        view.addSubview(imageSlider)
        
        imageSlider.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(375)
        }
    }
}

extension Reactive where Base: ProductDetailViewController {
    var setData: Binder<DetailData> {
        return Binder(base) { base, data in
            base.imageSlider.contentSize = CGSize(width: base.view.frame.width * CGFloat(data.thumbnailList.count), height: 375)
            
            for i in 0..<data.thumbnailList.count {
                let imageView = UIImageView()
                imageView.kf.setImage(with: URL(string: data.thumbnailList[i]))
                base.imageSlider.addSubview(imageView)
                
                imageView.snp.makeConstraints {
                    $0.top.width.equalToSuperview()
                    $0.leading.equalTo(base.view.frame.width * CGFloat(i))
                    $0.height.equalTo(375)
                }
            }
            
        }
    }
}
