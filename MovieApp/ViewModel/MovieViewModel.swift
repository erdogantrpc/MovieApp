//
//  MovieViewModel.swift
//  MovieApp
//
//  Created by Erdoğan Turpcu on 20.08.2022.
//

import Foundation
import Combine
import PromisedFuture

final class MovieViewModel {
    
    var movies: [Result] = []
    var movieService: MovieServiceProtocol
    
    private var totalPageSize: Int = 5
    private var currentPage: Int = 1
    private var workItem: DispatchWorkItem?
    
    @Published var isLoadData = false
    
    private var availableForExtend: Bool {
        return currentPage <= totalPageSize
    }
    
    var isExtend: Bool {
        return availableForExtend
    }

    init(service: MovieServiceProtocol = APIClient() ) {
        movieService = service
    }
    
    func fetchData() {
        workItem?.cancel()
        let requestWorkItem = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            let movieFuture = self.movieService.getMovies(pageNumber: self.currentPage)
            movieFuture.execute { [weak self] (movieResponse) in
                guard let self = self else { return }
                self.movies.append(contentsOf: movieResponse.results)
                self.isLoadData = true
            } onFailure: { (error) in
                print(error)
            }
        }
        workItem = requestWorkItem
        DispatchQueue.global(qos: .utility).asyncAfter(deadline: .now() + 1, execute: requestWorkItem)
    }
    
    func extendResult(){
        if availableForExtend {
            self.currentPage += 1
            fetchData()
        }else {
            print("non-extendable")
        }
    }
    
    @objc func addElement(){
        // Add elements
    }
}

