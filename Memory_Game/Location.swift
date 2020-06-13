//
//  Location.swift
//  Memory_Game
//
//  Created by user167528 on 6/13/20.
//  Copyright © 2020 user167528. All rights reserved.
//

import Foundation

class Location: Codable{
    
    var longitute: Double = 0
    var latitude: Double = 0
    
    init(longitute: Double, latitude: Double) {
        self.latitude = latitude
        self.longitute = longitute
    }
    
    
    
}
