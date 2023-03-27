//
//  ContentView.swift
//  DOLIVETPierre
//
//  Created by Cours on 24/03/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Exercice1()
                .tabItem {
                    HStack {
                        Image(systemName: "circle.lefthalf.fill")
                        Text("Exercice 1")
                    }
                }
            Exercice2()
                .tabItem {
                    HStack {
                        Image(systemName: "cart")
                        Text("Exercice 2")
                    }
                }
            Exercice3()
                .tabItem {
                    HStack {
                        Image(systemName: "film")
                        Text("Exercice 3")
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
