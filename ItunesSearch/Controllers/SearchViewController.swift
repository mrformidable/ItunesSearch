//
//  SearchViewController.swift
//  ItunesSearch
//
//  Created by Michael Aidoo on 2018-07-29.
//  Copyright © 2018 Michael Aidoo. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    private lazy var searchDataSource = SearchControllerDataSource(tableView: self.tableView)
    private let delegateSource = SearchControllerDelegateSource()
    
    private let searchController = UISearchController(searchResultsController: nil)
    private let searchService = SearchService<SongResult>()
    
    private lazy var loadingView: LoadingView = .fromNib()
    private lazy var emptyView: EmptyView = .fromNib()
    private lazy var debouncer = Debouncer(delay: 0.45)
    
    private var state: State = .idle {
        didSet {
            searchDataSource.state = state
            handleSearchingState(state)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        tableView.delegate = delegateSource
        
        NotificationCenter.default.addObserver(self, selector: #selector(SearchViewController.handleSearchCellSelection), name: .handleSearchCellSelection, object: nil)
        
        debouncer.callback = { [weak self] in
            self?.searchSongs()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchController.searchBar.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchController.isActive = false
        searchController.searchBar.endEditing(true)
    }
    
    private func setupSearchController() {
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.autocorrectionType = .no
        searchController.searchBar.placeholder = "Search Artist or Song"
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.becomeFirstResponder()
    }  
    
    @objc func handleSearchCellSelection(_ notification: Notification) {
        let indexPath = notification.object as? IndexPath
        performSegue(withIdentifier: SegueIdentifiers.songViewController, sender: indexPath)
    }
}

//MARK:- Segue
extension SearchViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifiers.songViewController {
            if let songViewController = segue.destination as? SongViewController {
                guard let indexPath = sender as? IndexPath else {
                    fatalError("Could not retreive indexPath from sender")
                }
                songViewController.song = searchDataSource.songs[indexPath.row]
            }
        }
    }
}

//MARK:- Searching
extension SearchViewController {
    private func searchSongs() {
        let query = searchController.searchBar.text
        state = .loading
        searchDataSource.songs = []
        searchService.fetchSongs(matching: query) { (result) in
            self.updateSearch(result: result)
        }
    }
    
    private func updateSearch(result: NetworkResult<SongResult>) {
        switch result {
        case .success(let track):
            guard !track.songs.isEmpty else { state = .empty; return }
            searchDataSource.songs.append(contentsOf: track.songs)
            state = .finished
        case .failure(let error):
            state = .error(error)
        }
    }
}
// MARK:- SearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        debouncer.schedule()
    }
}

// MARK:- Search UI updates
private extension SearchViewController {
    func handleSearchingState(_ state: State) {
        NotificationCenter.default.post(name: .handleSearchState, object: state)
        switch state {
        // handle UI updates here
        case .loading:
            tableView.tableFooterView = loadingView
        case .empty:
            tableView.tableFooterView = emptyView
        case .finished:
            tableView.tableFooterView = nil
        default:
            break
        }
    }
}

