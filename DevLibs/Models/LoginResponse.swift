//
//  LoginResponse.swift
//  DevLibs
//
//  Created by Ciara Beitel on 9/25/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import Foundation

struct LoginResponse: Codable {
    let token: String
    let user: Int
}
