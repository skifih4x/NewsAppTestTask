//
//  NewCell.swift
//  NewsAppTestTask
//
//  Created by Артем Орлов on 27.04.2023.
//

import UIKit

final class NewsCell: UITableViewCell {
    
    // MARK: - UI
    
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.image = nil
    }
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func configure(with model: Article) {
        titleLabel.text = model.title
        authorLabel.text = model.author
        dateLabel.text = formatDate(from: model.publishedAt)

        if let url = model.urlToImage, let imageURL = URL(string: url) {
            thumbnailImageView.loadImage(from: imageURL) { [weak self] success in
                if success {
                    self?.setNeedsLayout()
                }
            }
        } else {
            thumbnailImageView.image = UIImage(systemName: "icloud.slash")
        }
    }
    
    // MARK: - Private Methods
    
    private func formatDate(from dateString: String?) -> String? {
        guard let dateString = dateString,
              let date = DateFormatter.iso8601Full.date(from: dateString) else {
            return nil
        }
        
        return DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .short)
    }
}

// MARK: - Setup layout

extension NewsCell {
    private func setupUI() {
        
        addSubview(thumbnailImageView)
        addSubview(titleLabel)
        addSubview(authorLabel)
        addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            thumbnailImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 90),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 90),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            authorLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 8),
            
            dateLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 8),
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}
