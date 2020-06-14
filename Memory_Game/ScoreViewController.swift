

import UIKit
import MapKit

class ScoreViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
    var highScoreCell: HighScoreCellUtil?
    var highScoreList:[HighScoreCellUtil] = [HighScoreCellUtil]()
    let dataID = "key"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate  = self
        tableView.dataSource = self
        tableView.reloadData()
        showHighScoreTable()
    }
    
    //MARK - location annotation on map
    func showLocation(){
        for score in highScoreList{
            locationOfPlayerScore(highScoreCell:score)
        }
        
    }
    func locationOfPlayerScore(highScoreCell:HighScoreCellUtil){
            let pointAnnotaion = MKPointAnnotation()
            pointAnnotaion.coordinate = CLLocationCoordinate2D.init(latitude: highScoreCell.latitude, longitude: highScoreCell.logitude)
            mapView.addAnnotation(pointAnnotaion)
            pointAnnotaion.title = String(highScoreCell.timer)
        
        
    }
    //MARK Delegate & DataSource Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return highScoreList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "HighScoreCell") as?HighScoreTableViewCell
        cell?.time_Label.text = String(highScoreList[indexPath.row].timer)
        cell?.date_Label.text = String(highScoreList[indexPath.row].dateOfGame)
        showLocation()
        return cell!
    }
    
    func showHighScoreTable(){
        self.highScoreList = readFromUserDF()
        if(highScoreCell != nil){
            appendToHighScoreList(highScoreCell:highScoreCell!)
        }
        
        
    }
    //MARK - UserDefaults Functions
    func readFromUserDF()-> [HighScoreCellUtil]{
        if let data = UserDefaults.standard.data(forKey: dataID){
        do{
            let JSONdecoder = JSONDecoder()
            self.highScoreList =
                try
                    JSONdecoder.decode([HighScoreCellUtil].self, from: data)
            return self.highScoreList
        }catch{
            print("can't read from UserDefaults")
            }
            
        }
        return [HighScoreCellUtil]()
    }
    
    func writeToUserDF(highScoreListarray:[HighScoreCellUtil]){
        do{
            let JSONencoder = JSONEncoder()
            let data =
                try
                    JSONencoder.encode(highScoreListarray)
                    UserDefaults.standard.set(data, forKey: dataID)
            self.highScoreList = readFromUserDF()
        }catch{
            print("can't write to UserDefaults")
        }
        
        
    }
    func appendToHighScoreList(highScoreCell:HighScoreCellUtil){
        if(highScoreList.count<10){
            self.highScoreList.append(highScoreCell)
            sortHighScoreList()
            writeToUserDF(highScoreListarray: self.highScoreList)
        }
    }
    func sortHighScoreList(){
        
        self.highScoreList = self.highScoreList.sorted(by: {(score1,score2)->Bool in
            return score1.timer<score2.timer
        })
        if (self.highScoreList.count>10){
            self.highScoreList.removeLast()
        }
        
    }


}

//MARK - Inner Class
class HighScoreTableViewCell: UITableViewCell{
    
    @IBOutlet weak var time_Label: UILabel!
    @IBOutlet weak var date_Label: UILabel!
    
}
