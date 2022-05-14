//
//  Article.swift
//  BornLogicNews
//
//  Created by Allan Rosa on 12/05/22.
//

import Foundation
import UIKit

struct Article {
	var author: String?
	var title: String
	var description: String
	var url: String
	var content: String
	
	var image: UIImage?
	var publishDate: Date
	
	init(from article: ArticleObject, usingImageData data: Data? = nil){
		author = article.author
		title = article.title
		description = article.description
		url = article.url
		content = article.content
		
		do {
			publishDate = try Date(article.publishedAt, strategy: .iso8601)
		}
		catch {
			// not handling proper error treatment
			publishDate = Date.now
		}
		
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
		description = "To start browsing some news, type something in Search for News and hit enter or tap the BornNews logo!\n\nYou can also select to receive language specific news (English and Portuguese supported only), as well as sort the news to display either Most Popular, Recent, Relevant ones first. \n\nIf you want to read more details, just tap the article.\n\nEnjoy!"
		url = ""
		publishDate = Date.now
		let dummy = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
		content = "This is the detailed article view!\n\nYou can scroll down this text area to read more, or simply tap the image or publish date to be taken to the original article website. You'll be asked to open it in Safari.\n\n" + dummy + "\n\n" + dummy
		
		image = UIImage(named: "logo-transparent")
	}
}
