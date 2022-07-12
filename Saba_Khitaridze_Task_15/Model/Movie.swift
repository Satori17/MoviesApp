//
//  Movie.swift
//  Saba_Khitaridze_Task_15
//
//  Created by Saba Khitaridze on 11.07.22.
//

import Foundation


struct Movie: Comparable {
    
    static func < (lhs: Movie, rhs: Movie) -> Bool {
        lhs.title < rhs.title
    }
    
    static let allMovies = [
        Movie(title: "Thor: Love & Thunder", releaseDate: "2022", imdb: 7.0, mainActor: "Chris Hemsworth", seen: false, isFavourite: false),
        Movie(title: "Doctor Strange: Multiverse of Madness", releaseDate: "2022", imdb: 7.5, mainActor: "Benedict Cumberbatch", seen: false, isFavourite: false),
        Movie(title: "Captain America: The Winter Soldier", releaseDate: "2014", imdb: 7.8, mainActor: "Chris Evans", seen: false, isFavourite: false),
        Movie(title: "Black Widow", releaseDate: "2021", imdb: 6.7, mainActor: "Scarlett Johansson", seen: false, isFavourite: false),
        Movie(title: "Black Panther", releaseDate: "2018", imdb: 7.3, mainActor: "Chadwick Boseman", seen: false, isFavourite: false),
        Movie(title: "Spider-Man: Far from Home", releaseDate: "2019", imdb: 7.4, mainActor: "Tom Holland", seen: false, isFavourite: false),
        Movie(title: "The Incredible Hulk", releaseDate: "2008", imdb: 6.6, mainActor: "Edward Norton", seen: false, isFavourite: false),
        Movie(title: "Iron Man 3", releaseDate: "2013", imdb: 7.1, mainActor: "Robert Downey Jr", seen: false, isFavourite: false),
        Movie(title: "Captain America: The First Avenger", releaseDate: "2011", imdb: 6.9, mainActor: "Chris Evans", seen: false, isFavourite: false),
        Movie(title: "Guardians of the Galaxy", releaseDate: "2014", imdb: 8.0, mainActor: "Chris Pratt", seen: false, isFavourite: false),
        Movie(title: "Logan", releaseDate: "2017", imdb: 8.1, mainActor: "Hugh Jackman", seen: false, isFavourite: false)
    ].sorted()
    
    let title: String
    let releaseDate: String
    let imdb: Double
    let mainActor: String
    var seen: Bool
    var isFavourite: Bool
    let description = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"
}
