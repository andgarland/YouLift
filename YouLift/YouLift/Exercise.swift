//
//  Exercise.swift
//  YouLift
//
//  Created by rbuzby on 4/25/17.
//  Copyright © 2017 rbuzby. All rights reserved.
//

/*
 
 Class for individual exercises within a workout
 
*/

import Foundation

class Exercise{
    
    var name:String
    var description:String
    var sets:Int16
    var setsArray:[(Int16, Int16)]//first int is weight, second is number of reps
    
    init(name:String, description:String, sets:Int16, setsArray:[(Int16, Int16)]) {
        self.name = name
        self.description = description
        self.sets = sets
        self.setsArray = setsArray
    }
}
