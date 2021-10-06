//
//  Grid.swift
//  SetGame
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View{
    var items:[Item]
    var viewForItem: (Item) -> ItemView
    

    
    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView){
        self.items = items
        self.viewForItem = viewForItem
    }

    
    
    var body: some View {
        GeometryReader{ geometry in
            ForEach(items) { item in
                let index = items.firstIndex(matching: item)!
                let frameWidth = GridLayout(itemCount: self.items.count, in: geometry.size).itemSize.width
                let frameHeight = GridLayout(itemCount: self.items.count, in: geometry.size).itemSize.height
                let framePosition = GridLayout(itemCount: self.items.count, in: geometry.size).location(ofItemAt: index)

                viewForItem(item)
                    .frame(width: frameWidth, height: frameHeight)
                    .position(framePosition)
            }
        }
    }
}
