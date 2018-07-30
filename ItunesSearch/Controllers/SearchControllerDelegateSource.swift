//
//  SearchControllerDelegateSource.swift
//  ItunesSearch
//
//  Created by Michael Aidoo on 2018-07-29.
//  Copyright © 2018 Michael Aidoo. All rights reserved.
//

import Foundation
import UIKit

class SearchControllerDelegateSource: NSObject { }

extension SearchControllerDelegateSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: .handleSearchCellSelection, object: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

