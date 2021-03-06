//
//  MatchBookUITests.swift
//  MatchBookUITests
//
//  Created by Mauro De Vito on 13/07/2021.
//

import XCTest

class MatchBookUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /*
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
 */
    
    func testNavigationScrollandTap(){
        let app = XCUIApplication()
        app.launch()
        app.navigationBars.buttons["Menu"].tap()
        
        let tableView = app.descendants(matching: .table).firstMatch
        guard let firstCell = tableView.cells.allElementsBoundByIndex.first else { return }
        guard let lastCell = tableView.cells.allElementsBoundByIndex.last else { return }
        
        
        let MAX_SCROLLS = 2
        var count = 0
        while lastCell.isHittable == false && count < MAX_SCROLLS {
            app.swipeUp()
            count += 1
        }
        
        firstCell.tap()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}


extension XCUIElement {

    func scrollToElement(element: XCUIElement) {
        while !element.visible() {
            swipeUp()
        }
    }

    func visible() -> Bool {
        guard self.exists && !self.frame.isEmpty else { return false }
        return XCUIApplication().windows.element(boundBy: 0).frame.contains(self.frame)
    }

}
