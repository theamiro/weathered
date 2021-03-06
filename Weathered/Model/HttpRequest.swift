//
//  HttpRequest.swift
//  Weathered
//
//  Created by Michael Amiro on 04/11/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import Foundation


enum ResponseError: Error {
    case generalError
    case noDataAvailable
    case jsonNotDecodable
    case httpResponseBlock
    case mimeTypeError
}
extension ResponseError: LocalizedError{
    public var errorDescription: String? {
        switch self {
            case .generalError:
                return "Weathered ran into a problem."
            case .httpResponseBlock:
                return "Network error. Please check your internet and try again."
            case .noDataAvailable:
                return "Uuuum... There's no data available. We can't explain."
            case .jsonNotDecodable:
                return "We ran into a problem trying to prepare your data. Sorry."
            case .mimeTypeError:
                return "We cannot assert the kind of data we received."
        }
    }
}
enum Units {
    case standard, metric, imperial
}

struct APIRequest {
    /// Makes Calls to the API
    ///
    /// - Returns: Completion
    func makeCall(latitude: Double, longitude: Double, units: Units = .metric, completion: @escaping(Result<WeatherResponse, ResponseError>) -> Void) {
        let stringURL = NetworkingValues.apiBase + "?lat=\(latitude)&lon=\(longitude)&appid=\(NetworkingValues.appid)&units=\(units)"
        guard let resourceURL = URL(string: stringURL) else { return }
        URLSession.shared.dataTask(with: resourceURL) { (data, response, error) in
            // Check header response
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    completion(.failure(.httpResponseBlock))
                    return
            }
            // Check mime type
            guard let mime = response?.mimeType, mime == "application/json" else {
                completion(.failure(.mimeTypeError))
                return
            }
            if error != nil{
                completion(.failure(.generalError))
                return
            }
            guard let data = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do {
                let apiResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completion(.success(apiResponse))
            } catch {
                completion(.failure(.jsonNotDecodable))
                return
            }
        }.resume()
    }
}
