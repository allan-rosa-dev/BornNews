//
//  ServiceEnums.swift
//  BornLogicNews
//
//  Created by Allan Rosa on 12/05/22.
//

import Foundation

enum Language: Int, CaseIterable, CustomStringConvertible {
	case any
	case en
	case pt
	
	var code: String {
		switch self {
			case .any: return ""
			case .en: return "en"
			case .pt: return "pt"
		}
	}
	
	var description: String {
		switch self {
			case .any: return "Any Language"
			case .en: return "English"
			case .pt: return "Português"
		}
	}
}

enum QuerySortParameter: Int, CaseIterable, CustomStringConvertible {
	case relevancy
	case popularity
	case publishedAt
	
	var code: String {
		switch self {
			case .relevancy: return "relevancy"
			case .popularity: return "popularity"
			case .publishedAt: return "publishedAt"
		}
	}
	
	var description: String {
		switch self {
			case .relevancy: return "Relevancy"
			case .popularity: return "Popularity"
			case .publishedAt: return "Most Recent"
		}
	}
}
