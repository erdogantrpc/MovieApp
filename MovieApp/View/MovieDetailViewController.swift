//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Erdoğan Turpcu on 21.08.2022.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var movieTitle: String = ""
    
    private let movieTitleLabel = UILabel()
    private let containerView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.backgroundColor = .white
        view.addSubview(containerView)
        view.addSubview(movieTitleLabel)
        containerView.pin(to: view)
        setupUI()
    }
    
    private func setupUI() {
        movieTitleLabel.text = movieTitle
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        containerView.frame = CGRect(x: .zero, y: .zero, width: view.frame.size.width, height: view.frame.size.height)
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        movieTitleLabel.numberOfLines = .zero
        movieTitleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        movieTitleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
    }
    
}
