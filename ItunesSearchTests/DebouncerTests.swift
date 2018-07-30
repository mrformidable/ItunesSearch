//
//  DebouncerTests.swift
//  ItunesSearchTests
//
//  Created by Michael Aidoo on 2018-07-29.
//  Copyright © 2018 Michael Aidoo. All rights reserved.
//

import XCTest
@testable import ItunesSearch

class DebouncerTests: XCTestCase {
    
    func testPreviousClosureCancelled() {
        let debouncer = Debouncer(delay: 0.45)
        
        // Expectation for the closure we're expecting to be cancelled
        let cancelExpectation = expectation(description: "Cancel")
        cancelExpectation.isInverted = true
        
        // Expectation for the closure we're expecting to be completed
        let completedExpectation = expectation(description: "Completed")
        
        debouncer.schedule()
        debouncer.callback = {
            cancelExpectation.fulfill()
        }
        
        // When we schedule a new closure, the previous one should be cancelled
        debouncer.schedule()
        debouncer.callback = {
            completedExpectation.fulfill()
        }
        
        // We add an extra 0.05 seconds to reduce the risk for flakiness
        waitForExpectations(timeout: 0.5, handler: nil)
    }
}

