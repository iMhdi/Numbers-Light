//
//  APIRoute.swift
//  Numbers Light
//
//  Created by El Mahdi Boukhris on 25/06/2022.
//

import Foundation
import Alamofire

public protocol APIRoute {
    var baseUrl: URL {get}
    var method: HTTPMethod {get}
    var path: String {get}
    var parameters: [String: Any]? {get}
    var encoding: ParameterEncoding {get}
    var headers: HTTPHeaders? {get}
}
