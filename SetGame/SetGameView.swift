//
//  SetGameView.swift
//  SetGame
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var viewModel: VMSetGame
    @State var show: Bool = false
    
    var body: some View {
        ZStack{
            Grid(viewModel.cards){ card in
                CardView(card: card).onTapGesture {
                    withAnimation(.easeInOut(duration: 0.5)){
                        viewModel.choose(card: card)
                    }
                }
                .aspectRatio(CGSize(width: 2, height: 3), contentMode: .fit)
                .padding(5)
            }
        }
        .onAppear{
            withAnimation(.easeInOut(duration: 1)) {
                viewModel.resetGame()
            }
        }
        
        
        
        HStack{
            Button(action: {
                withAnimation(.easeInOut(duration: 1)){
                    self.viewModel.resetGame()
                }
            },
            label: {
                Text("New Game")
            })
            .padding(EdgeInsets(top: 5, leading: 5, bottom: 15, trailing: 5))
            Button(action: {
                withAnimation(.easeInOut(duration: 0.5)){
                    self.viewModel.dealCards()
                }
            },
            label: {
                Text("Deal 3 cards")
            })
            .padding(EdgeInsets(top: 5, leading: 5, bottom: 15, trailing: 5))
        }
    }
}

struct CardView: View {
    var card: SetGame<String>.Card
    
    var body: some View{
        GeometryReader{ geometry in
            Group{
                ZStack{
                    RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                    RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth).foregroundColor(Color.black)
                }
            }
        }
    }
    
    
    // MARK - Drawing Constance
    
    let cornerRadius: CGFloat = 10
    let edgeLineWidth: CGFloat = 3
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(viewModel: VMSetGame())
    }
}
