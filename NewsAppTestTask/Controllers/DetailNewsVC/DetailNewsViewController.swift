//
//  DetailNewsViewController.swift
//  NewsAppTestTask
//
//  Created by Артем Орлов on 27.04.2023.
//

import UIKit

final class DetailNewsViewController: UIViewController {
    
    // MARK: - Propetry
    
   private var presenter: NewsDetailPresenter

    // MARK: - UI
    
    private var articleTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var articleAuthorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var articleDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var favoriteButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(addToFavorites))
        button.tintColor = .systemRed
        return button
    }()
    
    // MARK: - Init
    
    init(article: News) {
        self.presenter = NewsDetailPresenter(article: article)
        super.init(nibName: nil, bundle: nil)
        presenter.view = self
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewDidLoad()
    }
    
    // MARK: - Private methods
    
    @objc private func addToFavorites() {
        presenter.addToFavorites()
    }
}

// MARK: - Detail View Protocol

extension DetailNewsViewController: NewsDetailView {
    
    func showArticle(_ article: News) {
        articleTitleLabel.text = article.title
        articleAuthorLabel.text = "By: \(article.author ?? "No author")"
        articleDescriptionLabel.text = article.description
        
        if let imageURL = article.urlToImage, let url = URL(string: imageURL) {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.articleImageView.image = UIImage(data: imageData)
                    }
                }
            }
        }
    }
    
    func showFavoriteButton(_ isFavorite: Bool) {
        if isFavorite {
            favoriteButton.image = UIImage(systemName: "heart.fill")
        } else {
            favoriteButton.image = UIImage(systemName: "heart")
        }
    }
}

// MARK: - Set layout

extension DetailNewsViewController {
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(articleTitleLabel)
        view.addSubview(articleAuthorLabel)
        view.addSubview(articleImageView)
        view.addSubview(articleDescriptionLabel)

        navigationItem.rightBarButtonItem = favoriteButton

        NSLayoutConstraint.activate([
            articleTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            articleTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            articleTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            articleAuthorLabel.topAnchor.constraint(equalTo: articleTitleLabel.bottomAnchor, constant: 8),
            articleAuthorLabel.leadingAnchor.constraint(equalTo: articleTitleLabel.leadingAnchor),
            articleAuthorLabel.trailingAnchor.constraint(equalTo: articleTitleLabel.trailingAnchor),
            
            articleImageView.topAnchor.constraint(equalTo: articleAuthorLabel.bottomAnchor, constant: 16),
            articleImageView.leadingAnchor.constraint(equalTo: articleTitleLabel.leadingAnchor),
            articleImageView.trailingAnchor.constraint(equalTo: articleTitleLabel.trailingAnchor),
            articleImageView.heightAnchor.constraint(equalToConstant: 200),
            
            articleDescriptionLabel.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 16),
            articleDescriptionLabel.leadingAnchor.constraint(equalTo: articleTitleLabel.leadingAnchor),
            articleDescriptionLabel.trailingAnchor.constraint(equalTo: articleTitleLabel.trailingAnchor),
        ])
    }
}
