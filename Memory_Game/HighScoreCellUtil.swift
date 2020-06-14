//
//  HighScoreTable.swift
//  Memory_Game
//
//  Created by user167528 on 6/13/20.
//  Copyright © 2020 user167528. All rights reserved.
//

import Foundation

class HighScoreCellUtil: Codable{
    
    var timer: Double = 0.0
    var dateOfGame:String = ""
    var logitude:Double = 0
    var latitude:Double = 0
    
    
    init(){}
    
    init(timer:Double){
        self.timer = timer
        createDate()
        
        
        
    }
    func createDate(){
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        formatter.locale = .current
        self.dateOfGame = formatter.string(from: now)
       
    }
    
}
