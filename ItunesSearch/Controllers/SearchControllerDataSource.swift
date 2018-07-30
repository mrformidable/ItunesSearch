//
//  SearchControllerDataSource.swift
//  ItunesSearch
//
//  Created by Michael Aidoo on 2018-07-29.
//  Copyright © 2018 Michael Aidoo. All rights reserved.
//

import Foundation
import UIKit

class SearchControllerDataSource: NSObject {
    
    var state: State?
    
    var songs: [Song] = []
    
    private let tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
        
        super.init()
        tableView.dataSource = self
        tableView.reloadData()
        tableView.register(UINib(nibName: String(describing: SearchViewCell.self), bundle: nil), forCellReuseIdentifier: SearchViewCell.cellIdentifier)
    }
}

extension SearchControllerDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchViewCell.cellIdentifier, for: indexPath) as! SearchViewCell
        if case .finished? = state {
            let song = songs[indexPath.row]
            cell.configureCell(with: song)
        }
        return cell
    }
    
}



