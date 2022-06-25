//
//  APIRouter+Numbers.swift
//  Numbers Light
//
//  Created by El Mahdi Boukhris on 23/06/2022.
//

import Alamofire

extension APIRouter {
    enum Numbers: APIRoute {
        case numbers
        case number(name: String)

        var baseUrl: URL {
            return URL(string: baseURL)!
        }
        
        var method: HTTPMethod {
            return .get
        }
        
        var path: String {
            return "test/json.php"
        }
        
        var parameters: [String : Any]? {
            switch self {
            case .numbers:
                return nil
            case .number(let name):
                return ["name": name]
            }
        }
        
        var encoding: ParameterEncoding {
            return URLEncoding.default
        }
        
        var headers: HTTPHeaders? {
            return nil
        }
    }
}
