//
//  JSONParameterEncoder.swift
//  Pokedex
//
//  Created by Flavius Bortas on 10/8/18.
//

import Foundation

struct JSONParameterEncoder: ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonData
            
            // What is "Content-Type"? - The Media type of the body of the request (used with POST and PUT requests).
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        } catch {
            throw NetworkError.encodingFailed
        }
    }
}
