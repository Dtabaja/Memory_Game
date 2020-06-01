//
//  ViewController.swift
//  Memory_Game
//
//  Created by user167528 on 5/2/20.
//  Copyright © 2020 user167528. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var StepsCounter: UILabel!
    
    var model = ModelCard()
    var myCardArray = [Card]()
    
    var firstFlippedCardIndex:IndexPath?
    
    var timer:Timer?
    
    var miliseconds:Float = 0
    
    var numberOfMoves:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //call the getCard method from ModelCard Class
        myCardArray = model.getCards()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
        
        RunLoop.main.add(timer!, forMode: .common)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Timer Method
    
    @objc func timerElapsed(){
        
        miliseconds += 1
        
        //Convert to seconds
        
        let seconds = String(format: "%.2f", miliseconds/1000)
        
        //Set label
        
        timerLabel.text = "Time Remaining: \(seconds)"
        
        //when the timer reaches 0
//        if miliseconds <= 0{
//            //Stop the timer
//            timer?.invalidate()
//            timerLabel.textColor = UIColor.red
//
//            //Check if there are any cards unmatched
//            checkGameEnded()
//
//        }
        
    }
    func movesIncreasing(){
        numberOfMoves+=1
        StepsCounter.text = "Number of Moves:\(numberOfMoves)"
    }
    
    
    
    //  MARK: UICollcetionView  Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myCardArray.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInrow = 4
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumLineSpacing*CGFloat(noOfCellsInrow-1))
        let size = Int((collectionView.bounds.width - totalSpace)/CGFloat(noOfCellsInrow))
        
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //get a card collection view cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        //get the card that the collection view is trying to dispaly
        let card = myCardArray[indexPath.row]
        
        //set that card for the cell
        cell.setCard(card)
        
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //Check if there is any time left
        if miliseconds<=0{
            
            return
        }
        
        
        
        
        
        
        //Get the cell that the user selected
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        //Get the card that the user selected
        let card = myCardArray[indexPath.row]
        
        if card.isFlipped==false &&  card.isMatched==false {
            
            //Flip the card
            cell.filp()
            movesIncreasing()
            //set the status of the card
            card.isFlipped=true
            
            
            //Determine if its the first card or the second card
            
            if firstFlippedCardIndex==nil{
                //this if the firsy card being flipped
                firstFlippedCardIndex = indexPath
            }else{
                //This is the second card
                checkForMatches(indexPath)
                
                
            }
            
        }
    }//End the didSelectIemAt Method
    
    //  Mark:- Game Logic Method
    func checkForMatches(_ secondFlippedCardIndex: IndexPath){
        //Get the cells for the two that were revaled
        
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        
        
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        //Get the cards for the two cards that were revaled
        
        let cardOne = myCardArray[firstFlippedCardIndex!.row]
        let cardTwo = myCardArray[secondFlippedCardIndex.row]
        
        
        
        //compare the two cards
        
        if cardOne.imageName == cardTwo.imageName{
            // it's a match
            
            //set the status of the cards
            cardOne.isMatched = true
            cardTwo.isMatched=true
            
            //Remove the cards from the grid
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
            //Check if there are any cards unmatched
            checkGameEnded()
            
            
        }else{
            
            //set the status of the cards
            cardOne.isFlipped = false
            cardTwo.isFlipped=false
            
            //flip both cards back
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
            
            
        }
        
        //tell the collctionview to reload the cell of the first card if it is nil
        if cardOneCell==nil{
            collectionView.reloadItems(at: [firstFlippedCardIndex!])
            
        }
        //reset the property that track the first  card flipped
        firstFlippedCardIndex = nil
        
        
    }
    func checkGameEnded(){
        //Determine if there are any cards unmatched
        var isWon = true
        
        for card in myCardArray{
            if card.isMatched==false{
                isWon = false
                break
            }
        }
        //messaging alerts
        
        var title = ""
        var message = ""
        
        //if not - then user has won - stop the timer
        if isWon==true{
//            if miliseconds>0{
//                timer?.invalidate()
//
//            }
            title = "Congratulations!"
            message = "You've Won"
            
            
//        }else{
//            //if there are unmatched cards, check if there is any time left
//            if miliseconds>0{
//                return
//            }
//            title = "Game Over!"
//            message = "You've Lost"
//
//       }
        //show won/lost messaging
        showAlert(title, message)
            timer?.invalidate()
        }
    }
    func showAlert(_ title:String, _ message:String){
        
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    
}
