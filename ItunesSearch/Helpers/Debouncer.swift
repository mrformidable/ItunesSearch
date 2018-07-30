//
//  Debouncer.swift
//  ItunesSearch
//
//  Created by Michael Aidoo on 2018-07-29.
//  Copyright © 2018 Michael Aidoo. All rights reserved.
//

import Foundation

class Debouncer {
    var callback: (() -> Void)?
    var delay: TimeInterval
    private weak var timer: Timer?
    
    init(delay: TimeInterval) {
        self.delay = delay
    }
    
    func schedule() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(fireRequest), userInfo: nil, repeats: false)
    }
    
    @objc private func fireRequest() {
        callback?()
    }
}
