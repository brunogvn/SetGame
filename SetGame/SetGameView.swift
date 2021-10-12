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
                    if card.isSelected{
                        RoundedRectangle(cornerRadius: cornerRadius).fill(card.isMatched ? Color.green : Color.gray)
                            .shadow(color: .black, radius: 5.0, x: 1.0, y: 1.0)
                            .opacity(0.5)
                        
                        RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth).foregroundColor(Color.black)
                    }else{
                        RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                        RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth).foregroundColor(Color.black)
                    }
                    VStack{
                        ForEach(0..<card.itemQuantity){ _ in
                            ZStack {
                                transformStringToShape()
                                    .foregroundColor(card.itemFill == "translucent" ? Color.white : card.itemColor)
                                if(card.itemFill == "translucent"){
                                    transformStringToShapeWithStroke()
                                        .foregroundColor(card.itemColor)
                                }
                            }
                        }
                        .frame(width: 30, height: 15)
                        .opacity(card.itemFill == "noFill" ? 0.3 : 1)
                    }
                }
            }
        }
    }
    
    func transformStringToShape() -> some View{
        
        var returnedView: AnyView?
        
        if(card.itemShape == "capsule"){
            returnedView = AnyView(Capsule())
        }else  if(card.itemShape == "circle"){
            returnedView = AnyView(Circle())
        }else if(card.itemShape == "rectangle"){
            returnedView = AnyView(Rectangle())
        }
        return returnedView!
    }
    
    func transformStringToShapeWithStroke() -> some View{
        
        var returnedView: AnyView?
        
        if(card.itemShape == "capsule"){
            returnedView = AnyView(Capsule().stroke(lineWidth: edgeLineWidth))
        }else  if(card.itemShape == "circle"){
            returnedView = AnyView(Circle().stroke(lineWidth: edgeLineWidth))
        }else if(card.itemShape == "rectangle"){
            returnedView = AnyView(Rectangle().stroke(lineWidth: edgeLineWidth))
        }
        return returnedView!
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
