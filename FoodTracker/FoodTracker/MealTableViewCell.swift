//
//  MealTableViewCell.swift
//  FoodTracker
//
//  Created by 李浩 on 2018/12/20.
//  Copyright © 2018 李浩. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var ratingControl: RatingControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
