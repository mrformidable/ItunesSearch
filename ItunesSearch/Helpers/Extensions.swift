//
//  Extensions.swift
//  ItunesSearch
//
//  Created by Michael Aidoo on 2018-07-29.
//  Copyright © 2018 Michael Aidoo. All rights reserved.
//

import Foundation
import UIKit

extension Notification.Name {
    static var handleSearchState: Notification.Name {
        return .init("ObserveState")
    }
    
    static var handleSearchCellSelection: Notification.Name {
        return .init("handleSearchCellSelection")
    }
}


extension UIView {
    class func fromNib<T: UIView>() -> T {
        let className = String(describing: T.self)
        return Bundle.main.loadNibNamed(className, owner: self, options: nil)?.first as! T
    }
}
