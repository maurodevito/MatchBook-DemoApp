//
//  MatchBookTests.swift
//  MatchBookTests
//
//  Created by Mauro De Vito on 13/07/2021.
//

import XCTest
@testable import MatchBook

class MatchBookTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

    
    func testNavigationService_getModel() {
        measure {
            let expectation = self.expectation(description: "1) Call API; 2) get ResponseModel; 3) convert to UIModel")
            
            var navigationUIModel: NavigationUIModel?
            let service = NavigationMenuService()
            
            service.getItemsFromAPI().onSuccess { (responseModel) in
                navigationUIModel = NavigationUIModel(navResponseModel: responseModel)
                expectation.fulfill()
            }.onFailure { (error) in
                expectation.fulfill()
            }
            waitForExpectations(timeout: 5, handler: nil)

            let isModelLoaded = navigationUIModel != nil ? true : false
            var hasModelItems = false
            if let model = navigationUIModel  {
                hasModelItems = model.items.count > 0 ? true : false
            }
            
            XCTAssertEqual(isModelLoaded, true, "Model has not been loaded")
            XCTAssertEqual(hasModelItems, true, "API responded, but didn't return any items")
        }
    }
    
    
    
    func testEventsService_getModel() {
        measure {
            let expectation = self.expectation(description: "1) Call API; 2) get ResponseModel; 3) convert to UIModel")
            var eventsUIModel: EventsUIModel?
            
            let urlToCall = "cricket"
            
            let service = EventsService()
            service.getEventsFromAPI(urlEventName: urlToCall).onSuccess { (response) in
                eventsUIModel = EventsUIModel(eventsRespModel: response)
                expectation.fulfill()
            }.onFailure { (error) in
                expectation.fulfill()
            }
            waitForExpectations(timeout: 5, handler: nil)
            let isModelLoaded = eventsUIModel != nil ? true : false
            var hasModelItems = false
            if let model = eventsUIModel  {
                hasModelItems = model.events.count > 0 ? true : false
            }
            
            XCTAssertEqual(isModelLoaded, true, "Model has not been loaded")
            XCTAssertEqual(hasModelItems, true, "API responded, but didn't return any items")
        }
    }
    
}
