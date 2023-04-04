//
//  APIService.swift
//  TestPTMidas
//
//  Created by Trevincen Tambunan on 03/04/23.
//

import Foundation

class APIService{
    
    static let shared = APIService()
    
    func get<T: Decodable>(_ type: T.Type, url: URL?,isLogin:Bool = false ,completion: @escaping(Result<T,APIError>) -> Void) {
        
        guard let url = url else {
            let error = APIError.badURL
            completion(Result.failure(error))
            return
        }
        
        var request = URLRequest(url:url)
        
        if isLogin == true {
            print("isLogin = ", isLogin)
            let token = UserDefaults.standard.string(forKey: "userToken")! as String
            print("token : ", token as Any)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        
        let task = URLSession.shared.dataTask(with: request) {(data , response, error) in
            if let error = error as? URLError {
                completion(Result.failure(APIError.url(error)))
            }else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(APIError.badResponse(statusCode: response.statusCode)))
            }else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(type, from: data)
                    completion(Result.success(result))
                    
                }catch {
                    completion(Result.failure(APIError.parsing(error as? DecodingError)))
                }
            }
        }
        
        task.resume()
    }
}
