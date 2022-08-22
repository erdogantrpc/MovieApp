//
//  MoviesTableViewCell.swift
//  MovieApp
//
//  Created by Erdoğan Turpcu on 19.08.2022.
//

import UIKit
import AlamofireImage

class MoviesTableViewCell: UITableViewCell {
    
    struct Constants {
        static let RATING_LABEL_TEXT = "/10"
        static let TITLE_FONT = "HelveticaNeue-Bold"
        static let MOVIE_TITLE_FONT_SIZE = CGFloat(20)
        static let RATING_TITLE_FONT_SIZE = CGFloat(12)
        static let CORNER_RADIUS = CGFloat(10)
        static let SHADOW_OPACITY = Float(0.1)
        static let STAR_IMAGE_NAME = "star.fill"
        static let RIGHT_IMAGE_NAME = "forward"
    }
    
    var movieImageView: UIImageView = UIImageView()
    var movieTitleLabel: UILabel = UILabel()
    var backView: UIView = UIView()
    var releaseDateLabel: UILabel = UILabel()
    var starImageView: UIImageView = UIImageView()
    var ratingLabel: UILabel = UILabel()
    var rightArrowImageView: UIImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubviews()
        configure()
        setConstraints()
    }
    
    func set(result: Result) {
        movieTitleLabel.text = result.title
        let imageURLString = "\(AppConstants.baseImageURL)\(String(describing: result.backdropPath))"
        if let imageUrl = URL(string: imageURLString) {
            movieImageView.af.setImage(withURL: imageUrl)
        }
        releaseDateLabel.text = result.releaseDate
        ratingLabel.text = String(describing: result.voteAverage) + Constants.RATING_LABEL_TEXT
        ratingLabel.textColor = result.rateColor
        starImageView.tintColor = result.rateColor
    }
    
    func addSubviews() {
        addSubview(movieImageView)
        addSubview(movieTitleLabel)
        addSubview(backView)
        addSubview(releaseDateLabel)
        addSubview(starImageView)
        addSubview(ratingLabel)
        addSubview(rightArrowImageView)
    }
    
    func setConstraints() {
        setImageViewConstraints()
        setTitleLabelConstraints()
        setBackViewConstraints()
        setReleaseDateLabelConstraints()
        setStarImageViewConstraints()
        setRatingLabelConstraints()
        setRightArrowImageViewConstraints()
    }
    
    func configure() {
        // Backgorund
        backgroundColor = .systemGray6
        
        // ImageView
        movieImageView.layer.cornerRadius = Constants.CORNER_RADIUS
        movieImageView.clipsToBounds = true
        
        // TitleLabel
        movieTitleLabel.font = UIFont(name: Constants.TITLE_FONT, size: Constants.MOVIE_TITLE_FONT_SIZE)
        movieTitleLabel.numberOfLines = .zero
        movieTitleLabel.adjustsFontSizeToFitWidth = true
        
        //BackView
        backView.backgroundColor = .white
        backView.layer.cornerRadius = Constants.CORNER_RADIUS
        backView.layer.shadowColor = UIColor.black.cgColor
        backView.layer.shadowOpacity = Constants.SHADOW_OPACITY
        backView.layer.shadowOffset = .zero
        sendSubviewToBack(backView)
        
        // ReleaseDateLabel
        releaseDateLabel.font = UIFont.systemFont(ofSize: 12)
        releaseDateLabel.textColor = .lightGray
        
        // StarImageView
        starImageView.image = UIImage(systemName: Constants.STAR_IMAGE_NAME)
        starImageView.tintColor = .systemGreen
        
        // RatingLabel
        ratingLabel.font = UIFont(name: Constants.TITLE_FONT, size: Constants.RATING_TITLE_FONT_SIZE)
        
        // RightArrow
        rightArrowImageView.image = UIImage(named: Constants.RIGHT_IMAGE_NAME)
    }
    
    func setImageViewConstraints() {
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        movieImageView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 15).isActive = true
        movieImageView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -15).isActive = true
        movieImageView.topAnchor.constraint(equalTo: backView.topAnchor, constant: -20).isActive = true
        movieImageView.trailingAnchor.constraint(equalTo: movieTitleLabel.leadingAnchor, constant: -10).isActive = true
        movieImageView.widthAnchor.constraint(equalTo: backView.widthAnchor, multiplier: 1/4).isActive = true
        movieImageView.contentMode = .scaleToFill
    }
    
    func setTitleLabelConstraints() {
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        movieTitleLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 15).isActive = true
        movieTitleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 12).isActive = true
        movieTitleLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -20).isActive = true
    }
    
    func setBackViewConstraints() {
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 18).isActive = true
        backView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        backView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        backView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18).isActive = true
    }
    
    func setReleaseDateLabelConstraints() {
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseDateLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 8).isActive = true
        releaseDateLabel.leadingAnchor.constraint(equalTo: movieTitleLabel.leadingAnchor).isActive = true
        releaseDateLabel.trailingAnchor.constraint(equalTo: movieTitleLabel.trailingAnchor).isActive = true
    }
    
    func setStarImageViewConstraints() {
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        starImageView.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 8).isActive = true
        starImageView.leadingAnchor.constraint(equalTo: releaseDateLabel.leadingAnchor).isActive = true
        starImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        starImageView.widthAnchor.constraint(equalTo: starImageView.heightAnchor, multiplier: 1/1).isActive = true
        starImageView.trailingAnchor.constraint(equalTo: releaseDateLabel.leadingAnchor, constant: 20).isActive = true
    }
    
    func setRatingLabelConstraints() {
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.topAnchor.constraint(equalTo: starImageView.topAnchor, constant: 4).isActive = true
        ratingLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 8).isActive = true
        ratingLabel.trailingAnchor.constraint(equalTo: releaseDateLabel.trailingAnchor).isActive = true
    }
    
    func setRightArrowImageViewConstraints() {
        rightArrowImageView.translatesAutoresizingMaskIntoConstraints = false
        rightArrowImageView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 45).isActive = true
        rightArrowImageView.leadingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -45).isActive = true
        rightArrowImageView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        rightArrowImageView.widthAnchor.constraint(equalTo: rightArrowImageView.heightAnchor).isActive = true
    }

}
