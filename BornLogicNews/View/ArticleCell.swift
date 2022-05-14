//
//  ArticleCell.swift
//  BornLogicNews
//
//  Created by Allan Rosa on 13/05/22.
//

import UIKit

class ArticleCell: UITableViewCell {
	
	//MARK: - ViewCode UI Elements
	private enum Layout {
		static let margin: CGFloat = 8
		static let halfMargin: CGFloat = margin/2
	}
	
	lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.textColor = K.Design.labelColor
		label.font = K.Design.subtitleFont
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		
		return label
	}()
	
	lazy var articleImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = #imageLiteral(resourceName: "logo")
		imageView.contentMode = .scaleAspectFill
		imageView.translatesAutoresizingMaskIntoConstraints = false
		
		return imageView
	}()
	
	lazy var authorLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 1
		label.textColor = K.Design.labelColor
		label.font = K.Design.textFont
		label.textAlignment = .right
		label.translatesAutoresizingMaskIntoConstraints = false
		
		return label
	}()
	
	lazy var descriptionLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.textColor = K.Design.labelColor
		label.font = K.Design.textFont
		label.textAlignment = .natural
		label.translatesAutoresizingMaskIntoConstraints = false
		
		return label
	}()
	
	//MARK: - Init
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		buildViewHierarchy()
		setupConstraints()
	}
	
	@available(*, unavailable)
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK: - View Code UI Builder
	private func buildViewHierarchy() {
		contentView.addSubview(titleLabel)
		contentView.addSubview(articleImageView)
		contentView.addSubview(descriptionLabel)
		contentView.addSubview(authorLabel)
	}
	
	private func setupConstraints() {
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Layout.halfMargin),
			titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.margin),
			titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.margin),
			
			articleImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Layout.halfMargin),
			articleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.margin),
			articleImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.margin),
			articleImageView.heightAnchor.constraint(equalTo: articleImageView.widthAnchor, constant: -Layout.margin),
			
			descriptionLabel.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: Layout.halfMargin),
			descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.margin),
			descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.margin),
			
			authorLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Layout.halfMargin),
			authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.margin),
			authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.margin),
			authorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Layout.halfMargin)
		])
	}
	
	func configureView(withTitle title: String, withImage image: UIImage, withDescription description: String, withAuthor author: String?) {
		self.backgroundColor = K.Design.backgroundYellow
		
		titleLabel.text = title
		articleImageView.image = image
		descriptionLabel.text = description
		if let author = author {
			authorLabel.text = "Author: " + author
		}
		else {
			authorLabel.isHidden = true
		}
	}
	
}
