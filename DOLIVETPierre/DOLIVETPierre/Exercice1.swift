//
//  Exercice1.swift
//  DOLIVETPierre
//
//  Created by Cours on 24/03/2023.
//

import SwiftUI

struct Exercice1: View {
    @State private var isClicked = false
    
    var body: some View {
        Button(action: {
            self.isClicked.toggle()
        }) {
            Text("My Button")
                .foregroundColor(isClicked ? .white : .black)
        }
        .padding()
        .background(isClicked ? Color.primary : Color.white)
        .border(Color.black, width: 1)
    }
}

struct Exercice1_Previews: PreviewProvider {
    static var previews: some View {
        Exercice1()
    }
}
