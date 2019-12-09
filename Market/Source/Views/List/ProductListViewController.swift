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
    var viewWillAppear: PublishRelay<Void> { get }
    var willDisplayCell: PublishRelay<IndexPath> { get }
    
    var cellData: Driver<[ProductListCell.Data]> { get }
    var reloadList: Signal<Void> { get }
    var errorMessage: Signal<String> { get }
}

class ProductListViewController: UIViewController {
    var disposeBag = DisposeBag()
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
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
        
        self.rx.viewWillAppear
            .map { _ in Void() }
            .bind(to: viewModel.viewWillAppear)
            .disposed(by: disposeBag)
        
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
        
        viewModel.reloadList
            .emit(onNext: { [weak self] _ in
                print("reloadList")
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
    
    func attribute() {
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
            $0.width.equalTo(23)
            $0.height.equalTo(21)
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    func layout(){
        view.addSubview(collectionView)
        
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        let height = navigationController!.navigationBar.bounds.height + (window?.safeAreaInsets.top ?? 0) + 24
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(height)
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().inset(12)
            $0.bottom.equalToSuperview()
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.do {
            $0.scrollDirection = .vertical
            let size = view.frame.width / 2 - (12 + 3.5)  // 옆 마진 + 가운데 간격
            $0.itemSize = CGSize(width: size, height: size + 64)
            $0.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            $0.minimumLineSpacing = 24
            $0.minimumInteritemSpacing = 3.5
        }
        
        collectionView.do {
            $0.backgroundView = UIView()
            $0.backgroundView?.isHidden = true
            $0.backgroundColor = .white
            $0.register(ProductListCell.self, forCellWithReuseIdentifier: String(describing:ProductListCell.self))
            $0.setCollectionViewLayout(layout, animated: true)
        }
    }
}
