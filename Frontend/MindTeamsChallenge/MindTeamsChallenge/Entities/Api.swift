//
//  Api.swift
//  MindTeamsChallenge
//
//  Created by Francisco Escobar on 19/10/21.
//

import Foundation

class Api{
    
    private var userDefaults = UserDefaults.standard
    
    func loginWith(email:String, password: String, completionHandler: @escaping (String)->()){
        let url = URL(string: "\(ProcessInfo.processInfo.environment["API_URL"] ?? "")/auth/login")
        
        if let url = url{
            var urlRequest = URLRequest(url: url)
            let da = ["email": email, "password": password]
            
            do{
            let json = try JSONSerialization.data(withJSONObject: da, options: [])
                
                //email anana@gmail.com
                //password 23lkj4h2kj3jkh423
                
                urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
                urlRequest.httpMethod = "POST"
                urlRequest.httpBody = json
                
            }catch{
                print("error \(error)")
            }
            
            let task = URLSession.shared.dataTask(with: urlRequest){ data, response, error in
                
                do{
                    if let data = data{
                        
                        let userData = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                        
                        DispatchQueue.main.async {
                         
                            completionHandler(userData["token"] as! String)
                        }
                    }
                }catch{
                    print("error al parsear \(error)")
                }
                
            }
            
            task.resume()
        }
    }
    
    func getDataFrom(url: String, params:[String:Any], completionHandler: @escaping (Data)->()){
        
        let url = URL(string: "\(ProcessInfo.processInfo.environment["API_URL"] ?? "")/\(url)")
        
        if let url = url{
            var urlRequest = URLRequest(url: url)
                
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.addValue("Bearer \(userDefaults.string(forKey: "token") ?? "")", forHTTPHeaderField: "Authorization")
          
            
            let task = URLSession.shared.dataTask(with: urlRequest){ data, response, error in
                
                if let data = data{
                    
                    DispatchQueue.main.async {
                        
                        completionHandler(data)
                    }
                }
                
                
            }
            
            task.resume()
        }
    }
    
    func postDataFrom(url: String, params:Data, completionHandler: @escaping (Data)->()){
        
        let url = URL(string: "\(ProcessInfo.processInfo.environment["API_URL"] ?? "")/\(url)")
        
        if let url = url{
            var urlRequest = URLRequest(url: url)
            
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.addValue("Bearer \(userDefaults.string(forKey: "token") ?? "")", forHTTPHeaderField: "Authorization")
            
            urlRequest.httpMethod = "POST"
            urlRequest.httpBody = params
            
            let task = URLSession.shared.dataTask(with: urlRequest){ data, response, error in
                
                if let data = data{
                    
                    DispatchQueue.main.async {
                        
                        completionHandler(data)
                    }
                }
                
                
            }
            
            task.resume()
        }
    }
    
    func putData(url: String, params:Data, completionHandler: @escaping (Data)->()){
        
        let url = URL(string: "\(ProcessInfo.processInfo.environment["API_URL"] ?? "")/\(url)")
        
        if let url = url{
            var urlRequest = URLRequest(url: url)
            
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.addValue("Bearer \(userDefaults.string(forKey: "token") ?? "")", forHTTPHeaderField: "Authorization")
            
            urlRequest.httpMethod = "PUT"
            urlRequest.httpBody = params
            
            let task = URLSession.shared.dataTask(with: urlRequest){ data, response, error in
              
                if let data = data{
                    
                    DispatchQueue.main.async {
                        
                        completionHandler(data)
                    }
                }
                
                
            }
            
            task.resume()
        }
    }
    
    func deleteData(url: String, id:Int, completionHandler: @escaping (Data)->()){
        
        let url = URL(string: "\(ProcessInfo.processInfo.environment["API_URL"] ?? "")/\(url)")
        
        do{
            
            let params = try JSONSerialization.data(withJSONObject: ["id": id], options: [])
            
            if let url = url{
                var urlRequest = URLRequest(url: url)
                
                urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
                urlRequest.addValue("Bearer \(userDefaults.string(forKey: "token") ?? "")", forHTTPHeaderField: "Authorization")
                
                urlRequest.httpMethod = "DELETE"
                urlRequest.httpBody = params
                
                let task = URLSession.shared.dataTask(with: urlRequest){ data, response, error in
                    
                    if let data = data{
                        
                        DispatchQueue.main.async {
                            
                            completionHandler(data)
                        }
                    }
                    
                    
                }
                
                task.resume()
            }
        }catch{
            print("error \(error)")
        }
    }
}
