//
//  RaceSeed.swift
//  Keep Pace iOS
//
//  Created by Quincy on 2018-04-30.
//  Copyright © 2018 Daniel Katz. All rights reserved.
//

import Foundation

//This data structure will be used to help seed race data
struct RaceSeed {
    //Name of the race
    var Name: String
    
    //Distance
    var Distance: Double
    
    //Number of Markers
    var Markers: Int64
    
    //Initialize RaceSeed with Dummy Data
    init(_Name: String, _Distance: Double, _Markers: Int64) {
        Name = _Name
        Distance = _Distance
        Markers = _Markers
    }
}
