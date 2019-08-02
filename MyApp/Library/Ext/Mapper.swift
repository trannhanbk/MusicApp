//
//  Mapper.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/13/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

extension Mapper {
    func map(result: Result<Any>, completion: (Result<N>) -> Void ) {
        switch result {
        case .success(let json):
            guard let obj = json as? JSObject else {
                completion(.failure(Api.Error.emptyData))
                return
            }

            guard let objects = Mapper<N>().map(JSON: obj) else {
                completion(.failure(Api.Error.emptyData))
                return
            }

            completion(.success(objects))
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
