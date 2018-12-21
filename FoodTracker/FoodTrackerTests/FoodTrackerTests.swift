//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by 李浩 on 2018/12/16.
//  Copyright © 2018 李浩. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    //MARK: - Meal Class Test
    
    //confirm that the meal initialization returns a meal object when passed valid parameters.
    
    func testMealInitializationSucceeds() {
        //Zero rating
        let zeroReatingMeal = Meal(name: "Zero", photo: nil, rating: 0)
        XCTAssertNotNil(zeroReatingMeal)
        
        //Highest positive rating
        let positiveRatingMeal = Meal(name: "Positive", photo: nil, rating: 5)
        XCTAssertNotNil(positiveRatingMeal)

        // Confirm that the Meal initialier returns nil when passed a negative rating or an empty name.
        
        
    }
    
    func testMealInitializationFials() {
        //negative rating
        let negativeRatingMeal = Meal(name: "Negative", photo: nil, rating: -1)
        XCTAssertNil(negativeRatingMeal)
        
        
        //rating exceeds maxinum
        let largeRatingMeal = Meal(name: "Large", photo: nil, rating: 6)
        XCTAssertNil(largeRatingMeal)
        
        
        //empty string
        let emptyStringMeal = Meal(name: "", photo: nil, rating: 0)
        XCTAssertNil(emptyStringMeal)
        
    }
}
