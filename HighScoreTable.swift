//
//  HighScoreTable.swift
//  Memory_Game
//
//  Created by user167528 on 6/13/20.
//  Copyright © 2020 user167528. All rights reserved.
//

import Foundation

class HighScoreTable: Codable{
    
    var timer: Double = 0.0
    var dateOfGame:String = ""
    var logitude:Double = 0
    var latitude:Double = 0
    
    
    
    init(timer:Double){
        self.timer = timer
        self.dateOfGame = createDate()
        
        
        
    }
    func createDate()->String{
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        formatter.locale = .current
        self.dateOfGame = formatter.string(from: now)
        return dateOfGame
    }
    
}
