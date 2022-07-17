//
//  Movie+API.swift
//  FilmADA
//
//  Created by Francisco Soares Neto on 13/07/22.
//

import Foundation

extension Movie {
    
    static let urlComponents = URLComponents(string: "https://api.themoviedb.org/")!
    
    static func popularMoviesAPI() async -> [Movie] {
        
        var components = Movie.urlComponents  //components tem uma regra q requer que ele inicie com barra
        components.path = "/3/movie/popular"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: Movie.apiKey) //chama o arquivo secreto da variavel, dessa forma a chave nao fica acessivel pra qualquer um
        ]
        
        let session = URLSession.shared
        
        do{
            let (data, response) = try await session.data(from: components.url!) //por ser assync ela pode demorar e podemos ter q esperar, ela pode parar de rodar pra esperar algo que ela necessida e depois volta. Como pode demorar precisa ter await
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let movieResult = try decoder.decode(MovieResponse.self, from: data) //descompactar/decodificar um valor de movie a partir dos dados
            return movieResult.results
            
        } catch { //erros sao jogados e alguem pega o erro, vai enviar pra o lugar q precisa dessa resposta (ex: sem conexao de internet)
            print(error) //ja existe a variavel 'erro' pq ele ja sabe q o catch so retorna erros do do
            
        }
        
        return []
    }


    // MARK: - Recuperando a chave da API de um arquivo
    static var apiKey: String {
        guard let url = Bundle.main.url(forResource: "TMDB-Info", withExtension: "plist") else {
            fatalError("Couldn't find api key configuration file.")
        }
        guard let plist = try? NSDictionary(contentsOf: url, error: ()) else {
            fatalError("Couldn't interpret api key configuration file as plist.")
        }
        guard let key = plist["API_KEY"] as? String else {
            fatalError("Couldn't find an api key in its configuration file.")
        }
        return key
    }
}

