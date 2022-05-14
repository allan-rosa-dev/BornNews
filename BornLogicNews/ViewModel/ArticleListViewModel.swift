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
	var articles: [Article] = [Article()]
	var isFetching: Bool = false
	
	func fetchArticles(searchingFor searchText: String, in language: Language? = nil, sortingBy sortParameter: QuerySortParameter? = nil, completion: @escaping ()->() ){
		guard !searchText.isEmpty else { return }
		guard !isFetching else { return }
		
		isFetching = true
		articles = []
		NewsService.shared.fetchNews(searchingFor: searchText, inLanguage: language, sortedBy: sortParameter) { [weak self] fetchedArticles in
			guard let self = self else { return }
			self.isFetching = false
			
			fetchedArticles.forEach { articleObject in
				if var url = URL(string: articleObject.urlToImage ?? "") {
					// Try to access https instead of http
					if url.scheme == "http" {
						var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
						urlComponents?.scheme = "https"
						url = urlComponents!.url! // Bad practice, wouldn't do in a real world application
					}

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
				else {
					self.articles.append(Article(from: articleObject))
					DispatchQueue.main.async {
						completion()
					}
				}
			}
		}
	}
}
