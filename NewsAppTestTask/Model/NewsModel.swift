//
//  NewsModel.swift
//  NewsAppTestTask
//
//  Created by Артем Орлов on 27.04.2023.
//

struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [News]
}

struct News: Codable {
    let title: String
    let author: String?
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String?
}

extension News: Equatable {
    static func == (lhs: News, rhs: News) -> Bool {
        return lhs.title == rhs.title &&
               lhs.author == rhs.author &&
               lhs.description == rhs.description &&
               lhs.url == rhs.url &&
               lhs.urlToImage == rhs.urlToImage &&
               lhs.publishedAt == rhs.publishedAt
    }
}
