//
//  MovieResponse.swift
//  AgoraVai1
//
//  Created by Joana Lima on 15/07/22.
//

import Foundation

struct MovieResponse: Codable { //A resposta tem um array de filmes
    let results: [Movie]
}
