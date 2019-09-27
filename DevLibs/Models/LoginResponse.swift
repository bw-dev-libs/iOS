//
//  LoginResponse.swift
//  DevLibs Build Week 2
//
//  Created by Ciara Beitel and Marc Jacques on 9/27/19.
//  Copyright © 2019 Ciara Beitel and Marc Jacques. All rights reserved.
//

import Foundation

struct LoginResponse: Codable {
    let token: String
    let user: Int
}
