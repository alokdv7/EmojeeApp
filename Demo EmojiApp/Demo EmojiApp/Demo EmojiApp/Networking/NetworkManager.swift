//
//  NetworkManager.swift
//  NetworkManager
//
//  Created by Alok Yadav on 09/06/23.
//

import Foundation
import UIKit

enum NetworkError:Error{
    case FailedToGetResponse
    case InvalidURL
    case InvalidResponse
    case DataSerializationError
}
// MARK: Network Genric Class
class NetwrokManager{
    
    private var runningRequests = [UUID: URLSessionDataTask]()
    
    func requestData<T:KeyValueModel>(packet:Requestable,keyValueModel:T.Type,completion:@escaping((Result<[T], NetworkError>)->()))->UUID?{
     
        guard let url = URL(string: packet.getCompleteUrl()) else {
            completion(.failure(.InvalidURL))
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = packet.method.rawValue
        let uuid = UUID()
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            defer {
                self.runningRequests.removeValue(forKey: uuid)
            }
            if error != nil {
                completion(.failure(.FailedToGetResponse))
                return
            }
            
            guard let _ = response as? HTTPURLResponse else {
                completion(.failure(.InvalidResponse))
                return
            }
            
            if let data = data{
                do {
                    if  let dictObject = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String:String] {
                    var items = [T]()
                    for item in dictObject{
                        items.append(T.init(key: item.key, value: item.value))
                    }
                        completion(.success(items))
                    }else{
                    completion(.failure(.DataSerializationError))
                    }
                }
                catch {
                    completion(.failure(.DataSerializationError))
                }
            }
            
        }
        task.resume()
        runningRequests[uuid] = task
        return uuid
    }
    
    func requestData<T:Codable>(packet:Requestable,model:T.Type,completion:@escaping((Result<[T], NetworkError>)->()))->UUID?{
     
        guard let url = URL(string: packet.getCompleteUrl()) else {
            completion(.failure(.InvalidURL))
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = packet.method.rawValue
        let uuid = UUID()
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            defer {
                self.runningRequests.removeValue(forKey: uuid)
            }
            if error != nil {
                completion(.failure(.FailedToGetResponse))
                return
            }
            
            guard let _ = response as? HTTPURLResponse else {
                completion(.failure(.InvalidResponse))
                return
            }
            
            if let data = data{
                
                    if  let listObject = try? JSONDecoder().decode([T].self, from: data){
                    completion(.success(listObject))
                    }else if let singleObject = try? JSONDecoder().decode(T.self, from: data){
                        completion(.success([singleObject]))
                    }else{
                        completion(.failure(.DataSerializationError))
                    }
  
            }
            
        }
        task.resume()
        runningRequests[uuid] = task
        return uuid
    }
    
    
    func requestImage(url:String,completion:@escaping((Result<Data, NetworkError>)->()))->UUID?{
        
        guard let url = URL(string: url) else {
            completion(.failure(.InvalidURL))
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        let uuid = UUID()
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            defer {
                self?.cancelRequest(uuid: uuid)
            }
            if error != nil {
                completion(.failure(.FailedToGetResponse))
                return
            }
            
            guard let _ = response as? HTTPURLResponse else {
                completion(.failure(.InvalidResponse))
                return
            }
            
            if let data = data, data.count > 0{
                completion(.success(data))
            }else{
                completion(.failure(.DataSerializationError))
            }
            
        }
        task.resume()
        runningRequests[uuid]=task
        return uuid
    }
    
    
    func cancelRequest(uuid:UUID){
        DispatchQueue.main.async { [weak self] in
            self?.runningRequests[uuid]?.cancel()
            self?.runningRequests.removeValue(forKey: uuid)
        }
    }

}
