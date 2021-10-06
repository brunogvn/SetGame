//
//  VMSetGame.swift
//  SetGame
//

import SwiftUI


class VMSetGame: ObservableObject{
    @Published private var game: SetGame<String> = VMSetGame.createSetGame(isInit: true)
    
    static func createSetGame(isInit: Bool = false) -> SetGame<String>{
        
        let itemShapeArray: Array<String> = ["capsule","circle","rectangle"]
        
        let itemsCount = isInit ? 0 : itemShapeArray.count
        
        return SetGame<String>(numberOfShapes: itemsCount) {indexOfShape in
            return itemShapeArray[indexOfShape]
        }
    }
    
    
    //MARK: - Access to the Model
    
    var cards: Array<SetGame<String>.Card> {
        game.cardsInHand
    }
    
    //MARK: - Intent
    
    
    func resetGame(){
        game = VMSetGame.createSetGame()
    }
    
    func dealCards(){
        game.dealCards(3)
    }
    
    func choose(card: SetGame<String>.Card) {
        // to be implemented
    }
}
