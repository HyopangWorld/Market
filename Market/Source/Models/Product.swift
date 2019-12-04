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
    let thumbnailURL, title, seller: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, seller
        case thumbnailURL = "thumbnail_520"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try? values.decode(Int.self, forKey: .id)
        self.title = try? values.decode(String.self, forKey: .title)
        self.seller = try? values.decode(String.self, forKey: .seller)
        self.thumbnailURL = try? values.decode(String.self, forKey: .thumbnailURL)
    }
}
