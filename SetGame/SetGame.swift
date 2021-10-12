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
        var itemFill: String = ""
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
                            itemFill = "noFill"
                        }
                        if (fillOfItem == 1){
                            itemFill = "translucent"
                        }
                        if (fillOfItem == 2){
                            itemFill = "fill"
                        }
                        id += 1
                        deck.append(Card(itemQuantity: itemQuantity,
                                         itemShape: itemShape, itemColor: itemColor,
                                         itemFill: itemFill, id: id))
                    }
                }
            }
        }
    }
    
    mutating func choose(card: Card){
        var playerHasSelectedThreeCards: Bool
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
    
    private func checkIfCardsArePartOfSet(){
        //to be implemented
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
        
        var itemQuantity: Int
        var itemShape: CardContent
        var itemColor: Color
        var itemFill: String
        var id: Int
    }
}
