//
//  Qiita.swift
//  QiitaAPI
//
//  Created by 大西玲音 on 2021/03/23.
//

struct Qiita: Decodable {
    let title: String
    let createdAt: String
    let user: User
    
    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case createdAt = "created_at"
        case user = "user"
    }
}

struct User: Decodable {
    let name: String
    let profileImageUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case profileImageUrl = "profile_image_url"
    }
}
