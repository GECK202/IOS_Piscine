//
//  APIController.swift
//  TweetsViewer
//
//  Created by Valeria Karon on 1/23/22.
//  Copyright © 2022 Valeria Karon. All rights reserved.
//

import Foundation



class APIController {
    weak var delegate: APITwitterDelegate?
    let token: String?
    
    init() {
        self.token = ""
    }
    
    init(delegate: APITwitterDelegate, token: String) {
        self.delegate = delegate
        self.token = token
    }
    
    func queryRequest(find: String){
        
        //let urlString2 = "https://api.twitter.com/1.1/search/tweets.json?q=\(find)&count=100&lang=en&result_type=recent".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let urlString = "https://jsonplaceholder.typicode.com/posts"
        guard let url = URL(string: urlString) else { return }
        
        
                       
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        //request.setValue("Bearer \(self.token)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                self.delegate?.error(error: error! as NSError)
            }
            else
            {
                guard let response = response, let data = data else { return }
                print("response=\(response)\n")
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                    print("json=\(jsonObject)")
                    /*
                    var t : [Tweet] = []
                    let statuses: [NSDictionary] = (dic["statuses"] as? [NSDictionary])!
                    for d in statuses {
                        let name = d["user"] as! NSDictionary
                        let text = d["text"]
                        t.append(Tweet(name: name.value(forKey: "name")! as! String, text: text! as! String, date: date! as! String))
                    }
                    self.delegate?.manage(name: t)
                    */
                }
                catch let error
                {
                    print(error)
                }
            }
        }.resume()
    }
}
