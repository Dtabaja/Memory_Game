import UIKit

class WelcomeViewController: UIViewController {

    
    
    @IBOutlet weak var PlayButton: UIButton!
    @IBOutlet weak var topTenButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
   
    

    @IBAction func ClickView(_ sender: Any) {
        self.performSegue(withIdentifier: "play", sender: self)
       // let secondView = ViewController()
        print("Daniel")
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier=="play") {
            let secondView = segue.destination as! ViewController
        }
    }
}
