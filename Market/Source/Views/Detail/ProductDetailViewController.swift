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
import KRWordWrapLabel

typealias DetailData = (id: Int, thumbnail_720: String, thumbnailList: [String], title: String, seller: String,
    cost: String, discount_cost: String, discount_rate: String, description: String)

protocol ProductDetailBindable {
    var viewWillAppear: PublishRelay<Int> { get }
    var productDetailData: Signal<DetailData> { get }
    var errorMessage: Signal<String> { get }
}

class ProductDetailViewController: ViewController<ProductDetailBindable> {
    let scrollView = UIScrollView()
    let thumbnailView = UIImageView()
    let imageSlider = UIScrollView()
    let progressView = UIProgressView()
    let closeButton = UIButton()
    let sellerLabel = UILabel()
    let titleLabel = KRWordWrapLabel()
    let discountRateLabel = UILabel()
    let costLabel = UILabel()
    let discountCostLabel = UILabel()
    let line = UIView()
    let descriptionLabel = UILabel()
    let noticeView = UIView()
    let buyButton = UIButton()
    
    override func viewDidLoad() {
        attribute()
    }
    
    func bind(_ viewModel: ProductDetailBindable, cell: ProductListCell) {
        self.disposeBag = DisposeBag()
        
        self.rx.viewWillAppear
            .take(1)
            .map { _ in cell.id }
            .filterNil()
            .bind(to: viewModel.viewWillAppear)
            .disposed(by: disposeBag)
        
        viewModel.productDetailData
            .emit(to: self.rx.setData)
            .disposed(by: disposeBag)
        
        viewModel.errorMessage
            .emit(to: self.rx.toast())
            .disposed(by: disposeBag)
        
        closeButton.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: {
                self.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        viewModel.productDetailData.asObservable()
            .subscribe { _ in
                self.view.addSubview(self.thumbnailView)
                UIView.animate(withDuration: 0.3, animations: {
                    let x = (self.view.frame.width - cell.frame.width) / 2
                    self.thumbnailView.snp.makeConstraints {
                        $0.width.equalTo(cell.productImageView.bounds.size.width)
                        $0.height.equalTo(cell.productImageView.bounds.size.height)
                        $0.leading.equalToSuperview().inset(x)
                        $0.top.equalToSuperview().inset(x)
                    }
                    self.thumbnailView.frame = self.thumbnailView.frame.offsetBy(dx: -(cell.origin.x - x),
                                                                                 dy: -(cell.origin.y - x))
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        UIView.animate(withDuration: 0.3, animations: {
                            self.thumbnailView.transform = CGAffineTransform(scaleX: self.view.frame.width/cell.frame.width,
                                                                             y: self.view.frame.width/cell.frame.width)
                        })
                    }
                }, completion: { _ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        self.layout()
                    }
                })
        }
        .disposed(by: disposeBag)
        
        viewModel.productDetailData.asObservable()
            .delay(RxTimeInterval.milliseconds(1500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { _ in
                UIView.animate(withDuration: 0.7, animations: {
                    self.buyButton.frame = self.buyButton.frame.offsetBy(dx: 0, dy: -85)
                }, completion: { (_) in
                    UIView.animate(withDuration: 0.3, animations: {
                        self.buyButton.frame = self.buyButton.frame.offsetBy(dx: 0, dy: 3)
                    }, completion: { (_) in
                        UIView.animate(withDuration: 0.4, animations: {
                            self.buyButton.frame = self.buyButton.frame.offsetBy(dx: 0, dy: -5)
                        }, completion: { (_) in
                            UIView.animate(withDuration: 0.3, animations: {
                                self.buyButton.frame = self.buyButton.frame.offsetBy(dx: 0, dy: 3)
                            })
                        })
                    })
                })
            })
            .disposed(by: disposeBag)
        
        imageSlider.rx.contentOffset
            .map { $0.x / self.imageSlider.frame.width }
            .subscribe {
                let value = Float($0.element! + 1) / Float(self.imageSlider.subviews.filter{ $0 is UIImageView }.count)
                self.progressView.setProgress(value, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    override func attribute() {
        view.backgroundColor = .black
        
        scrollView.do {
            $0.backgroundColor = .white
            $0.showsVerticalScrollIndicator = false
        }
        
        thumbnailView.do {
            $0.layer.cornerRadius = 14
            $0.layer.masksToBounds = true
        }
        
        imageSlider.do {
            $0.isPagingEnabled = true
            $0.bounces = false
            $0.showsHorizontalScrollIndicator = false
        }
        
        progressView.do {
            $0.progressTintColor = .white
            $0.trackTintColor = UIColor(displayP3Red: 0, green: 0, blue: (10/255), alpha: 0.36)
            $0.setProgress(0, animated: true)
        }
        
        closeButton.do {
            $0.backgroundColor = UIColor(displayP3Red: (24/255), green: (24/255), blue: (40/255), alpha: 0.16)
            $0.layer.cornerRadius = 20
            $0.setImage(UIImage(named: "round_close_white.png"), for: .normal)
        }
        
        sellerLabel.do {
            $0.font = .systemFont(ofSize: 14, weight: .bold)
            $0.textColor = UIColor(displayP3Red: (74/255), green: (144/255), blue: (226/255), alpha: 1)
            $0.numberOfLines = 1
        }
        
        titleLabel.do {
            $0.font = .systemFont(ofSize: 40, weight: .bold)
            $0.textColor = UIColor(displayP3Red: (20/255), green: (20/255), blue: (40/255), alpha: 1)
            $0.lineBreakMode = .byWordWrapping
            $0.numberOfLines = 10
        }
        
        discountRateLabel.do {
            $0.font = .systemFont(ofSize: 22, weight: .bold)
            $0.textColor = UIColor(displayP3Red: (255/255), green: (88/255), blue: (108/255), alpha: 1)
            $0.numberOfLines = 1
        }
        
        discountCostLabel.do {
            $0.font = .systemFont(ofSize: 22, weight: .bold)
            $0.textColor = UIColor(displayP3Red: (20/255), green: (20/255), blue: (40/255), alpha: 1)
            $0.numberOfLines = 1
        }
        
        costLabel.do {
            $0.font = .systemFont(ofSize: 22, weight: .bold)
            $0.textColor = UIColor(displayP3Red: (171/255), green: (171/255), blue: (196/255), alpha: 1)
            $0.numberOfLines = 1
        }
        
        line.do {
            $0.backgroundColor = UIColor(displayP3Red: (236/255), green: (236/255), blue: (245/255), alpha: 1)
            $0.layer.cornerRadius = 15
        }
        
        descriptionLabel.do {
            $0.font = .systemFont(ofSize: 16, weight: .bold)
            $0.textColor = UIColor(displayP3Red: (20/255), green: (20/255), blue: (40/255), alpha: 1)
            $0.numberOfLines = 0
        }
        
        noticeView.do {
            $0.backgroundColor = UIColor(displayP3Red: (246/255), green: (246/255), blue: (250/255), alpha: 1)
            $0.layer.cornerRadius = 15
            let notice = UILabel()
            notice.do {
                $0.font = .systemFont(ofSize: 14, weight: .bold)
                $0.textColor = UIColor(displayP3Red: (163/255), green: (163/255), blue: (181/255), alpha: 1)
                $0.numberOfLines = 0
                $0.text = "부랑구마켓은 통신판매중개자이며 통신판매의 당사자가 아닙니다. 따라서 부랑구마켓은 상품 거래정보 및 거래에 대하여 책임을 지지 않습니다."
            }
            noticeView.addSubview(notice)
            notice.snp.makeConstraints {
                $0.edges.equalToSuperview().inset(20)
            }
        }
        
        buyButton.do {
            $0.backgroundColor = UIColor(displayP3Red: (255/255), green: (88/255), blue: (108/255), alpha: 1)
            $0.layer.cornerRadius = 15
            $0.setTitle("구매하기", for: .normal)
            $0.titleLabel?.textColor = .white
            $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        }
    }
    
    override func layout() {
        scrollView.addSubview(imageSlider)
        scrollView.addSubview(progressView)
        scrollView.addSubview(sellerLabel)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(discountRateLabel)
        scrollView.addSubview(discountCostLabel)
        scrollView.addSubview(costLabel)
        scrollView.addSubview(line)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(noticeView)
        view.addSubview(scrollView)
        view.addSubview(closeButton)
        view.addSubview(buyButton)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        imageSlider.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(view.frame.width)
        }
        
        progressView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalTo(imageSlider).inset(24)
            $0.height.equalTo(4)
        }
        
        closeButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(16)
            $0.width.height.equalTo(40)
        }
        
        sellerLabel.snp.makeConstraints {
            $0.top.equalTo(imageSlider.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(26)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(sellerLabel.snp.bottom).offset(16)
            $0.leading.width.equalToSuperview().inset(26)
        }
        
        discountRateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(32)
            $0.leading.equalToSuperview().inset(28)
        }
        
        discountCostLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(32)
            $0.leading.equalTo(discountRateLabel.snp.trailing).offset(10)
        }
        
        costLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(32)
            $0.leading.equalTo(discountCostLabel.snp.trailing).offset(10)
        }
        
        line.snp.makeConstraints {
            $0.top.equalTo(discountRateLabel.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(18)
            $0.height.equalTo(1)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(line.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(33)
        }
        
        noticeView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(33)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(327)
            $0.height.equalTo(96)
            $0.bottom.equalToSuperview().inset(80)
        }
        
        buyButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(-52)
            $0.leading.trailing.equalToSuperview().inset(33)
            $0.height.equalTo(52)
        }
    }
}

extension Reactive where Base: ProductDetailViewController {
    var setData: Binder<DetailData> {
        return Binder(base) { base, data in
            base.thumbnailView.kf.setImage(with: URL(string: data.thumbnail_720), placeholder: UIImage(named: "placeholder"))
            base.imageSlider.contentSize = CGSize(width: base.view.frame.width * CGFloat(data.thumbnailList.count), height: base.view.frame.width)
            base.progressView.setProgress(1.0/Float(data.thumbnailList.count), animated: true)
            for i in 0..<data.thumbnailList.count {
                let imageView = UIImageView()
                imageView.kf.setImage(with: URL(string: data.thumbnailList[i]), placeholder: UIImage(named: "placeholder"))
                base.imageSlider.addSubview(imageView)
                imageView.snp.makeConstraints {
                    $0.top.width.height.equalToSuperview()
                    $0.leading.equalTo(base.view.frame.width * CGFloat(i))
                }
            }
            
            base.sellerLabel.text = data.seller
            base.titleLabel.text = data.title
            base.descriptionLabel.text = data.description
            base.discountRateLabel.text = "-\(data.discount_rate)"
            base.discountCostLabel.text = data.discount_cost
            
            let cost = NSMutableAttributedString(string: data.cost)
            cost.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, cost.length))
            base.costLabel.attributedText = cost
            
            if data.discount_rate == "" {
                base.discountRateLabel.text = data.cost
                base.discountRateLabel.textColor = UIColor(displayP3Red: (20/255), green: (20/255), blue: (40/255), alpha: 1)
                base.discountCostLabel.text = ""
                base.costLabel.text = ""
            }
        }
    }
}
