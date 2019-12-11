//
//  Product.swift
//  Market
//
//  Created by 김효원 on 02/12/2019.
//  Copyright © 2019 김효원. All rights reserved.
//

import Foundation

struct Product: Codable {
    let id: Int?
    let title, seller, cost, discount_cost, discount_rate, description: String?
    let thumbnail_520, thumbnail_720: String?
    let thumbnailList: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id, title, seller, cost, discount_cost, discount_rate, description
        case thumbnail_520, thumbnail_720
        case thumbnailList = "thumbnaillist320"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try? values.decode(Int.self, forKey: .id)
        self.title = try? values.decode(String.self, forKey: .title)
        self.seller = try? values.decode(String.self, forKey: .seller)
        self.cost = try? values.decode(String.self, forKey: .cost)
        self.discount_cost = try? values.decode(String.self, forKey: .discount_cost)
        self.discount_rate = try? values.decode(String.self, forKey: .discount_rate)
        self.description = try? values.decode(String.self, forKey: .description)
        self.thumbnail_520 = try? values.decode(String.self, forKey: .thumbnail_520)
        self.thumbnail_720 = try? values.decode(String.self, forKey: .thumbnail_720)
        
        let list = try? values.decode(String.self, forKey: .thumbnailList)
        self.thumbnailList = list?.split(separator: "#").map{ String($0) }
    }
}


