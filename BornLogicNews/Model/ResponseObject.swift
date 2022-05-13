//
//  ResponseObject.swift
//  BornLogicNews
//
//  Created by Allan Rosa on 12/05/22.
//

import Foundation

struct ResponseObject: Decodable {
	let status: String
	let totalResults: Int
	let articles: [Article]
}
