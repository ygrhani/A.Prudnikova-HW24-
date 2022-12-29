//
//  NewPostVC.swift
//  A. Prudnikova (HW24)
//
//  Created by Ann Prudnikova on 29.12.22.
//

import UIKit
import SwiftyJSON
import Alamofire

class NewPostVC: UIViewController {
    
    var user: User?

    @IBOutlet weak var bodyTF: UITextView!
    @IBOutlet weak var titleTF: UITextField!
    
    @IBOutlet weak var alomafireBttn: UIButton!
    @IBOutlet weak var urlBttn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleTF.placeholder = "Please enter title"
        alomafireBttn.setTitle("Post with Alomafire", for: .normal)
        urlBttn.setTitle("Post with URLSession", for: .normal)
        alomafireBttn.tintColor = .white
        urlBttn.tintColor = .white
        alomafireBttn.setGradient(button: alomafireBttn)
        urlBttn.setGradient(button: urlBttn)
        bodyTF.backgroundColor = .lightGray
        navigationItem.title = "New Post"
    }
    
    @IBAction func postURLSession() {
        if let userID = user?.id,
           let title = titleTF.text,
           let text = bodyTF.text,
           let url = ApiConstants.postsPathURL
        {
            // SETUP request
            var request = URLRequest(url: url)

            // HEADER
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            // BODY
            let postBodyJson: [String: Any] = ["userId": userID,
                                               "title": title,
                                               "body": text]

            let httpBody = try? JSONSerialization.data(withJSONObject: postBodyJson, options: [])
            request.httpBody = httpBody

            // Create dataTask and post new request

            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                print(response ?? "")
                if let data {
                    print(data)
                    let json = JSON(data)
                    print(json)
                    let userID = json["userId"].int
                    let title = json["title"].string
                    let body = json["body"].string

                    DispatchQueue.main.async {
                        self?.navigationController?.popViewController(animated: true)
                    }
                } else if let error {
                    print(error)
                }
            }.resume()
        }
    }

    @IBAction func postAlamofire() {
        if let userID = user?.id,
           let title = titleTF.text,
           let text = bodyTF.text,
           let url = ApiConstants.postsPathURL
        {
            let parameters: Parameters = ["userId": userID,
                                          "title": title,
                                          "body": text]

            AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
                .response { response in
                    
                    debugPrint(response)
                    print(response.request)
                    print(response.response)
                    debugPrint(response.result)

                    switch response.result {
                    case .success(let data):
                        print(data)
                        print(JSON(data))
                        self.navigationController?.popViewController(animated: true)
                    case .failure(let error):
                        print(error)
                    }
                }
        }
    }
}

