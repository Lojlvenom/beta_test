import Foundation

enum Endpoint {
    
    case fetchRepos(url: String = "/search/repositories")
    case fetchPullRequests(url: String)
    
    var request: URLRequest? {
        guard let url = self.url else {return nil }
        var request = URLRequest(url: url)
        request.httpMethod = self.httpMethod
        request.httpBody = self.httpBody
        return request
    }
    
    private var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        components.path = self.path
        components.queryItems = self.queryItems
        
        return components.url
    }
    
    
    private var queryItems: [URLQueryItem] {
        switch self {
            
        case .fetchRepos:
            return [
                URLQueryItem(name: "q", value: "language:Swift"),
                URLQueryItem(name: "sort", value: "stars")
            ]
        case .fetchPullRequests:
            return []
        }
    }
    
    private var path: String {
        switch self {
        case .fetchRepos(let url):
            return url
        case .fetchPullRequests(let url):
            return url
        }
    }
    
    private var httpMethod: String {
        switch self {
        case .fetchRepos, .fetchPullRequests:
            return HTTP.Method.get.rawValue
        }
    }
    
    private var httpBody: Data? {
        switch self {
        case .fetchRepos, .fetchPullRequests:
            return nil
        }
    }
}

