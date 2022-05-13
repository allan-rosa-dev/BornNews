//
//  ArticleListViewController.swift
//  BornLogicNews
//
//  Created by Allan Rosa on 12/05/22.
//

import UIKit

class ArticleListViewController: UIViewController {
	
	private enum Layout {
		static let margin: CGFloat = 10
		static let halfMargin: CGFloat = margin/2
	}
	
	lazy var topStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.distribution = .fill
		stackView.spacing = Layout.margin
		stackView.translatesAutoresizingMaskIntoConstraints = false
		
		return stackView
	}()
	
	lazy var titleStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.distribution = .fill
		stackView.spacing = Layout.halfMargin
		stackView.translatesAutoresizingMaskIntoConstraints = false
		
		return stackView
	}()
	
	lazy var logoImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(named: "logo-white")
		imageView.contentMode = .scaleAspectFill
		
		return imageView
	}()
	
	lazy var searchTextField: UITextField = {
		let textField = UITextField()
		textField.font = K.Design.textFont
		textField.textColor = K.Design.textFieldFontColor
		textField.backgroundColor = K.Design.textFieldBackgroundColor
		textField.placeholder = "Search for news..."
		textField.textAlignment = .center
		textField.layer.cornerRadius = 10
		textField.clipsToBounds = true
		
		return textField
	}()
	
	lazy var queryParametersStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.distribution = .fill
		stackView.spacing = Layout.halfMargin
		stackView.translatesAutoresizingMaskIntoConstraints = false
		
		return stackView
	}()
	
	lazy var languageTextField: UITextField = {
		let textField = UITextField()
		textField.font = K.Design.textFont
		textField.textColor = K.Design.textFieldFontColor
		textField.backgroundColor = K.Design.textFieldBackgroundColor
		textField.placeholder = Language.any.description
		textField.textAlignment = .center
		textField.layer.cornerRadius = 10
		textField.clipsToBounds = true
		
		return textField
	}()
	
	lazy var sortByTextField: UITextField = {
		let textField = UITextField()
		textField.font = K.Design.textFont
		textField.textColor = K.Design.textFieldFontColor
		textField.backgroundColor = K.Design.textFieldBackgroundColor
		textField.placeholder = QuerySortParameter.publishedAt.description
		textField.textAlignment = .center
		textField.layer.cornerRadius = 10
		textField.clipsToBounds = true
		
		return textField
	}()
	
	lazy var articlesTableView: UITableView = {
		let tableView = UITableView()
		tableView.backgroundColor = K.Design.backgroundYellow
		tableView.translatesAutoresizingMaskIntoConstraints = false
		
		return tableView
	}()
	
	private func buildViewHierarchy(){
		queryParametersStackView.addArrangedSubview(languageTextField)
		queryParametersStackView.addArrangedSubview(sortByTextField)
		
		titleStackView.addArrangedSubview(logoImageView)
		titleStackView.addArrangedSubview(searchTextField)
		
		topStackView.addArrangedSubview(titleStackView)
		topStackView.addArrangedSubview(queryParametersStackView)
		
		view.addSubview(topStackView)
		view.addSubview(articlesTableView)
	}
	
	private func setupConstraints(){
		NSLayoutConstraint.activate([
			logoImageView.widthAnchor.constraint(equalTo: searchTextField.widthAnchor, multiplier: 0.3),
			searchTextField.heightAnchor.constraint(equalTo: languageTextField.heightAnchor, multiplier: 1),
			languageTextField.widthAnchor.constraint(equalTo: queryParametersStackView.widthAnchor, multiplier: 0.5)
		])

		NSLayoutConstraint.activate([
			topStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Layout.margin),
			topStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Layout.halfMargin),
			topStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Layout.halfMargin),
			topStackView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1)
		])
		
		NSLayoutConstraint.activate([
			articlesTableView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: Layout.margin),
			articlesTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			articlesTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			articlesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Layout.margin)
		])
	}
	
	private func configureViews(){
		articlesTableView.backgroundColor = K.Design.backgroundYellow
	}
	
	//MARK: - Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()

		self.view.backgroundColor = K.Design.backgroundGreen
		
		buildViewHierarchy()
		setupConstraints()
		configureViews()
	}
}

//MARK: - TableView Delegate & Data Source
extension ArticleListViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return UITableViewCell()
	}
}
