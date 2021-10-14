//
//  SetGame.swift
//  SetGame
//


import Foundation
import SwiftUI

struct SetGame<CardContent> where CardContent: Equatable{
    var deck: Array<Card>
    var cardsInHand: Array<Card>
    
    
    var arrayOfIndexes = Array<Int>()
    
    init(numberOfShapes: Int, cardContentFactory: (Int) -> CardContent){
        deck = Array<Card>()
        cardsInHand = Array<Card>()
    
        generateCards(numberOfShapes: numberOfShapes, cardContentFactory: cardContentFactory)
 
        deck.shuffle()
        dealCards(12)
    }
    
    mutating func generateCards(numberOfShapes: Int, cardContentFactory: (Int) -> CardContent){
        
        var itemQuantity: Int = 0
        var itemFill: ItemFill?
        var itemColor: Color = .black
        var itemShape: CardContent
        var id: Int = 0
        
        for shapeOfItem in 0..<numberOfShapes {
            
            itemShape = cardContentFactory(shapeOfItem)
            for numberOfItems in 1...3 {
                itemQuantity = numberOfItems
                for colorOfItem in 0..<3 {
                    if (colorOfItem == 0){
                        itemColor = .red
                    }
                    if (colorOfItem == 1){
                        itemColor = .purple
                    }
                    if (colorOfItem == 2){
                        itemColor = .green
                    }
                    for fillOfItem in 0..<3 {
                        if (fillOfItem == 0){
                            itemFill = .noFill
                        }
                        if (fillOfItem == 1){
                            itemFill = .translucent
                        }
                        if (fillOfItem == 2){
                            itemFill = .fill
                        }
                        id += 1
                        deck.append(Card(itemQuantity: itemQuantity,
                                         itemShape: itemShape, itemColor: itemColor,
                                         itemFill: itemFill!, id: id))
                    }
                }
            }
        }
    }
    
    mutating func choose(card: Card){
        var playerHasSelectedThreeCards: Bool
        removeCardsFromHand()
        clearWrongMatch()
        if let chosenIndex: Int = cardsInHand.firstIndex(matching: card), !cardsInHand[chosenIndex].isMatched{
            //If isSelected == false, the app needs to mark the card as selected and add the card index to the arrayOfIndexes
            if cardsInHand[chosenIndex].isSelected == false{
                cardsInHand[chosenIndex].isSelected = !cardsInHand[chosenIndex].isSelected
                
                for indexOfCardInHand in 0..<cardsInHand.count{
                    if cardsInHand[indexOfCardInHand].isSelected == true{
                        //goes through the whole hand and check which cards have isSelected var set as true
                        arrayOfIndexes.append(indexOfCardInHand)
                    }
                }
                playerHasSelectedThreeCards = arrayOfIndexes.count == 3
                if playerHasSelectedThreeCards{
                    checkIfCardsArePartOfSet()
                }
                //Clear the array
                arrayOfIndexes = Array<Int>()
            }else{
                //If isSelected == true, the app needs to mark the card as NOT selected
                cardsInHand[chosenIndex].isSelected = !cardsInHand[chosenIndex].isSelected
            }
            
        }
        
    }
    
    private func switchItemFill(itemFill: ItemFill) -> String {
        switch itemFill {
        case .noFill:
            return "noFill"
        case .translucent:
            return "translucent"
        case .fill:
            return "fill"
        }
    }
    
    mutating private func checkIfCardsArePartOfSet(){
        let shapeOfFirstSelectedCard = cardsInHand[arrayOfIndexes[0]].itemShape
        let shapeOfSecondSelectedCard = cardsInHand[arrayOfIndexes[1]].itemShape
        let shapeOfThirdSelectedCard = cardsInHand[arrayOfIndexes[2]].itemShape
        
        let quantityOfFirstSelectedCard = cardsInHand[arrayOfIndexes[0]].itemQuantity
        let quantityOfSecondSelectedCard = cardsInHand[arrayOfIndexes[1]].itemQuantity
        let quantityOfThirdSelectedCard = cardsInHand[arrayOfIndexes[2]].itemQuantity
        
        let colorOfFirstSelectedCard = cardsInHand[arrayOfIndexes[0]].itemColor
        let colorOfSecondSelectedCard = cardsInHand[arrayOfIndexes[1]].itemColor
        let colorOfThirdSelectedCard = cardsInHand[arrayOfIndexes[2]].itemColor
        
        let fillOfFirstSelectedCard = switchItemFill(itemFill: cardsInHand[arrayOfIndexes[0]].itemFill)
        let fillOfSecondSelectedCard = switchItemFill(itemFill: cardsInHand[arrayOfIndexes[1]].itemFill)
        let fillOfThirdSelectedCard = switchItemFill(itemFill: cardsInHand[arrayOfIndexes[2]].itemFill)
        
        
        let isShapeAMatch = checkIfIsMatch(shapeOfFirstSelectedCard,
                                           shapeOfSecondSelectedCard,
                                           shapeOfThirdSelectedCard)
        
        let isQuantityAMatch = checkIfIsMatch("\(quantityOfFirstSelectedCard)" as! CardContent,
                                              "\(quantityOfSecondSelectedCard)" as! CardContent,
                                              "\(quantityOfThirdSelectedCard)" as! CardContent)
        
        let isColorAMatch = checkIfIsMatch("\(colorOfFirstSelectedCard)" as! CardContent,
                                           "\(colorOfSecondSelectedCard)" as! CardContent,
                                           "\(colorOfThirdSelectedCard)" as! CardContent)
        
        let isFillAMatch = checkIfIsMatch(fillOfFirstSelectedCard as! CardContent,
                                          fillOfSecondSelectedCard as! CardContent,
                                          fillOfThirdSelectedCard as! CardContent)
        
        if isShapeAMatch && isQuantityAMatch && isColorAMatch && isFillAMatch{
            matchCards()
        }else{
            wrongMatch()
        }
        unselectAllCardsInHand()
    }
    
    mutating private func matchCards(){
        cardsInHand[arrayOfIndexes[0]].isMatched = true
        cardsInHand[arrayOfIndexes[1]].isMatched = true
        cardsInHand[arrayOfIndexes[2]].isMatched = true
        
        cardsInHand[arrayOfIndexes[0]].isInHand = false
        cardsInHand[arrayOfIndexes[1]].isInHand = false
        cardsInHand[arrayOfIndexes[2]].isInHand = false
    }
    
    mutating private func wrongMatch(){
        cardsInHand[arrayOfIndexes[0]].wrongMatch = true
        cardsInHand[arrayOfIndexes[1]].wrongMatch = true
        cardsInHand[arrayOfIndexes[2]].wrongMatch = true
    }
    
    mutating private func removeCardsFromHand(){

        var cardsToBeRemoved = Array<Card>()
        

        for index in 0 ..< cardsInHand.count{
            if(cardsInHand[index].isMatched == true){
                cardsToBeRemoved.append(cardsInHand[index])
            }
        }
        
        if cardsToBeRemoved.count == 3{
            let firstCardToBeRemoved = cardsToBeRemoved[0]
            let secondCardToBeRemoved = cardsToBeRemoved[1]
            let thirdCardToBeRemoved = cardsToBeRemoved[2]
            
            cardsInHand.remove(at: cardsInHand.firstIndex(matching: firstCardToBeRemoved)!)
            cardsInHand.remove(at: cardsInHand.firstIndex(matching: secondCardToBeRemoved)!)
            cardsInHand.remove(at: cardsInHand.firstIndex(matching: thirdCardToBeRemoved)!)
            dealCards(3)
        }
    }
    
    
    func checkIfIsMatch(_ cardAtribute1: CardContent, _ cardAtribute2: CardContent, _ cardAtribute3: CardContent) -> Bool{
        let allCardsHaveEqualAtribute: Bool = cardAtribute1 == cardAtribute2 && cardAtribute1 == cardAtribute3
        let allCardsHaveDifferentAtribute: Bool = cardAtribute1 != cardAtribute2 && cardAtribute1 != cardAtribute3 && cardAtribute2 != cardAtribute3
        
        let isMatch: Bool = allCardsHaveDifferentAtribute || allCardsHaveEqualAtribute
        return isMatch
    }
    
    mutating func unselectAllCardsInHand(){
        for indexOfCardInHand in 0..<cardsInHand.count{
            cardsInHand[indexOfCardInHand].isSelected = false
        }
    }
    
    mutating func clearWrongMatch(){
        for indexOfCardInHand in 0..<cardsInHand.count{
            cardsInHand[indexOfCardInHand].wrongMatch = false
        }
    }
    
    mutating func dealCards(_ numberOfCardsToBeDealt: Int){
        if deck.count >= numberOfCardsToBeDealt{
            for _ in 0..<numberOfCardsToBeDealt{
                cardsInHand.append(deck[0])
                cardsInHand[cardsInHand.count-1].isInHand = true
                deck.removeFirst()
            }
        }
    }
    
    struct Card: Identifiable{
        var isMatched: Bool = false
        var isSelected: Bool = false
        var isInHand: Bool = false
        var wrongMatch: Bool = false
        
        
        var itemQuantity: Int
        var itemShape: CardContent
        var itemColor: Color
        var itemFill: ItemFill
        var id: Int
    }
}
