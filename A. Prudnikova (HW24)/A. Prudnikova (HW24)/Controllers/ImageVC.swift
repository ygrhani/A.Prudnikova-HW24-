//
//  ImageVC.swift
//  A. Prudnikova (HW24)
//
//  Created by Ann Prudnikova on 26.12.22.
//

import UIKit
import SnapKit

class ImageVC: UIViewController {
    
    
    @IBOutlet weak var activityInd: UIActivityIndicatorView!
    @IBOutlet weak var image: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityInd.startAnimating()
        activityInd.hidesWhenStopped = true
        activityInd.style = .large
        activityInd.color = .darkGray
        image.image = UIImage(systemName: "photo.artframe")
        
        fetchImage()
        
    }
    
    private let imageURLStr = "https://i.pinimg.com/750x/fe/cc/97/fecc97ee38d4a3f13235e1f3829a2611.jpg"
    private func fetchImage() {
        guard let url = URL(string: imageURLStr) else {return}
        
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, reply, error in
            DispatchQueue.main.async {
                self.activityInd.stopAnimating()
                
                if let error {
                    self.image.image = UIImage(systemName: "clear")
                    let errorAlert = UIAlertController(title: "Something's wrong", message: error.localizedDescription, preferredStyle: .alert)
                    let okBtn = UIAlertAction(title: "OK", style: .cancel)
                    self.present(errorAlert, animated: true)
                    errorAlert.addAction(okBtn)
                    return
                }
                
                if let reply {
                    print(reply)
                }
                
                print("\n", data ?? "", "\n")
                
                if let data,
                   let image = UIImage(data: data)
                {
                    self.image.image = image
                } else {
                    self.image.image = UIImage(systemName: "photo.artframe")
                }
                
            }
        }//.resume()
        task.resume()
    }
}
