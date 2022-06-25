//
//  APIRouter.swift
//  Numbers Light
//
//  Created by El Mahdi Boukhris on 23/06/2022.
//

import Foundation
import Alamofire

open class APIRouter {
    public typealias APIResponse<R> = ((Result<R, Error>)->())
}

// MARK: - Request execution
extension APIRouter {
    @discardableResult
    internal static func execute(withRoute route: APIRoute,
                                 completionCall: @escaping ((AFDataResponse<Data>)->())) -> DataRequest {
        let urlRequest = route.baseUrl.appendingPathComponent(route.path)
        
        return AF.request(urlRequest,
                          method: route.method,
                          parameters: route.parameters,
                          encoding: route.encoding,
                          headers: route.headers).responseData { response in
            completionCall(response)
        }
    }
}

// MARK: - Response Handling
extension APIRouter {
    
    internal static func handleResult<R: Codable> (_ data: Data, completionCall: APIResponse<R>) {
        let result = Result(catching: { try JSONDecoder().decode(R.self, from: data) })
        completionCall(result)
    }
}
