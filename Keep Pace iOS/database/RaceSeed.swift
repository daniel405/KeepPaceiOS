//
//  RaceSeed.swift
//  Keep Pace iOS
//
//  Created by Quincy on 2018-04-30.
//  Copyright © 2018 Daniel Katz. All rights reserved.
//

import Foundation

struct RaceSeed {
    var Name: String
    var Distance: Double
    var Markers: Int64
    
    //Initialize Race Seed with data
    init(_Name: String, _Distance: Double, _Markers: Int64) {
        Name = _Name
        Distance = _Distance
        Markers = _Markers
    }
}
