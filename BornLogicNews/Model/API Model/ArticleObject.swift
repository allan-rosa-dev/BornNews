//
//  Article.swift
//  BornLogicNews
//
//  Created by Allan Rosa on 12/05/22.
//

import Foundation

protocol ArticleObjectProtocol {
	var author: String? { get }
	var title: String { get }
	var description: String { get }
	var url: String { get }
	var urlToImage: String? { get }
	var publishedAt: String { get }
	var content: String { get }
}

struct ArticleObject: Decodable {
	let author: String?
	let title: String
	let description: String
	let url: String
	let urlToImage: String?
	let publishedAt: String
	let content: String
}
