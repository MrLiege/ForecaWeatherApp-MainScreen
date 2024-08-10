//
//  AuthEndpoint.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 08.08.2024.
//

import Foundation
import Moya

enum AuthEndpoint: TargetType {
    case postToken
    
    var baseURL: URL {
        guard let url = URL(string: "https://pfa.foreca.com") else {
            fatalError("Incorrect \(self) baseURL!")
        }
        
        return url
    }
    
    //MARK: - Cases of path
    var path: String {
        return "/authorize/token"
    }
    
    //MARK: - Methods
    var method: Moya.Method {
        .post
    }
    
    //MARK: - Tasks
    var task: Moya.Task {
        var params = [String : Any]()
        params["user"] = APISecureKeys.login
        params["password"] = APISecureKeys.password
        return .requestCompositeParameters(bodyParameters: params, bodyEncoding: JSONEncoding.default, 
                                           urlParameters: ["expire_hours" : -1])
    }
    
    //MARK: - Headers
    var headers: [String : String]? { nil }
}
