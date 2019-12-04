//
//  ViewController.swift
//  Market
//
//  Created by 김효원 on 02/12/2019.
//  Copyright © 2019 김효원. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxAppState
import SnapKit
import Then
import Toaster

protocol ProductListViewBindable {
    var viewWillAppear: PublishSubject<Void> { get }
    var willDisplayCell: PublishRelay<IndexPath> { get }
    
    var cellData: Driver<[ProductListCell.Data]> { get }
    var reloadList: Signal<Void> { get }
    var errorMessage: Signal<String> { get }
}

class ProductListViewController: UIViewController {
    var disposeBag = DisposeBag()
    
    let collectionView = UICollectionView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder:) is not implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    func bind(_ viewModel: ProductListViewBindable) {
        self.disposeBag = DisposeBag()
        
        // 해당 뷰가 나타나면 viewModel에 viewWillAppear 실행
        self.rx.viewWillAppear
            .map { _ in Void() }
            .bind(to: viewModel.viewWillAppear)
            .disposed(by: disposeBag)
        
        // collectionView가 나타나면 viewModel에 willDisplayCell 실행
        collectionView.rx.willDisplayCell
            .map { $0.at }
            .bind(to: viewModel.willDisplayCell)
            .disposed(by: disposeBag)
        
        viewModel.cellData
            .drive(collectionView.rx.items) { collection, row, data in
                let index = IndexPath(row: row, section: 0)
                let cell = collection.dequeueReusableCell(withReuseIdentifier: String(describing: ProductListCell.self), for: index) as! ProductListCell
                cell.setData(data: data)
                return cell
        }
        .disposed(by: disposeBag)
        
        viewModel.errorMessage
            .emit(onNext: {
                Toast(text: $0, delay: 0, duration: 1).show()
            })
            .disposed(by: disposeBag)
    }
    
    func attribute() {
        view.backgroundColor = .white
        navigationController?.navigationBar.frame = CGRect.init(x: 0, y: 0, width: view.frame.width, height: 60)
        
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: (navigationController?.navigationBar.frame.height)!, width: view.frame.width, height: 5)
        gradient.colors = [
            UIColor(displayP3Red: CGFloat(24/255), green: CGFloat(24/255), blue: CGFloat(80/255), alpha: 0.12).cgColor,
            UIColor.white
        ]
        navigationController?.navigationBar.layer.addSublayer(gradient)
        
        let navAppearance = UINavigationBarAppearance()
        navAppearance.shadowColor = nil
        navigationController?.navigationBar.standardAppearance = navAppearance
        
        let titleImg = UIImageView(image: UIImage(named: "baseline_storefront_black.png"))
        navigationController?.navigationBar.addSubview(titleImg)
        
        titleImg.snp.makeConstraints {
            $0.width.equalTo(23)
            $0.height.equalTo(23)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo((navigationController?.navigationBar.snp.bottom)!).offset(5)
        }
        
        collectionView.do {
            $0.backgroundView = UIView()
            $0.backgroundView?.isHidden = true
            $0.backgroundColor = .white
            $0.register(ProductListCell.self, forCellWithReuseIdentifier: String(describing:ProductListCell.self))
        }
    }
    
    func layout(){
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}


extension UINavigationBar {
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 200)
    }
}
