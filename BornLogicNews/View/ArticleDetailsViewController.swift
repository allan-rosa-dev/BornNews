//
//  ArticleDetailsViewController.swift
//  BornLogicNews
//
//  Created by Allan Rosa on 14/05/22.
//

import UIKit

final class ArticleDetailsViewController: UIViewController {
	
	var articleDetailsViewModel = ArticleDetailsViewModel(from: Article())
	
	//MARK: - View Code UI Elements
	private enum Layout {
		static let margin: CGFloat = 2
		static let halfMargin: CGFloat = margin/2
	}
	
	lazy var articleImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		imageView.isUserInteractionEnabled = true
		imageView.translatesAutoresizingMaskIntoConstraints = false
		
		return imageView
	}()
	
	lazy var contentScrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		
		return scrollView
	}()
	
	lazy var articleContentContentView: UIView = {
		let contentView = UIView()
		contentView.translatesAutoresizingMaskIntoConstraints = false
		
		return contentView
	}()
	
	lazy var articleContentLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.font = K.Design.textFont
		label.textColor = K.Design.labelColor
		label.textAlignment = .justified
		label.isUserInteractionEnabled = true
		label.translatesAutoresizingMaskIntoConstraints = false
		
		return label
	}()
	
	lazy var publishDateLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.font = K.Design.textFont
		label.textColor = K.Design.labelColor
		label.textAlignment = .right
		label.translatesAutoresizingMaskIntoConstraints = false
		
		return label
	}()
	
	//MARK: - View Code Interface Building
	private func buildViewHierarchy(){
		view.addSubview(articleImageView)
		view.addSubview(contentScrollView)
		contentScrollView.addSubview(articleContentContentView)
		articleContentContentView.addSubview(articleContentLabel)
		view.addSubview(publishDateLabel)
	}
	
	private func setupConstraints(){
		NSLayoutConstraint.activate([
			articleImageView.heightAnchor.constraint(equalTo: articleImageView.widthAnchor),
			articleImageView.topAnchor.constraint(equalTo: view.readableContentGuide.topAnchor),
			articleImageView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
			articleImageView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
			
			contentScrollView.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: Layout.halfMargin),
			contentScrollView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor, constant: Layout.margin),
			contentScrollView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor, constant: -Layout.margin),
			
			articleContentContentView.topAnchor.constraint(equalTo: contentScrollView.topAnchor),
			articleContentContentView.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor),
			articleContentContentView.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor),
			articleContentContentView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor),
			
			articleContentLabel.topAnchor.constraint(equalTo: articleContentContentView.topAnchor),
			articleContentLabel.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor),
			articleContentLabel.bottomAnchor.constraint(equalTo: articleContentContentView.bottomAnchor),
			
			publishDateLabel.topAnchor.constraint(equalTo: contentScrollView.bottomAnchor, constant: Layout.halfMargin),
			publishDateLabel.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor, constant: Layout.margin),
			publishDateLabel.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor, constant: -Layout.margin),
			publishDateLabel.bottomAnchor.constraint(equalTo: view.readableContentGuide.bottomAnchor, constant: -Layout.margin)
		])
	}
	
	private func configureViews(){
		self.navigationController?.isNavigationBarHidden = false
		self.navigationController?.navigationBar.barTintColor = K.Design.backgroundYellow
		self.title = articleDetailsViewModel.title
		
		view.backgroundColor = K.Design.backgroundYellow
		
		if articleDetailsViewModel.image != nil {
			articleImageView.image = articleDetailsViewModel.image
			articleImageView.isHidden = false
		}
		else {
			articleImageView.isHidden = true
		}
		
		articleContentLabel.text = articleDetailsViewModel.content
		print(articleContentLabel.text)
		
		publishDateLabel.text = "Published at " + articleDetailsViewModel.publishDate.formatted()
	}
	
	//MARK: - Action Selector
	@objc func openSafari() {
		print("Trying to open safari.")
		
		guard let articleURL = articleDetailsViewModel.url else { print("invalid URL: \(articleDetailsViewModel.url)"); return }
		print("Should open \(articleURL)")
		UIApplication.shared.canOpenURL(articleURL)
	}
	
	//MARK: - Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		buildViewHierarchy()
		setupConstraints()
		configureViews()
	}
	
	
}
