//
//  FavoritesNewsViewController.swift
//  NewsAppTestTask
//
//  Created by Артем Орлов on 28.04.2023.
//

import UIKit

class FavoritesNewsViewController: UIViewController {
    
    // MARK: - Property
    
    private let presenter: FavoritesPresenter
    
    // MARK: - UI
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(NewsCell.self, forCellReuseIdentifier: "ArticleCell")
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    // MARK: - Init
    
    init(presenter: FavoritesPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.presenter.view = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewDidLoad()
        tableView.reloadData()
    }
    
}

// MARK: - UITableViewDataSource

extension FavoritesNewsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! NewsCell
        let article = presenter.favorites[indexPath.row]
        cell.configure(with: article)
        return cell
    }
    
}

// MARK: - FavoritesView protocol

extension FavoritesNewsViewController: FavoritesView {
    
    func showFavorites(_ favorites: [Article]) {
        self.presenter.favorites = favorites
        tableView.reloadData()
    }
    
}

// MARK: - UITableViewDelegate

extension FavoritesNewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = presenter.favorites[indexPath.row]
        let detailVC = DetailNewsViewController(article: article)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let article = presenter.favorites[indexPath.row]
            presenter.removeFromFavorites(article)
        }
    }
}

// MARK: - setupUI

extension FavoritesNewsViewController {
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
