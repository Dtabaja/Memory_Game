

import UIKit
import MapKit

class ScoreViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var Back_BTN: UIButton!
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
        showLocation()
    }
    
    //MARK: location annotation on map
    func showLocation(){
        for score in highScoreList{
            locationOfPlayerScore(highScoreCell:score)
            print(highScoreList.count)
        }
        
    }
    
    
    func locationOfPlayerScore(highScoreCell:HighScoreCellUtil){
        let pointAnnotaion = MKPointAnnotation()
        pointAnnotaion.coordinate = CLLocationCoordinate2D.init(latitude: highScoreCell.latitude, longitude: highScoreCell.logitude)
        mapView.addAnnotation(pointAnnotaion)
        let seconds = String(format:"%02d", (highScoreCell.timer % 60))
        let minutes = String(format:"%02d", (highScoreCell.timer / 60))
        pointAnnotaion.title = "\(minutes):\(seconds)"
        
        
    }
    //MARK: Delegate & DataSource Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return highScoreList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "HighScoreCell") as?HighScoreTableViewCell
        let seconds = String(format:"%02d", (highScoreList[indexPath.row].timer % 60))
        let minutes = String(format:"%02d", (highScoreList[indexPath.row].timer / 60))
        cell?.time_Label.text = "\(minutes):\(seconds)"
        cell?.date_Label.text = String(highScoreList[indexPath.row].dateOfGame)
        
        return cell!
    }
    
    func showHighScoreTable(){
        self.highScoreList = readFromUserDF()
        if(highScoreCell != nil){
            appendToHighScoreList(highScoreCell:highScoreCell!)
        }
        
        
    }
    //MARK: UserDefaults Functions
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
    //MARK: appand and update score list
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
    
    
    @IBAction func clickedBack(_ sender: Any) {
        self.performSegue(withIdentifier: "BackToMain", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if (segue.identifier=="BackToMain") {
            _ = segue.destination as! WelcomeViewController
            
        }
    }
}

//MARK: Inner Class
class HighScoreTableViewCell: UITableViewCell{
    
    @IBOutlet weak var time_Label: UILabel!
    @IBOutlet weak var date_Label: UILabel!
    
}
