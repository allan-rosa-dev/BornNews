//
//  ArticleDetailsViewModel.swift
//  BornLogicNews
//
//  Created by Allan Rosa on 14/05/22.
//

import Foundation
import UIKit

protocol ArticleDetailsViewModelProtocol {
	var image: UIImage? { get }
	var description: String { get }
	var publishDate: String { get }
}

final class ArticleDetailsViewModel: ArticleDetailsViewModelProtocol {
	var image: UIImage? = nil
	var description: String = ""
	var publishDate: String = ""
}
