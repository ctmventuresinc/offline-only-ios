import Foundation
import Combine

class SinService {
    static let shared = SinService()
    
    private let baseURL = "https://intentional-posty.herokuapp.com/api/gpt/priest"
    
    private init() {}
    
    func fetchSinResponse(with prompt: String) async throws -> SinResponse {
        guard let url = URL(string: baseURL) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody = SinRequestBody(prompt: prompt)
        let encoder = JSONEncoder()
        request.httpBody = try encoder.encode(requestBody)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let decoder = JSONDecoder()
        return try decoder.decode(SinResponse.self, from: data)
    }
}
