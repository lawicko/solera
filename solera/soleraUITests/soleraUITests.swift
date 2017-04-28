//
//  soleraUITests.swift
//  soleraUITests
//
//  Created by Jakub Lawicki on 28.04.17.
//  Copyright © 2017 Jakub Lawicki. All rights reserved.
//

import XCTest

class soleraUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddingItemsToBasket() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        let shopNavigationBar = app.navigationBars["Shop"]
        let myBasketButton = shopNavigationBar.buttons["My Basket"]
        myBasketButton.tap()
        
        let cells = app.tables.cells
        XCTAssertEqual(cells.count, 0, "The basket should have 0 cells, but instead found: \(cells.debugDescription)")
        
        let basketNavigationBar = app.navigationBars["Basket"]
        let shopButton = basketNavigationBar.buttons["Shop"]
        shopButton.tap()
        
        let collectionViewsQuery = app.collectionViews
        let tomatoesImage = collectionViewsQuery.images["Tomatoes"]
        tomatoesImage.tap()
        myBasketButton.tap()
        
        XCTAssertEqual(cells.count, 1, "The basket should have 1 cell, but instead found: \(cells.debugDescription)")
        
        shopButton.tap()
        
        let milkImage = collectionViewsQuery.images["Milk"]
        milkImage.tap()
        milkImage.tap()
        myBasketButton.tap()
        
        XCTAssertEqual(cells.count, 2, "The basket should have 2 cell, but instead found: \(cells.debugDescription)")
        
        shopButton.tap()
        
        let beansImage = collectionViewsQuery.images["Beans"]
        beansImage.tap()
        beansImage.tap()
        beansImage.tap()
        myBasketButton.tap()
        
        XCTAssertEqual(cells.count, 3, "The basket should have 3 cell, but instead found: \(cells.debugDescription)")
        
        shopButton.tap()
        
        let eggsImage = collectionViewsQuery.images["Eggs"]
        eggsImage.tap()
        eggsImage.tap()
        eggsImage.tap()
        eggsImage.tap()
        myBasketButton.tap()
        
        XCTAssertEqual(cells.count, 4, "The basket should have 4 cell, but instead found: \(cells.debugDescription)")
        
        shopButton.tap()
        tomatoesImage.tap()
        myBasketButton.tap()
        
        XCTAssertEqual(cells.count, 4, "The basket should still have 4 cell, but instead found: \(cells.debugDescription)")
        
    }
    
}
