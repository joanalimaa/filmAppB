//
//  Movie+API.swift
//  FilmADA
//
//  Created by Francisco Soares Neto on 13/07/22.
//

import Foundation

extension Movie {
    
    //MARK: Download de filmes
    
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
    
    
    static func nowPlayingMoviesAPI() async -> [Movie] {
        
        var components = Movie.urlComponents
        components.path = "/3/movie/now_playing"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: Movie.apiKey)
        ]
        
        let session = URLSession.shared
        
        do{
            let (data, response) = try await session.data(from: components.url!)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let movieResult = try decoder.decode(MovieResponse.self, from: data)
            return movieResult.results
            
        } catch {
            print(error)
            
        }
        
        return []
    }
    
    
    
    static func upcomingMoviesAPI() async -> [Movie] {
        
        var components = Movie.urlComponents
        components.path = "/3/movie/upcoming"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: Movie.apiKey)
        ]
        
        let session = URLSession.shared
        
        do{
            let (data, response) = try await session.data(from: components.url!)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let movieResult = try decoder.decode(MovieResponse.self, from: data)
            return movieResult.results
            
        } catch {
            print(error)
            
        }
        
        return []
    }
    
    
    
    //MARK: Trending API config
    
    
    //Trending Today
    
    static func trendingTodayAPI() async -> [Movie]{
        var components = Movie.urlComponents
        components.path = "/3/trending/movie/day"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: Movie.apiKey)
        ]
        //queryItems query é o que ta chamando do servidor. Sao os ítens que estao passando a mais
        
        let session = URLSession.shared
        // acessar coisas da internet. Gerenciador de acesso a rede (URLSession)
        
        do {
            let (data, response) = try await session.data(from: components.url!)
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let movieResult = try decoder.decode(MovieResponse.self, from: data)
            
            return movieResult.results
            
        } catch {
            print(error)
        }
        
        return []
    }
    
    //Trending This Week
    
    static func trendingThisWeekAPI() async -> [Movie]{
        var components = Movie.urlComponents
        components.path = "/3/trending/movie/week"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: Movie.apiKey)
        ]
        //queryItems query é o que ta chamando do servidor. Sao os ítens que estao passando a mais
        
        let session = URLSession.shared
        // acessar coisas da internet. Gerenciador de acesso a rede (URLSession)
        
        do {
            let (data, response) = try await session.data(from: components.url!)
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let movieResult = try decoder.decode(MovieResponse.self, from: data)
            
            return movieResult.results
            
        } catch {
            print(error)
        }
        
        return []
    }
    
    
    //MARK: Search config
    
    static func searchMoviesAPI(query: String) async -> [Movie] {
        
        //        let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        var components = Movie.urlComponents
        components.path = "/3/search/movie"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: Movie.apiKey),
            URLQueryItem(name: "query", value: query)        ]
        
        let session = URLSession.shared
        
        do {
            let (data, response) = try await session.data(from: components.url!)
            
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let movieResult = try decoder.decode(MovieResponse.self, from: data)
            
            return movieResult.results
        } catch {
            print(error)
        }
        
        return []
        
    }
    
    
    
    
    //MARK: - Dowload de imagens
    
    static func downloadImageData(withPath: String) async -> Data {
        let urlString = "https://image.tmdb.org/t/p/w780\(withPath)"
        let url: URL = URL(string: urlString)!
        
        let session = URLSession.shared
        session.configuration.requestCachePolicy = .returnCacheDataDontLoad //procurar se ja foi baixada se tiver retorna aquilo, se n tiver ele baixa, ignora a data de validade dos dados
        
        do{
            let (imageData, response) = try await session.data(from: url)
            
            return imageData
        } catch {
            print (error)
        }
        
        return Data()
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

