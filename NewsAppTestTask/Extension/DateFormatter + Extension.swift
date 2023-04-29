//
//  DateFormatter + Extension.swift
//  NewsAppTestTask
//
//  Created by Артем Орлов on 29.04.2023.
//

import Foundation

extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
}
