import UIKit

class WelcomeViewController: UIViewController {
    
    
    
    @IBOutlet weak var PlayButton: UIButton!
    @IBOutlet weak var topTenButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func ClickViewTopTen(_ sender: Any) {
        self.performSegue(withIdentifier: "TopTen", sender: self)
        
    }
    
    @IBAction func ClickView(_ sender: Any) {
        self.performSegue(withIdentifier: "play", sender: self)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if (segue.identifier=="play") {
            _ = segue.destination as! ViewController
            
        }
        if (segue.identifier=="TopTen") {
            _ = segue.destination as! ScoreViewController
        }
    }
    
}
