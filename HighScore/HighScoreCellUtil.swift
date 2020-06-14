
import Foundation

class HighScoreCellUtil: Codable{
    
    var timer: Int = 0
    var dateOfGame:String = ""
    var logitude:Double = 0
    var latitude:Double = 0
    
    
    init(){}
    
    init(timer:Int){
        self.timer = timer
        self.dateOfGame =  createDate()
        
        
        
    }
    func createDate()-> String{
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        formatter.locale = .current
        return formatter.string(from: now)
        
    }
    
}
