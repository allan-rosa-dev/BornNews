//
//  ArticleListViewController.swift
//  BornLogicNews
//
//  Created by Allan Rosa on 12/05/22.
//

import UIKit

final class ArticleListViewController: UIViewController {
	
	private let articleListViewModel = ArticleListViewModel()
	
	//MARK: - View Code UI Elements
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
	
	lazy private var logoImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(named: "logo-white")
		imageView.contentMode = .scaleAspectFill
		
		return imageView
	}()
	
	lazy private var searchTextField: UITextField = {
		let textField = UITextField()
		textField.font = K.Design.textFont
		textField.textColor = K.Design.textFieldFontColor
		textField.backgroundColor = K.Design.textFieldBackgroundColor
		textField.placeholder = "Search for news..."
		textField.textAlignment = .center
		textField.layer.cornerRadius = 10
		textField.clipsToBounds = true
		textField.clearsOnBeginEditing = true
		
		return textField
	}()
	
	lazy private var queryParametersStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.distribution = .fill
		stackView.spacing = Layout.halfMargin
		stackView.translatesAutoresizingMaskIntoConstraints = false
		
		return stackView
	}()
	
	lazy private var languageTextField: UITextField = {
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
	
	lazy private var sortByTextField: UITextField = {
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
	
	lazy private var articlesTableView: UITableView = {
		let tableView = UITableView()
		tableView.backgroundColor = K.Design.backgroundGreen
		tableView.translatesAutoresizingMaskIntoConstraints = false
		
		return tableView
	}()
	
	lazy private var languagePickerView = UIPickerView()
	lazy private var sortParameterPickerView = UIPickerView()
	
	//MARK: - View Code Interface Building
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
			articlesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
	
	private func configureViews(){
		self.navigationController?.isNavigationBarHidden = true
		self.view.backgroundColor = K.Design.backgroundGreen
		articlesTableView.backgroundColor = K.Design.backgroundYellow
		
		articlesTableView.delegate = self
		articlesTableView.dataSource = self
		
		articlesTableView.register(ArticleCell.self, forCellReuseIdentifier: String(describing: ArticleCell.self))

		searchTextField.delegate = self
		languageTextField.delegate = self
		sortByTextField.delegate = self
		
		languageTextField.inputView = languagePickerView
		languagePickerView.selectRow(Language.any.rawValue, inComponent: 0, animated: false)
		
		languagePickerView.delegate = self
		languagePickerView.dataSource = self
		
		sortByTextField.inputView = sortParameterPickerView
		sortParameterPickerView.selectRow(QuerySortParameter.publishedAt.rawValue, inComponent: 0, animated: false)
		
		sortParameterPickerView.delegate = self
		sortParameterPickerView.dataSource = self
	}
	
	//MARK: - Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		buildViewHierarchy()
		setupConstraints()
		configureViews()
		
		// Hide any input views when user taps on the view
		let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
		view.addGestureRecognizer(tapGesture)
		tapGesture.cancelsTouchesInView = false
	}
}

//MARK: - TableView Delegate & Data Source
extension ArticleListViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return articleListViewModel.articles.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = articlesTableView.dequeueReusableCell(withIdentifier: String(describing: ArticleCell.self)) as? ArticleCell else { return UITableViewCell() }
		guard indexPath.row < articleListViewModel.articles.count else { return UITableViewCell() }
		
		let article = articleListViewModel.articles[indexPath.row]
		
		cell.configureView(withTitle: "[\(indexPath.row+1)/\(articleListViewModel.articles.count)] " + article.title, withImage: article.image, withDescription: article.description, withAuthor: article.author)
		cell.selectionStyle = .none
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let article = articleListViewModel.articles[indexPath.row]
		let detailsViewModel = ArticleDetailsViewModel(from: article)
		let detailsView = ArticleDetailsViewController()
		detailsView.articleDetailsViewModel = detailsViewModel
		
		navigationController?.pushViewController(detailsView, animated: true)
	}
	
}

//MARK: - UITextField Delegate
extension ArticleListViewController: UITextFieldDelegate {
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		guard textField == searchTextField else { return false }
		guard let searchText = textField.text else { return false }
		textField.resignFirstResponder()
		
		articlesTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
		articleListViewModel.fetchArticles(searchingFor: searchText,
										   in: Language(rawValue: languagePickerView.selectedRow(inComponent: 0)),
										   sortingBy: QuerySortParameter(rawValue: sortParameterPickerView.selectedRow(inComponent: 0)))
		{ [weak self] in
			guard let self = self else { return }
			self.articlesTableView.reloadData()
		}
		return true
	}
}

//MARK: - UIPickerView Delegate & Data Source
extension ArticleListViewController: UIPickerViewDelegate, UIPickerViewDataSource {
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		if pickerView == languagePickerView { return Language.allCases.count }
		if pickerView == sortParameterPickerView { return QuerySortParameter.allCases.count }
		return 0
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		if pickerView == languagePickerView {
			return Language.allCases[row].description
		}
		if pickerView == sortParameterPickerView {
			return QuerySortParameter.allCases[row].description
		}
		return "?"
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		if pickerView == languagePickerView {
			languageTextField.text = Language(rawValue: row)?.description
			languageTextField.resignFirstResponder()
		}
		if pickerView == sortParameterPickerView {
			sortByTextField.text = QuerySortParameter(rawValue: row)?.description
			sortByTextField.resignFirstResponder()
		}
	}
}
