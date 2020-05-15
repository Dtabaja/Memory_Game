
import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var frontImageview: UIImageView!
    @IBOutlet weak var backImageView: UIImageView!
    
    var card:Card?
    
    func setCard(_ card:Card){
        
        //keep track of the card taht gets passed in
        self.card = card
        
        frontImageview.image = UIImage(named: card.imageName)
        
        if card.isMatched==true{
            
            //If the card has been matched, then make the image view invisible
            self.backImageView.alpha = 0
            self.frontImageview.alpha = 0
            
            return
        }
        else {
            //If the card has not been matched, then make the image view visible
            self.backImageView.alpha = 1
            self.frontImageview.alpha = 1
        }
        
        //Determine if the card is in Filpped up state or flipped down state
        
        if card.isFlipped == true{
            UIView.transition(from: self.backImageView, to: self.frontImageview, duration: 0, options: [.transitionFlipFromRight,.transitionFlipFromLeft
            ], completion: nil)
        }else{
            UIView.transition(from: self.frontImageview, to: self.backImageView, duration: 0, options: [.transitionFlipFromLeft,.showHideTransitionViews], completion: nil)
            
        }
        
    }
    
    func filp(){
        
        UIView.transition(from: self.backImageView, to: self.frontImageview, duration: 0.3, options: [.transitionFlipFromRight,.showHideTransitionViews], completion: nil)
        
        
    }
    
    func flipBack(){
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            UIView.transition(from: self.frontImageview, to: self.backImageView, duration: 0.3, options: [.transitionFlipFromLeft,.showHideTransitionViews], completion: nil)
            
        }
        
        
    }
    
    func remove(){
        
        //Remove both imageviews from being visible
        backImageView.alpha=0
        UIView.animate(withDuration: 0.3, delay: 0.9, options: .curveEaseOut, animations: {
            self.frontImageview.alpha=0
            
        }, completion: nil)
        
    }
    
}
