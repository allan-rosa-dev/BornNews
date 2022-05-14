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
		static let margin: CGFloat = 10
		static let halfMargin: CGFloat = margin/2
	}
	
	lazy var articleImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		imageView.isUserInteractionEnabled = true
		imageView.translatesAutoresizingMaskIntoConstraints = false
		
		return imageView
	}()
	
	lazy var descriptionView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		
		return scrollView
	}()
	
	lazy var descriptionContentView: UIView = {
		let contentView = UIView()
		contentView.translatesAutoresizingMaskIntoConstraints = false
		
		return contentView
	}()
	
	lazy var descriptionLabel: UILabel = {
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
		view.addSubview(descriptionView)
		descriptionView.addSubview(descriptionContentView)
		descriptionContentView.addSubview(descriptionLabel)
		view.addSubview(publishDateLabel)
	}
	
	private func setupConstraints(){
		NSLayoutConstraint.activate([
			articleImageView.heightAnchor.constraint(equalTo: articleImageView.widthAnchor),
			articleImageView.topAnchor.constraint(equalTo: view.readableContentGuide.topAnchor),
			articleImageView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
			articleImageView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
			
			descriptionView.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: Layout.halfMargin),
			descriptionView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor, constant: Layout.margin),
			descriptionView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor, constant: -Layout.margin),
			
			descriptionContentView.topAnchor.constraint(equalTo: descriptionView.topAnchor),
			descriptionContentView.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor),
			descriptionContentView.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor),
			descriptionContentView.bottomAnchor.constraint(equalTo: descriptionView.bottomAnchor),
			
			descriptionLabel.topAnchor.constraint(equalTo: descriptionContentView.topAnchor),
			descriptionLabel.widthAnchor.constraint(equalTo: descriptionView.widthAnchor),
			descriptionLabel.bottomAnchor.constraint(equalTo: descriptionContentView.bottomAnchor),
			
			publishDateLabel.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: Layout.halfMargin),
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
		
		descriptionLabel.text = articleDetailsViewModel.description
		
		publishDateLabel.text = "Published at " + articleDetailsViewModel.publishDate.formatted()
	}
	
	//MARK: - Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		buildViewHierarchy()
		setupConstraints()
		configureViews()
		
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openSafari(_:)))
		articleImageView.addGestureRecognizer(tapGesture)
		publishDateLabel.addGestureRecognizer(tapGesture)
	}
	
	//MARK: - Action Selector
	@objc func openSafari(_ sender: UITapGestureRecognizer) {
		print("Trying to open safari.")
		guard let articleURL = articleDetailsViewModel.url else { print("invalid URL: \(articleDetailsViewModel.url)"); return }
		print("Should open \(articleURL)")
		UIApplication.shared.canOpenURL(articleURL)
	}
}
