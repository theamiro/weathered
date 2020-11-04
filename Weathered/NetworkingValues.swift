//
//  NetworkingValues.swift
//  Weathered
//
//  Created by Michael Amiro on 04/11/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import Foundation

public enum Environment {
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    
    static let rootURL: String = {
        guard let apiBase = Environment.infoDictionary["API_BASE"] as? String else {
            fatalError("Root URL not set in plist for this environment")
        }
        return apiBase
    }()
    
    static let apiKey: String = {
        guard let apiKey = Environment.infoDictionary["API_KEY"] as? String else {
            fatalError("API Key not set in plist for this environment")
        }
        return apiKey
    }()
}

class NetworkingValues {
    static let apiBase = Environment.rootURL
    static let appid = Environment.apiKey
}
