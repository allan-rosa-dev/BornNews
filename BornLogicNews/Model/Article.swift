//
//  Article.swift
//  BornLogicNews
//
//  Created by Allan Rosa on 12/05/22.
//

import Foundation

struct Article: Decodable {
	let source: Source
	let author: String
	let title: String
	let description: String
	let url: String
	let urlToImage: String
	let publishedAt: String
	let content: String
}

struct Source: Decodable {
	let id: String
	let name: String
}
