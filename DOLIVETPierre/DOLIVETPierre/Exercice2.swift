//
//  Exercice2.swift
//  DOLIVETPierre
//
//  Created by Cours on 24/03/2023.
//

import SwiftUI

struct Pizza {
    var numberOfSlices: Int
    var hasTomatoBase: Bool
    var hasExtraCheese: Bool
    var hasPickles: Bool
    var comment: String?
}

struct Exercice2: View {
    @State private var isPresentingNewPizzaView = false
    
    @State var pizzas = [
        Pizza(numberOfSlices: 4, hasTomatoBase: true, hasExtraCheese: true, hasPickles: false, comment: "Sans oignons"),
        Pizza(numberOfSlices: 8, hasTomatoBase: true, hasExtraCheese: false, hasPickles: true, comment: nil),
        Pizza(numberOfSlices: 12, hasTomatoBase: false, hasExtraCheese: false, hasPickles: false, comment: "Très piquante"),
        Pizza(numberOfSlices: 7, hasTomatoBase: false, hasExtraCheese: false, hasPickles: false, comment: nil)
    ]
    
    var body: some View {
        VStack {
            List(pizzas, id: \.numberOfSlices) { pizza in
                VStack(alignment: .leading) {
                    Text("\(pizza.numberOfSlices) parts")
                    if pizza.hasPickles || pizza.hasTomatoBase || pizza.hasExtraCheese {
                        Text("\(pizza.hasTomatoBase ? "🍅" : "")\(pizza.hasExtraCheese ? "🧀" : "")\(pizza.hasPickles ? "🥒" : "")")
                    }
                    if let comment = pizza.comment {
                        Text(comment)
                    }
                }
            }
            .padding(.bottom) // Ajout d'un espace vide en dessous du bouton pour masquer le contenu
            
            Button {
                isPresentingNewPizzaView = true
            } label: {
                Text("Ajouter une commande")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(.black)
                    .cornerRadius(10)
            }
            .padding()
            
        }
        .overlay(alignment: .bottomTrailing) {
            EmptyView() // Ne rien afficher sous le bouton
        }
        .sheet(isPresented: $isPresentingNewPizzaView) {
            NewPizzaView(isPresented: $isPresentingNewPizzaView) { numberOfSlices, hasTomatoBase, hasExtraCheese, hasPickles, comment in
                let newPizza = Pizza(numberOfSlices: numberOfSlices, hasTomatoBase: hasTomatoBase, hasExtraCheese: hasExtraCheese, hasPickles: hasPickles, comment: comment)
                pizzas.append(newPizza)
            }
        }
    }
}

struct Exercice2_Previews: PreviewProvider {
    static var previews: some View {
        Exercice2()
    }
}
