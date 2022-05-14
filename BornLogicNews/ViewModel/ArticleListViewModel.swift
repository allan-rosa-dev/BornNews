//
//  ArticleListViewModel.swift
//  BornLogicNews
//
//  Created by Allan Rosa on 13/05/22.
//

import Foundation

protocol ArticleListViewModelProtocol {
	var articles: [Article] { get }
	var isFetching: Bool { get }
	
	func fetchArticles(searchingFor searchText: String, in language: Language?, sortingBy sortParameter: QuerySortParameter?, completion: @escaping ()->())
}

final class ArticleListViewModel: ArticleListViewModelProtocol {
	var articles: [Article] = []
	var isFetching: Bool = false
	
	func fetchArticles(searchingFor searchText: String, in language: Language? = nil, sortingBy sortParameter: QuerySortParameter? = nil, completion: @escaping ()->() ){
		guard !searchText.isEmpty else { return }
		guard !isFetching else { return }
		
		//		articles = [
		//			Article(author: "Dude", title: "McDude is pog", description: "This is some big ass text which should go on for a good while and make it very long for random purposes which I don't like but also kinda think it's very much necessary", url: "lol", urlToImage: "lol", publishedAt: "somedate", content: "bruh"),
		//			Article(author: nil, title: "RickRolled", description: "Never gonna give you up\nNever gonna let you down\nNever gonna turn around\nAnd desert you\nNever gonna make you cry\nNever gonna say goodbye\nNever gonna tell a lie", url: "lol", urlToImage: "lol", publishedAt: "somedate2", content: "lmao")
		//		]
		
		isFetching = true
		NewsService.shared.fetchNews(searchingFor: searchText, inLanguage: language, sortedBy: sortParameter) { [weak self] fetchedArticles in
			guard let self = self else { return }
			self.isFetching = false
			
			fetchedArticles.forEach { articleObject in
				if let url = URL(string: articleObject.urlToImage) {
					DispatchQueue.global().async { [weak self] in
						guard let self = self else { return }
						if let data = try? Data(contentsOf: url){
							self.articles.append(Article(from: articleObject, usingImageData: data))
							DispatchQueue.main.async {
								completion()
							}
						}
					}
				}
			}
		}
	}
}
