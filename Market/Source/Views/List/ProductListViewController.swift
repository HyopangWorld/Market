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

protocol ProductListViewBindable {
    var viewWillAppear: PublishRelay<Int> { get }
    var viewWillFetch: PublishRelay<Int> { get }
    
    var cellData: Driver<[ProductListCell.Data]> { get }
    var reloadList: Signal<Void> { get }
    var errorMessage: Signal<String> { get }
}

class ProductListViewController: ViewController<ProductListViewBindable> {
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var indicator = UIImageView()
    private var windowHeight: CGFloat = 0
    private var page = 1
    
    override func bind(_ viewModel: ProductListViewBindable) {
        self.disposeBag = DisposeBag()
        
        self.rx.viewWillAppear
            .map { _ in 1 }
            .bind(to: viewModel.viewWillAppear)
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
                self?.indicator.snp.updateConstraints {
                    $0.bottom.equalToSuperview().offset((self?.collectionView.collectionViewLayout.collectionViewContentSize.height ?? 0) - 20)
                }
                self?.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel.errorMessage
            .emit(to: self.rx.toast())
            .disposed(by: disposeBag)
        
        collectionView.rx.contentOffset
            .skipUntil(viewModel.reloadList.asObservable())
            .filter { offset -> Bool in
                let height = self.collectionView.collectionViewLayout.collectionViewContentSize.height - self.collectionView.frame.height + self.windowHeight
                return Int(offset.y - height) == 0
            }
            .map{ Int($0.y) }
            .distinct()
            .delay(RxTimeInterval.seconds(3), scheduler: MainScheduler.instance)
            .map { y -> Int in
                self.page += 1
                return self.page
            }
            .bind(to: viewModel.viewWillFetch)
            .disposed(by: disposeBag)
        
        collectionView.rx.itemSelected
            .subscribe { event in
                guard let indexpath = event.element else { return }
                guard let cell = (self.collectionView.cellForItem(at: indexpath) as? ProductListCell) else { return }
                let x = cell.frame.origin.x + 12 - 114
                let y = cell.frame.origin.y + self.windowHeight - 119 - self.collectionView.contentOffset.y
                cell.origin = CGPoint(x: x, y: y)
                
                let detailViewController = ProductDetailViewController()
                let detailViewModel = ProductDetailViewModel(cell: cell)
                detailViewController.bind(detailViewModel)
                
                self.present(detailViewController, animated: false, completion: nil)
            }
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
        titleImg.tintColor = .black
        navigationController?.navigationBar.addSubview(titleImg)
        titleImg.snp.makeConstraints {
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
            $0.image = UIImage(named: "outline_explore_black.png")
            $0.tintColor = UIColor(displayP3Red: (171/255), green: (171/255), blue: (196/255), alpha: 1)
            $0.layer.masksToBounds = true
            
            let animationGroup = CAAnimationGroup()
            animationGroup.duration = 1.5
            animationGroup.repeatCount = .infinity

            let pulseAnimation = CABasicAnimation(keyPath: "transform.rotation")
            pulseAnimation.toValue = 0.0
            pulseAnimation.fromValue = -Double.pi * 2
            pulseAnimation.duration = 0.2
            pulseAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
            
            let pulseAnimation2 = CABasicAnimation(keyPath: "transform.rotation")
            pulseAnimation2.toValue = 0.0
            pulseAnimation2.fromValue = -Double.pi * 2
            pulseAnimation2.duration = 0.5
            pulseAnimation2.timingFunction = CAMediaTimingFunction(name: .easeOut)

            animationGroup.animations = [pulseAnimation2, pulseAnimation]
            
            $0.layer.add(animationGroup, forKey: nil)
        }
    }
    
    override func layout(){
        collectionView.addSubview(indicator)
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
        
        indicator.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(23)
        }
    }
}
