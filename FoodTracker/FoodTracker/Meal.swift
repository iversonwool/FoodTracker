//
//  Meal.swift
//  FoodTracker
//
//  Created by 李浩 on 2018/12/20.
//  Copyright © 2018 李浩. All rights reserved.
//

import UIKit

class Meal {
    //MARK: - Properties
    var name: String
    var rating: Int
    var photo: UIImage?
    
    //MARK: - Initialization
    init?(name: String, photo: UIImage?, rating: Int) {
        guard !name.isEmpty else {
            return nil
        }
        
        guard rating >= 0 && rating <= 5 else {
            return nil
        }
        
        self.name = name
        self.photo = photo
        self.rating = rating
    }
}
