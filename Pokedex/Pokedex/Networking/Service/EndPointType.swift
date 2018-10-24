//
//  EndPointType.swift
//  Pokedex
//
//  Created by Flavius Bortas on 10/8/18.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
