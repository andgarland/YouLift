//
//  WorkoutTableViewController.swift
//  YouLift
//
//  Created by rbuzby on 4/26/17.
//  Copyright © 2017 rbuzby. All rights reserved.
//

import UIKit
import CoreData

class WorkoutTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var customTableView: UITableView!
    
    let tableColor = UIColor(red: 0.73, green: 0.89, blue: 0.94, alpha: 1)
    
    //var fetchedResultsController:NSFetchedResultsController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.tabBarController?.navigationItem.title = "YouLift"
        
        navigationItem.title = "YouLift"
        
         self.view.backgroundColor = UIColor(hue: 0.0, saturation: 0.0, brightness: 0.51, alpha: 1.0)
        
        self.tableView!.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.tableView!.layer.shadowColor = UIColor.black.cgColor
        self.tableView!.layer.shadowRadius = 5
        self.tableView!.layer.shadowOpacity = 0.3
        self.tableView!.layer.masksToBounds = false;
        self.tableView!.clipsToBounds = true;
        
        self.customTableView!.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.customTableView!.layer.shadowColor = UIColor.black.cgColor
        self.customTableView!.layer.shadowRadius = 5
        self.customTableView!.layer.shadowOpacity = 0.3
        self.customTableView!.layer.masksToBounds = false;
        self.customTableView!.clipsToBounds = true;
        
        self.tableView!.backgroundColor = UIColor(red: 0.73, green: 0.89, blue: 0.94, alpha: 1)
        self.customTableView!.backgroundColor = UIColor(red: 0.73, green: 0.89, blue: 0.94, alpha: 1)


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        customTableView.delegate = self
        customTableView.dataSource = self
        
        tableView.alwaysBounceVertical = false;
        customTableView.alwaysBounceVertical = false;
                
        //CoreDataManager.cleanCoreData(entity: "WorkoutTemplateEntity")
        //CoreDataManager.cleanCoreData(entity: "CompletedWorkoutEntity")
        //CoreDataManager.cleanCoreData(entity: "ExerciseEntity")
        
        CoreDataManager.storeDefaultWorkouts()
        
        getTableData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getTableData()
        tableView.reloadData()
        customTableView.reloadData()
    }
    
    func getTableData(){
        workouts = CoreDataManager.fetchWorkoutTemplates()
        customWorkouts = [Workout]()
        defaultWorkouts = [Workout]()
        
        for workout in workouts {
            if workout.1 {
                customWorkouts.append(workout.0)
            }else{
                defaultWorkouts.append(workout.0)
            }
            
            customWorkouts = customWorkouts.sorted(by: {$0.name < $1.name})
            defaultWorkouts = defaultWorkouts.sorted(by: {$0.name < $1.name})
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    private var workouts = [(Workout, Bool)]()
    private var defaultWorkouts = [Workout]()
    private var customWorkouts = [Workout]()

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.customTableView {
            return customWorkouts.count
        }else{
            return defaultWorkouts.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        UITableViewCell.appearance().backgroundColor = tableColor
        
        if tableView == self.tableView {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutTableViewCell", for: indexPath) as? WorkoutTableViewCell else{
                fatalError("Can't get cell of the right kind")
            }
            
            // Configure the cell...
            let workout = defaultWorkouts[indexPath.row]
            cell.configureCell(workout: workout)
            
            return cell
        }
            
        else{
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutTableViewCell", for: indexPath) as? WorkoutTableViewCell else{
                fatalError("Can't get cell of the right kind")
            }
            
            // Configure the cell...
            let workout = customWorkouts[indexPath.row]
            cell.configureCell(workout: workout)
            
            return cell

        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        switch(segue.identifier ?? ""){
        
        case "ViewDefaultWorkout":
            
            guard let destination = segue.destination as? WorkoutDetailViewController else{
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let cell = sender as? WorkoutTableViewCell else{
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: cell) else{
                fatalError("The selected cell can't be found")
            }
            
            let workout = defaultWorkouts[indexPath.row]
            
            destination.workout = workout
            
        case "ViewCustomWorkout":
            
            guard let destination = segue.destination as? WorkoutDetailViewController else{
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let cell = sender as? WorkoutTableViewCell else{
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = customTableView.indexPath(for: cell) else{
                fatalError("The selected cell can't be found")
            }
            
            let workout = customWorkouts[indexPath.row]
            
            destination.workout = workout
            
            
        default:
            fatalError("Unexpeced segue identifier: \(segue.identifier)")
        }
    }
    
    @IBAction func unwindFromEdit(sender: UIStoryboardSegue){
        tableView.reloadData()
    }

}
