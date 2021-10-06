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
    
    func choose(card: Card){
        // To be implemented
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
        var itemFill: String
        var id: Int
    }
}
