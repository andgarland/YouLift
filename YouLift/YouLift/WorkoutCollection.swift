//
//  WorkoutCollection.swift
//  YouLift
//
//  Created by rbuzby on 4/25/17.
//  Copyright © 2017 rbuzby. All rights reserved.
//

/*
 
 Data storage for all workouts made in an array
 
*/

import Foundation

class WorkoutCollection {
    
    var collection = [Workout]()
    
    
    //Add in dummy workouts
    init() {
        collection += [
            Workout(name: "Leg Day", exercises: [Exercise(name:"Squat", description:"This is how to do a squat", sets:3, setsArray:[(100, 2), (100, 2), (100, 2)])])
        ]
    }
    
    func add(workout:Workout) {
        collection.append(workout)
    }
    
    func remove(at_index:Int) {
        collection.remove(at: at_index)
    }
    
}
