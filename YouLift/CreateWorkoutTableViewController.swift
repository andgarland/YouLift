//
//  CreateWorkoutTableViewController.swift
//  YouLift
//
//  Created by rbuzby on 5/1/17.
//  Copyright © 2017 rbuzby. All rights reserved.
//

import UIKit

class CreateWorkoutTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    var exercises = [Exercise]()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var saveButton: UIButton!
    
    var editButton:UIBarButtonItem?
    var doneButton:UIBarButtonItem?
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        if exercises.count > 0 {
            self.navigationItem.rightBarButtonItem = editButton
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editButton = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.plain, target: self, action: #selector(WorkoutDetailViewController.edit(sender:)))
        
        doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(WorkoutDetailViewController.doneEditing(sender:)))
        
        self.view.backgroundColor = UIColor(hue: 0.0, saturation: 0.0, brightness: 0.51, alpha: 1.0)
        
        self.tableView!.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.tableView!.layer.shadowColor = UIColor.black.cgColor
        self.tableView!.layer.shadowRadius = 5
        self.tableView!.layer.shadowOpacity = 0.3
        self.tableView!.layer.masksToBounds = false;
        self.tableView!.clipsToBounds = false;
        self.tableView!.backgroundColor = UIColor(red: 0.73, green: 0.89, blue: 0.94, alpha: 1)
        
        
        addButton.layer.cornerRadius = 4
        addButton.layer.borderWidth = 1
        addButton.backgroundColor = UIColor(red: 0, green: 0.478431, blue: 1, alpha: 1)
        addButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        addButton.layer.shadowColor = UIColor.black.cgColor
        addButton.layer.shadowRadius = 5
        addButton.layer.shadowOpacity = 0.3
        
        saveButton.layer.cornerRadius = 4
        saveButton.layer.borderWidth = 1
        saveButton.backgroundColor = UIColor(red: 0.117, green: 0.843, blue: 0.376, alpha: 1)
        saveButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        saveButton.layer.shadowColor = UIColor.black.cgColor
        saveButton.layer.shadowRadius = 5
        saveButton.layer.shadowOpacity = 0.3
        

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        tableView.dataSource = self
        tableView.delegate = self
        workoutNameField.delegate = self
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CreateWorkoutTableViewController.hideKeyboard)))
        
        tableView.reloadData()
        
        tableView.tableFooterView = UIView()
        
//        CoreDataManager.storeExercise(exercise: Exercise(name: "Leg Press", description: "Place your legs on the platform and push them forward until they fully extend, then slow bring your legs back to a 90 degree angle and repeat.", sets: 3, setsArray: [(100, 3), (100, 3), (100, 3)]))
        
    }
    
    func hideKeyboard() {
        workoutNameField.resignFirstResponder()
    }
    
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseTableViewCell", for: indexPath) as? ExerciseTableViewCell else{
            fatalError("Can't get cell of the right kind")
        }
        
        // Configure the cell...
        let exercise = exercises[indexPath.row]
        cell.configureCell(exercise: exercise)
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            //tableView.deleteRows(at: [indexPath], with: .fade)
//            exercises.remove(at: indexPath.row)
//            tableView.reloadData()
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
    
    
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
    
    // prepare to go to the detail view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        switch(segue.identifier ?? ""){
        case "AddExercise":
            //do nothing
            break
            
        case "Done":
            //do nothing
            break
            
        case "EditExercise":
            guard let destination = segue.destination as? CreateWorkoutDetailViewController else{
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let cell = sender as? ExerciseTableViewCell else{
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: cell) else{
                fatalError("The selected cell can't be found")
            }
            
            let exercise = exercises[indexPath.row]
            
            destination.type = .update(exercise.name, exercise.description, exercise.sets, exercise.setsArray, indexPath.row)
            
            destination.callback = { (exerciseName, exerciseDescription, sets, setsArray) in
                exercise.name = exerciseName
                exercise.description = exerciseDescription
                exercise.sets = sets
                exercise.setsArray = setsArray
            }

            
        default:
            fatalError("Unexpeced segue identifier: \(segue.identifier)")
        }
    }
    
    @IBAction func unwindFromEdit(sender: UIStoryboardSegue){
        
        if let sourceViewController = sender.source as? CreateWorkoutDetailViewController {
            
            let exercise = sourceViewController.exercise
            
            exercises.append(exercise)
        }
        tableView.reloadData()
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        workoutNameField.resignFirstResponder()
        return true
    }
    
    @IBOutlet weak var workoutNameField: UITextField!
    
    
    @IBAction func saveWorkout(_ sender: Any) {
    
//        if exercises.count > 0 {
//            
//            let alert = UIAlertController(title: "Are you sure you would like to save this Workout?", message: nil, preferredStyle: UIAlertControllerStyle.alert)
//            
//            alert.addAction(UIAlertAction(title: "Save", style: UIAlertActionStyle.default, handler: { action in
//                var workoutName: String?
//                
//                if self.workoutNameField.text == nil {
//                workoutName = "New Workout"
//                }
//                else {
//                workoutName = self.workoutNameField.text
//                }
//                
//                let newWorkout = Workout(name: workoutName!, exercises: self.exercises)
//                
//                CoreDataManager.storeWorkoutTemplate(workout: newWorkout)
//                
//                self.exercises.removeAll()
//                
//                self.performSegue(withIdentifier: "Done", sender: self)
//                
//                }))
//            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.destructive, handler: nil))
//            
//            self.present(alert, animated: true, completion: nil)
//        }
        let workout = Workout(name: workoutNameField.text!, exercises: exercises)
        AlertManager.saveAlert(sender: self, workout: workout)
    }
    
    
    @IBAction func deleteExercise(_ sender: Any) {
        exercises.remove(at: exercises.count-1)
        tableView.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            exercises.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            if exercises.count < 1 {
                self.navigationItem.rightBarButtonItem = nil
            }
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to toIndexPath: IndexPath) {
        
        var exerciseToMove = exercises[fromIndexPath.row]
        exercises.remove(at: fromIndexPath.row)
        exercises.insert(exerciseToMove, at: toIndexPath.row)
    }
    
    func edit(sender: UIBarButtonItem){
        self.tableView.setEditing(true, animated: true)
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    func doneEditing(sender: UIBarButtonItem){
        self.tableView.setEditing(false, animated: true)
        self.navigationItem.rightBarButtonItem = editButton
        tableView.reloadData()
    }
    
}
