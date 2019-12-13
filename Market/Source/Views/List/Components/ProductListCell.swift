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
import KRWordWrapLabel

class ProductListCell: UICollectionViewCell {
    typealias Data = (id: Int, thumbnail_520: String, title: String, seller: String)
    
    var id: Int?
    let productImageView = UIImageView()
    let titleLabel = KRWordWrapLabel()
    let sellerLabel = UILabel()
    var origin = CGPoint(x: 0, y: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(data: Data) {
        self.id = data.id
        
        titleLabel.do {
            $0.text = data.title
        }
        
        sellerLabel.do {
            $0.text = data.seller
        }
        
        productImageView.do {
            $0.kf.setImage(with: URL(string: data.thumbnail_520))
            $0.snp.updateConstraints {
                $0.top.leading.trailing.equalToSuperview()
                $0.width.equalToSuperview()
                $0.height.equalToSuperview().inset(40)
            }
            $0.layer.cornerRadius = 14
        }
    }
    
    func attribute() {
        productImageView.do {
            $0.clipsToBounds = true
            $0.contentMode = .scaleToFill
        }
        
        titleLabel.do {
            $0.font = .systemFont(ofSize: 16, weight: .bold)
            $0.textColor = UIColor(displayP3Red: (20/255), green: (20/255), blue: (40/255), alpha: 1)
            $0.numberOfLines = 2
            $0.lineBreakMode = .byWordWrapping
        }
        
        sellerLabel.do {
            $0.font = .systemFont(ofSize: 16, weight: .bold)
            $0.textColor = UIColor(displayP3Red: (171/255), green: (171/255), blue: (196/255), alpha: 1)
            $0.numberOfLines = 1
        }
    }
    
    func layout() {
        addSubview(productImageView)
        addSubview(titleLabel)
        addSubview(sellerLabel)
        
        productImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().inset(40)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(productImageView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(8)
        }

        sellerLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(2)
            $0.leading.trailing.equalToSuperview().inset(8)
        }
    }
}
