//
//  NetworkAPI.swift
//  Hilmyghozy
//
//  Created by hilmy ghozy on 28/03/22.
//

import Foundation
import Moya

enum NetworkAPI {
    case taskAll
    case taskUncomplete
    case taskComplete
}

extension NetworkAPI: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://620d3fc5b573632593ac1e46.mockapi.io/api/") else { fatalError() }
        return url
    }
    
    var path: String {
        switch self {
        
        case .taskAll:
            return "task-list"
            
        case .taskUncomplete:
            return "task-list-uncompleted"
            
        case .taskComplete:
            return "task-list-completed"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        switch self {
//        case .getData:
//            return Data()
        default:
            return "".utf8Encoded
        }
    }
    
    var task: Task {
        switch self {
        case .taskAll,.taskUncomplete,.taskComplete:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        let basicHeaders:[String:String] = ["Platform": "iOS",
                                            "App-Version": Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String,
                                            "Content-type": "application/json"]
        return basicHeaders
    }
}

extension String {
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
    
    var urlEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    func toJSON() -> [[String: Any]]? {
        guard let responseJson = try? JSONSerialization.jsonObject(with: self.utf8Encoded, options: .mutableContainers) as? [[String: Any]] else {
                return nil
            }
        return responseJson
    }
}
