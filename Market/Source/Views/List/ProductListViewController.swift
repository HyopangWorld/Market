//
//  ViewController.swift
//  Market
//
//  Created by 김효원 on 02/12/2019.
//  Copyright © 2019 김효원. All rights reserved.
//

import Foundation
import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then

class ProductListViewController: UIViewController {
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
