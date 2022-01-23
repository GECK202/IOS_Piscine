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
    let token: String
    
    init(delegate: APITwitterDelegate, token: String) {
        self.delegate = delegate
        self.token = token
    }
    
    func queryRequest(find: String){
        guard let info = URL(string: "https://api.twitter.com/1.1/search/tweets.json?q=\(find)&count=100&lang=en&result_type=recent".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!) else { return }
               
        guard let url = URLRequest(url: info) else { return }
        url.httpMethod = "GET"
        url.setValue("Bearer \(self.token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                self.delegate?.error(error: error! as NSError)
            }
            else
            {
                do {
                    let dic = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                    print(dic)
                    var t : [Tweet] = []
                    let statuses: [NSDictionary] = (dic["statuses"] as? [NSDictionary])!
                    for d in statuses {
                        let name = d["user"] as! NSDictionary
                        let text = d["text"]
                        t.append(Tweet(name: name.value(forKey: "name")! as! String, text: text! as! String, date: date! as! String))
                    }
                    self.delegate?.manage(name: t)
                }
                catch let err
                {
                    print(err)
                }
            }
        }
        task.resume()
    }
}
