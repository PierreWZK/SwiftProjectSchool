//
//  Exercice3.swift
//  DOLIVETPierre
//
//  Created by Cours on 24/03/2023.
//

import SwiftUI

struct Movie {
    var title: String
    var description: String
    var imageUrl: URL
}

struct APIMovie: Codable {
    var title: String
    var overview: String
    var poster_path: String
}

struct Exercice3: View {
    
    @State private var movie: Movie?
    let movieId = 65
    
    var body: some View {
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
                Text(movie.title)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                Text(movie.description)
                    .multilineTextAlignment(.center)
                    .padding()
                    .foregroundColor(.gray)
            } else {
                ProgressView()
            }
            
            NavigationLink {
                NiceViewExercice3()
            } label: {
                Text("An another view with more style")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.black)
                    .cornerRadius(10)
            }.padding()
        }
        .background(Color.white)
        .navigationBarTitleDisplayMode(.inline)
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


struct Exercice3_Previews: PreviewProvider {
    static var previews: some View {
        Exercice3()
    }
}
