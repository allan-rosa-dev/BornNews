//
//  Article.swift
//  BornLogicNews
//
//  Created by Allan Rosa on 12/05/22.
//

import Foundation
import UIKit

struct Article: ArticleObjectProtocol {
	var author: String?
	var title: String
	var description: String
	var url: String
	var urlToImage: String
	var publishedAt: String
	var content: String
	
	var image: UIImage?
	
	init(from article: ArticleObject, usingImageData data: Data){
		author = article.author
		title = article.title
		description = article.description
		url = article.url
		urlToImage = article.urlToImage
		publishedAt = article.publishedAt
		content = article.content
		image = UIImage(data: data)
	}
}
