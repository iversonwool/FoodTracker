//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by 李浩 on 2018/12/20.
//  Copyright © 2018 李浩. All rights reserved.
//



//可以参考这篇简书文章
//https://www.jianshu.com/p/8d2d13793bc9

import UIKit
import os.log

class MealTableViewController: UITableViewController {
    
    //MARK: - Properties
    var meals = [Meal]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        if let savedMeals = loadMeals() {
            meals += savedMeals
        } else {
            loadSampleMeals()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MealTableViewCell"
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }

        // Configure the cell...
        
        let meal = meals[indexPath.row]
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            meals.remove(at: indexPath.row)
            savaMeals()
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier ?? "" {
        case "addItem":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
        case "showDetail":
            guard let mealDetailViewController = segue.destination as? MealViewController else {
                fatalError("unexpected destination;\(segue.destination)")
            }
            guard let selectedMealCell = sender as? MealTableViewCell else {
                fatalError("unexpected sender;\(String(describing: sender))")
            }
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                fatalError("the selected cell is not being displayed by the table")
            }
            let selectMeal = meals[indexPath.row]
            mealDetailViewController.meal = selectMeal
            
        default:
            fatalError("Unexpected Segue Indentifier;\(segue.identifier ?? "unexpected")")
        }
    }
    
    
    //MARK: - Private Methods
    private func loadSampleMeals() {
        let photo1 = UIImage(named: "meal1")
        let photo2 = UIImage(named: "meal2")
        let photo3 = UIImage(named: "meal3")
        
        guard let meal1 = Meal(name: "Caprese Salad", photo: photo1, rating: 4) else {
            fatalError("unable to instantiate meal1")
        }
        guard let meal2 = Meal(name: "Chicken and Potatoes", photo: photo2, rating: 5) else {
            fatalError("unable to instantiate meal2")
        }
        guard let meal3 = Meal(name: "Pasta with Meatball", photo: photo3, rating: 3) else {
            fatalError("unable to instantiate meal3")
        }
        meals += [meal1, meal2, meal3]
    }
    
    private func savaMeals() {
        let data = try! NSKeyedArchiver.archivedData(withRootObject: meals, requiringSecureCoding: false)
        
        do {
            try data.write(to: Meal.ArchiveURL)
        } catch  {
            print("couldn't archive data: \(error.localizedDescription)")
        }
    }
    
    private func loadMeals() -> [Meal]? {
        
        guard let codeData = try? Data(contentsOf: Meal.ArchiveURL) else {
            return nil
        }
        return try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(codeData) as? [Meal]
    }
    
    //MARK: - Actions
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? MealViewController, let meal = sourceViewController.meal {
            
            //edit
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                meals[selectedIndexPath.row] = meal
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                //add
                let newIndexPath = IndexPath(row: meals.count, section: 0)
                meals.append(meal)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            savaMeals()
        }
    }

}
