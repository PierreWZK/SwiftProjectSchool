//
//  Exercice3.swift
//  DOLIVETPierre
//
//  Created by Cours on 24/03/2023.
//

import SwiftUI
import Kingfisher

// Essaie de l'import d'un package pour avoir les 2 couleurs principales d'une image.
// Non concluant avec le temps fournis.
// De bonnes possibilités.
import UIKit

struct NiceViewExercice3: View {
    
    @State private var movie: Movie?
    let movieId = 65
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.black, .yellow]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(.all)
            ScrollView {
                VStack(spacing: 20) {
                    if let movie = movie {
                        AsyncImage(url: movie.imageUrl) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 400)
                            case .failure:
                                Image(systemName: "exclamationmark.icloud")
                                    .font(.largeTitle)
                                    .foregroundColor(.red)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .frame(height: 400)
                        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top ?? UIWindow().safeAreaInsets.top)
                        Text(movie.title)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        
                        Text(movie.description)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        
                    } else {
                        ProgressView()
                    }
                    
                    NavigationLink {
                        Exercice3()
                    } label: {
                        Text("An another view with less style")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.black)
                            .cornerRadius(10)
                    }.padding()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            
        }
        .onAppear() {
            loadMovies()
        }
    }
    
    func loadMovies() {
        Task {
            let movieURL = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)?api_key=ee6b2b9e0970948e6741d6b7985191fb")!
            
            do {
                let (data, _) = try await URLSession.shared.data(from: movieURL)
                let apiMovie = try JSONDecoder().decode(APIMovie.self, from: data)
                
                let newMovie = Movie(
                    title: apiMovie.title,
                    description: apiMovie.overview,
                    imageUrl: URL(string: "https://image.tmdb.org/t/p/w1280/\(apiMovie.poster_path)")!
                )
                
                self.movie = newMovie
            } catch {
                print("Error loading movie with ID 671: \(error.localizedDescription)")
            }
        }
    }
}

struct NiceViewExercice3_Previews: PreviewProvider {
    static var previews: some View {
        NiceViewExercice3()
    }
}
