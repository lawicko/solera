//
//  soleraTests.swift
//  soleraTests
//
//  Created by Jakub Lawicki on 28.04.17.
//  Copyright © 2017 Jakub Lawicki. All rights reserved.
//

import XCTest
@testable import solera

class soleraTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBasketAddItem() {
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(Basket.sharedInstance.items.count, 0, "Empty basket should have zero items")
        
        for i in 0..<4 {
            Basket.sharedInstance.addItem(item: Item(name: "item"+String(i), price: NSDecimalNumber(decimal:NSNumber(value:50*i).decimalValue) as Decimal))
        }
        
        XCTAssertEqual(Basket.sharedInstance.items.count, 4, "Basket should have 4 items")
    }
}
