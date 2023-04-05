//
//  UserInfo.swift
//  online-store
//
//  Created by Odin Grav on 24/03/2023.
//

import Foundation

struct User: Codable, Identifiable {
    var id: Int?
    var username: String?
    var email: String?
    var firstName: String?
    var lastName: String?
    var gender: String?
    var image: URL?
    var token: String?
    var phone: String?
    var address: Address?
    var age: Int?
    var birthDate: String?
    var password: String?
    var bank: Bank?
}

struct Address: Codable {
    var address: String?
    var city: String?
}

struct Bank: Codable {
    var cardExpire: String?
    var cartNumber: String?
    var cardType: String?
    var currency: String
    var iban: String?
}
