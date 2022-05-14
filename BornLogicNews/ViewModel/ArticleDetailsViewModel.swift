//
//  ArticleDetailsViewModel.swift
//  BornLogicNews
//
//  Created by Allan Rosa on 14/05/22.
//

import Foundation
import UIKit

protocol ArticleDetailsViewModelProtocol {
	var title: String { get }
	var image: UIImage? { get }
	var content: String { get }
	var publishDate: Date { get }
	var url: URL? { get }
}

struct ArticleDetailsViewModel: ArticleDetailsViewModelProtocol {
	var title: String = ""
	var image: UIImage? = nil
	var content: String = ""
	var publishDate: Date = Date.now
	var url: URL? = nil
	
	init(from article: Article){
		title = article.title
		image = article.image
		content = article.content
		publishDate = article.publishDate
		url = URL(string: article.url)
	}
}
