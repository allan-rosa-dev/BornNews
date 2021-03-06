//
//  NewsService.swift
//  BornLogicNews
//
//  Created by Allan Rosa on 12/05/22.
//

import Foundation

// MARK: - API Service Manager Singleton
struct NewsService {
	static let shared = NewsService()

	func fetchNews(searchingFor searchText: String,
				   inLanguage language: Language? = nil,
				   sortedBy sortParameter: QuerySortParameter? = nil,
				   completion: @escaping ([ArticleObject]) -> ()) {
		
		guard !searchText.isEmpty else { return }
		
		var queryURL = "https://newsapi.org/v2/everything?q=" + searchText
		
		if let language = language {
			queryURL += "&language=" + language.code
		}
		if let sortParameter = sortParameter {
			queryURL += "&sortBy=" + sortParameter.code
		}
		if let apiKey = UserDefaults.standard.string(forKey: K.Defaults.apiKey) {
			queryURL += "&apiKey=" + apiKey
		}
		
		fetchData(urlString: queryURL) { (result: Result<ResponseObject, Error>) in
			switch result {
				case .success(let responseObject):
					// Should also check if responseObject status is valid according to NewsAPI and treat other cases
					completion(responseObject.articles)
					
				case .failure(let err):
					// Known issue: Not treating invalid NewsAPI returns such as Invalid API Key or invalid Query parameters
					print("--- Failed to fetch data ---")
					print(err)
					completion([])
			}
		}
	}
}

// MARK: - fetchData
/// Fetches and decodes JSON data from a given *urlString*, returning a Swift5 Result object
private func fetchData<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> ()) {
	guard let url = URL(string: urlString) else { return }
	URLSession.shared.dataTask(with: url) { (data, resp, err) in
		if let err = err {
			completion(.failure(err))
			return
		}
		do {
			let decodedData = try JSONDecoder().decode(T.self, from: data!)
			completion(.success(decodedData))
		}
		catch let jsonError {
			completion(.failure(jsonError))
		}
	}.resume()
}
