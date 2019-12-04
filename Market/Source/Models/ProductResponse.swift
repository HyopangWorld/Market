//
//  ProductResponse.swift
//  Market
//
//  Created by 김효원 on 04/12/2019.
//  Copyright © 2019 김효원. All rights reserved.
//

import Foundation

struct ProductResponse<T: Codable>: Codable {
    let statusCode: Int
    let body: T
}
