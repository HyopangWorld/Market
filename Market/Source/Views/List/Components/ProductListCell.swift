//
//  ProductCell.swift
//  Market
//
//  Created by 김효원 on 03/12/2019.
//  Copyright © 2019 김효원. All rights reserved.
//

import UIKit

import SnapKit
import Kingfisher

class ProductListCell: UICollectionViewCell {
    typealias Data = (id: Int, thumbnailURL: String, title: String, seller: String)
    
    let productImageView = UIImageView()
    let titleLabel = UILabel()
    let sellerLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(data: Data) {
        productImageView.do {
            $0.kf.setImage(with: URL(string: data.thumbnailURL))
            $0.snp.updateConstraints {
                $0.top.bottom.equalToSuperview().inset(26)
                $0.left.equalToSuperview()
                $0.width.height.equalTo(50)
            }
        }
        
        titleLabel.do {
            $0.text = data.title
        }
        
        sellerLabel.do {
            $0.text = data.seller
        }
    }
    
    func attribute() {
        productImageView.do {
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFit
        }
        
        titleLabel.do {
            $0.font = .systemFont(ofSize: 14, weight: .bold)
            $0.textColor = UIColor(displayP3Red: (20/255), green: (20/255), blue: (40/255), alpha: 1)
        }
        
        sellerLabel.do {
            $0.font = .systemFont(ofSize: 14, weight: .light)
            $0.textColor = UIColor(displayP3Red: (171/255), green: (171/255), blue: (196/255), alpha: 1)
        }
    }
    
    func layout() {
        addSubview(productImageView)
        addSubview(titleLabel)
        addSubview(sellerLabel)
        
        productImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(16)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(productImageView.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        
        sellerLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(1)
            $0.centerX.equalToSuperview()
        }
    }
}