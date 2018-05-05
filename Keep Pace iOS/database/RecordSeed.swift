//
//  RecordSeed.swift
//  Keep Pace iOS
//
//  Created by Quincy Lam on 2018-05-04.
//  Copyright © 2018 Group 10. All rights reserved.
//

import Foundation

struct RecordSeed {
    //Average Pace
    var AveragePace: Double

    //Time
    var Time: Int64
    
    //Date
    var mDate: String
    
    //Initialize RecordSeed with Dummy Data
    init(_AveragePace: Double, _Time: Int64, _Date: String) {
        AveragePace = _AveragePace
        Time = _Time
        mDate = _Date
    }
}
