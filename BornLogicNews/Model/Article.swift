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
	var urlToImage: String?
	var publishedAt: String
	var content: String
	
	var image: UIImage?
	
	init(from article: ArticleObject, usingImageData data: Data? = nil){
		author = article.author
		title = article.title
		description = article.description
		url = article.url
		urlToImage = article.urlToImage ?? ""
		publishedAt = article.publishedAt
		content = article.content
		if let data = data {
			image = UIImage(data: data)
		}
		else {
			image = nil
		}
	}
	
	init(){
		author = "Allan Rosa"
		title = "Welcome to BornNews!"
		description = "To start browsing some news, enter something in Search for News and hit enter!\nYou can also select to receive language specific news (English and Portuguese supported only), as well as sort the news by either Most Popular, Most Recent or Most Relevant. Enjoy!"
		url = ""
		urlToImage = ""
		publishedAt = "2022-04-27T17:00:00Z"
		content = ""
		image = UIImage(named: "logo-transparent")
	}
}
