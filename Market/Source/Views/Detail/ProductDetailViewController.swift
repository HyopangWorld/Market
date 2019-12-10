//
//  ProductDetailViewController.swift
//  Market
//
//  Created by 김효원 on 10/12/2019.
//  Copyright © 2019 김효원. All rights reserved.
//

import Foundation
import UIKit

protocol ProductDetailBindable {
    var id: Int { get }
}

class ProductDetailViewController: UIViewController {
    
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
    
    func bind(_ viewModel: ProductDetailBindable) {
        
    }
    
    func attribute() {
        view.backgroundColor = .white
    }
    
    func layout() {
        
    }
}
