//
//  APIRoute+Execute.swift
//  Numbers Light
//
//  Created by El Mahdi Boukhris on 25/06/2022.
//

import Foundation
import Alamofire

extension APIRoute {
    @discardableResult
    public func execute<R: Codable> (withCompletionHandler completionHandler: @escaping APIRouter.APIResponse<R>) -> DataRequest? {
        return APIRouter.execute(withRoute: self) { response in
            switch response.result {
            case .success(let value):
                APIRouter.handleResult(value, completionCall: completionHandler)
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
