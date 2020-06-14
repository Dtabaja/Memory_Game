
import Foundation

class ModelCard{
    
    func getCards() ->[Card] {
        
        //Declare an array to store numbers we've already generated
        var generatedNmubersArray = [Int]()
        
        //Declare an array to store the generated Cards
        var genearatedCardsArray = [Card]()
        
        //Randomaly generate pairs of cards
        while generatedNmubersArray.count<10{
            
            
            let randomNumber =  arc4random_uniform(10)+1
            
            //Ensure that the random numnber isn't one we already have
            if generatedNmubersArray.contains(Int(randomNumber)) == false{
                
                // Store the number into the generatedNumberArray
                generatedNmubersArray.append(Int(randomNumber))
                //create the first card
                let cardOne = Card()
                cardOne.imageName = "card\(randomNumber)"
                genearatedCardsArray.append(cardOne)
                
                //create the second card
                let cardTwo = Card()
                cardTwo.imageName = "card\(randomNumber)"
                genearatedCardsArray.append(cardTwo)
            }
            
            
        }
        
        
        //Randomize an array
        for i in 0...genearatedCardsArray.count-1 {
            let randomNumber = Int(arc4random_uniform(UInt32(genearatedCardsArray.count)))
            
            //swap the cards
            let temporary = genearatedCardsArray[i]
            genearatedCardsArray[i] = genearatedCardsArray[randomNumber]
            genearatedCardsArray[randomNumber] = temporary
        }
        //Return an array
        return genearatedCardsArray
        
        
        
    }
    
}

