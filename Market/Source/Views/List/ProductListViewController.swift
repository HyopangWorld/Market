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
import RxDataSources
import SnapKit
import Then
import Toaster

protocol ProductListViewBindable {
    var viewWillAppear: PublishRelay<Int> { get }
    var viewWillFetch: PublishRelay<Int> { get }
    
    var cellData: Driver<[ProductListCell.Data]> { get }
    var reloadList: Signal<Void> { get }
    var errorMessage: Signal<String> { get }
}

class ProductListViewController: ViewController<ProductListViewBindable> {
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var indicator = UIActivityIndicatorView()
    private var windowHeight: CGFloat = 0
    private var page = 1
    
    override func bind(_ viewModel: ProductListViewBindable) {
        self.disposeBag = DisposeBag()
        
        self.rx.viewWillAppear
            .map { _ in 1 }
            .bind(to: viewModel.viewWillAppear)
            .disposed(by: disposeBag)
        
        collectionView.rx.contentOffset
            .skipUntil(viewModel.reloadList.asObservable())
            .filter { offset -> Bool in
                let height = self.collectionView.collectionViewLayout.collectionViewContentSize.height - self.collectionView.frame.height + self.windowHeight
                return Int(offset.y - height) == 0
            }
            .map{ Int($0.y) }
            .distinct()
            .map { y -> Int in
                self.indicator.startAnimating()
                self.page += 1
                return self.page
            }
            .bind(to: viewModel.viewWillFetch)
            .disposed(by: disposeBag)
        
        collectionView.rx.itemSelected
            .subscribe { indexpath in
                guard let row = indexpath.element?.row else {
                    return
                }
                
                let detailViewController = ProductDetailViewController()
                let detailViewModel = ProductDetailViewModel(id: row)
                detailViewController.bind(detailViewModel)
                
                self.present(detailViewController, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
        
        viewModel.cellData
            .drive(collectionView.rx.items) { collection, row, data in
                let index = IndexPath(row: row, section: 0)
                let cell = collection.dequeueReusableCell(withReuseIdentifier: String(describing: ProductListCell.self), for: index) as! ProductListCell
                cell.setData(data: data)
                return cell
        }
        .disposed(by: disposeBag)
        
        viewModel.reloadList
            .emit(onNext: { [weak self] _ in
                self?.indicator.stopAnimating()
                self?.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel.errorMessage
            .emit(onNext: {
                print("[ERROR] : \($0)")
                Toast(text: $0, delay: 0, duration: 1).show()
            })
            .disposed(by: disposeBag)
    }
    
    override func attribute() {
        view.backgroundColor = .white
        
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: navigationController!.navigationBar.frame.height, width: view.frame.width, height: 5)
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
            $0.width.equalTo(25)
            $0.height.equalTo(24)
            $0.centerX.centerY.equalToSuperview()
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.do {
            $0.scrollDirection = .vertical
            let size = view.frame.width / 2 - (12 + 3.5)  // 옆 마진 + 가운데 간격
            $0.itemSize = CGSize(width: size, height: size + 20 + 60)
            $0.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            $0.minimumLineSpacing = 24
            $0.minimumInteritemSpacing = 3.5
            $0.headerReferenceSize = CGSize(width: view.bounds.width, height: 24)
            $0.footerReferenceSize = CGSize(width: view.bounds.width, height: 96)
        }
        
        collectionView.do {
            $0.backgroundView = UIView()
            $0.backgroundView?.isHidden = true
            $0.backgroundColor = .white
            $0.register(ProductListCell.self, forCellWithReuseIdentifier: String(describing:ProductListCell.self))
            $0.setCollectionViewLayout(layout, animated: true)
        }
        
        indicator.do {
            $0.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            $0.center = view.center
            $0.hidesWhenStopped = true
            $0.style = .large
        }
    }
    
    override func layout(){
        view.addSubview(collectionView)
        
        windowHeight = (UIApplication.shared.windows.first { $0.isKeyWindow })?.safeAreaInsets.top ?? 0
        let height = navigationController!.navigationBar.bounds.height + windowHeight
        windowHeight = windowHeight == 20 ? 0 : windowHeight
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(height)
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().inset(12)
            $0.bottom.equalToSuperview()
        }
        
        view.addSubview(indicator)
        indicator.snp.makeConstraints {
            $0.bottom.equalTo(collectionView.snp.bottom).inset(50)
            $0.centerX.equalToSuperview()
        }
    }
}
