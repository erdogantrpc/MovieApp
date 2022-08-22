//
//  MoviesViewController.swift
//  MovieApp
//
//  Created by Erdoğan Turpcu on 18.08.2022.
//

import UIKit
import Combine

final class MoviesViewController: UIViewController {
    
    struct Constants {
        static let MOVIE_CELL = "MoviesTableViewCell"
        static let TITLE = "MovieLIST"
        static let ADD_BUTTON_NAME = "plus"
        static let BUTTON_TITLE = "Add"
        static let ACTIVITY_INDICATOR_SIZE = CGFloat(50)
        static let BUTTON_CONTAINER_HEIGHT = CGFloat(100)
        static let ADD_BUTTON_SIZE = CGFloat(60)
        static let CELL_HEIGHT = CGFloat(160)
        static let BUTTON_IMAGE_PADDING = CGFloat(10)
        static let ADD_BUTTON_FRAME_X = CGFloat(20)
        static let ADD_BUTTON_FRAME_Y_DIFF = CGFloat(90)
        static let ADD_BUTTON_WIDTH_DIFF = CGFloat(40)
        static let ONE = 1
        static let TWO = 2
    }
    
    private let tableView = UITableView()
    private lazy var viewModel = MovieViewModel()
    private var cancelable = Set<AnyCancellable>()
    private let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: .zero, y: .zero, width: Constants.ACTIVITY_INDICATOR_SIZE, height: Constants.ACTIVITY_INDICATOR_SIZE))
    
    private let addButton: UIButton = {
        let button = UIButton(frame: CGRect(x: .zero, y: .zero, width: Constants.ADD_BUTTON_SIZE, height: Constants.ADD_BUTTON_SIZE))
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: Constants.ADD_BUTTON_NAME)
        configuration.imagePadding = Constants.BUTTON_IMAGE_PADDING
        configuration.baseForegroundColor = .green
        configuration.title = Constants.BUTTON_TITLE
        configuration.baseBackgroundColor = .white
        button.configuration = configuration
        return button
    }()
    
    private let buttonContainer: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.layer.masksToBounds = true
        return containerView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPage()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        buttonContainer.frame = CGRect(x: .zero, y: view.frame.size.height - Constants.BUTTON_CONTAINER_HEIGHT, width: view.frame.size.width, height: Constants.BUTTON_CONTAINER_HEIGHT)
        addButton.frame = CGRect(x: Constants.ADD_BUTTON_FRAME_X, y: buttonContainer.frame.size.height - Constants.ADD_BUTTON_FRAME_Y_DIFF, width: buttonContainer.frame.size.width - Constants.ADD_BUTTON_WIDTH_DIFF, height: Constants.ADD_BUTTON_SIZE)
        addButton.setDashedBorder()
        addButton.addTarget(viewModel, action: #selector(viewModel.addElement), for: .touchUpInside)
    }

    private func setupPage() {
        viewModel.$isLoadData
            .sink { [weak self] dataLoaded in
                if dataLoaded {
                    self?.tableView.reloadData()
                }
            }.store(in: &cancelable)
        title = Constants.TITLE
        configureTableView()
        viewModel.fetchData()
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        view.addSubview(buttonContainer)
        buttonContainer.addSubview(addButton)
        setTableViewDelegates()
        tableView.register(MoviesTableViewCell.self, forCellReuseIdentifier: Constants.MOVIE_CELL)
        tableView.separatorStyle = .none
        tableView.pin(to: view)
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == .zero {
            return Constants.CELL_HEIGHT
        } else {
            return Constants.ACTIVITY_INDICATOR_SIZE
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.isExtend ? Constants.TWO : Constants.ONE
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == .zero {
            return viewModel.movies.count
        } else {
            return Constants.ONE
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == .zero {
            if indexPath.row == viewModel.movies.count - Constants.ONE {
                viewModel.extendResult()
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.MOVIE_CELL) as! MoviesTableViewCell
            let movie = viewModel.movies[indexPath.row]
            cell.selectionStyle = .none
            cell.set(result: movie)
            return cell
        } else {
            let cell = UITableViewCell()
            activityIndicator.center = CGPoint(x: cell.center.x + activityIndicator.frame.width, y: cell.center.y)
            cell.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC =  MovieDetailViewController(nibName: nil, bundle: nil)
        detailVC.movieTitle = viewModel.movies[indexPath.row].title
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
