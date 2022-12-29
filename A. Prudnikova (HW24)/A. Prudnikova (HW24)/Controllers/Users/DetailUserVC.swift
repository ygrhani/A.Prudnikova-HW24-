//
//  DetailUserVC.swift
//  A. Prudnikova (HW24)
//
//  Created by Ann Prudnikova on 26.12.22.
//

import UIKit

class DetailUserVC: UIViewController {
    
    var user: User?
    
    @IBOutlet weak var stackName: UIStackView!
    @IBOutlet weak var stackInf: UIStackView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var website: UILabel!
    @IBOutlet weak var adress: UILabel!
    
    
    lazy var postsAction: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Posts", for: .normal)
        button.backgroundColor = .black
        button.tintColor = .white
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(goToThePosts), for: .touchUpInside)
        return button
    } ()

    lazy var albumsActoin: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Albums", for: .normal)
        button.backgroundColor = .black
        button.tintColor = .white
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(goToTheAlbums), for: .touchUpInside)
        return button
    } ()

    lazy var todoAction: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .black
        button.tintColor = .white
        button.layer.cornerRadius = 25
        button.setTitle("To do", for: .normal)
        button.addTarget(self, action: #selector(goToTheToDo), for: .touchUpInside)
        return button
    } ()
    
    lazy var adressAction: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Go to the Adress", for: .normal)
        button.backgroundColor = .black
        button.tintColor = .white
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(goToTheAdress), for: .touchUpInside)
        return button
    } ()
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupUI()
        view.addSubview(adressAction)
        view.addSubview(postsAction)
        view.addSubview(albumsActoin)
        view.addSubview(todoAction)
        updateViewConstraints()
    }
    
    override func updateViewConstraints() {
        
        adressAction.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.trailing.leading.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        postsAction.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(adressAction).inset(60)
            make.trailing.leading.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        albumsActoin.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(postsAction).inset(60)
            make.trailing.leading.equalToSuperview().inset(16)
            make.height.equalTo(50)
            make.bottom.equalTo(todoAction).inset(60)
        }
        
        todoAction.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.trailing.leading.equalToSuperview().inset(16)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(100)
        }
        
        
        super.updateViewConstraints()
    }
    
    private func setupUI() {
        name.text = user?.name
        username.text = user?.username
        email.text = user?.email
        phone.text = user?.phone
        website.text = user?.website
        adress.text =  user?.address?.street
    }
    
    @objc func goToThePosts() {
        let storyboard = UIStoryboard(name: "PostFlow", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "PostsTVC") as? PostsTVC else {return}
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func goToTheAlbums () {
//        let storyboard = UIStoryboard(name: "AlbumsAndFotos", bundle: nil)
//       guard let vc = storyboard.instantiateViewController(withIdentifier: "AlbumsTVC") as? AlbumsTVC else {return}
//                vc.user = user
//                navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func goToTheToDo() {
        
    }
    
    @objc func goToTheAdress() {
        let storyboard = UIStoryboard(name: "AdressFlow", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "AdressMapVC") as? AdressMapVC else {return}
        if let latitude = user?.address?.geo?.lat,
            let longitude = user?.address?.geo?.lng,
           let lat = Double(latitude),
           let long = Double(longitude) {
            vc.latitude = lat
            vc.longitude = long
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}


