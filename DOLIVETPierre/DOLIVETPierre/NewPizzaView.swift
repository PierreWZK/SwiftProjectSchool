//
//  NewPizzaView.swift
//  DOLIVETPierre
//
//  Created by Cours on 24/03/2023.
//

import SwiftUI

typealias AddPizzaHandler = (_ numberOfSlices: Int, _ hasTomatoBase: Bool, _ hasExtraCheese: Bool, _ hasPickles: Bool, _ comment: String) -> Void

struct NewPizzaView: View {
    @Binding var isPresented: Bool
    @State private var numberOfSlices = 1
    @State private var hasTomatoBase = false
    @State private var hasExtraCheese = false
    @State private var hasPickles = false
    @State private var comment = ""
    var addPizzaHandler: AddPizzaHandler?

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Nombre de parts")) {
                    Stepper(value: $numberOfSlices, in: 1...12) {
                        Text("\(numberOfSlices) parts")
                    }
                }

                Section(header: Text("Base")) {
                    Toggle(isOn: $hasTomatoBase) {
                        Text("Sauce tomate")
                    }
                }

                Section(header: Text("Suppléments")) {
                    Toggle(isOn: $hasExtraCheese) {
                        Text("Fromage")
                    }

                    Toggle(isOn: $hasPickles) {
                        Text("Cornichons")
                    }
                }

                Section(header: Text("Commentaire")) {
                    TextField("Commentaire", text: $comment)
                }

                Button(action: {
                    // Ajouter la nouvelle pizza
                    addPizzaHandler?(numberOfSlices, hasTomatoBase, hasExtraCheese, hasPickles, comment)
                    self.isPresented = false
                }) {
                    Text("Commander")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.black)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("Nouvelle commande")
        }
    }
}

//struct NewPizzaView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewPizzaView()
//    }
//}
