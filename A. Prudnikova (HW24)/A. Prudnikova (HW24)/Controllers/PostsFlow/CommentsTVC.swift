//
//  CommentsTVC.swift
//  A. Prudnikova (HW24)
//
//  Created by Рабочая лошадка  on 27.12.22.
//

import UIKit

class CommentsTVC: UITableViewController {
    
    var user: User?
    var comments: [Comment] = []
    
    override func viewWillAppear(_ animated: Bool) {
        fetchComments()
    }

    override func viewDidLoad() {
        navigationItem.title = "Comments"
        super.viewDidLoad()
    }
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return comments.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment = comments[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = comment.email
        cell.detailTextLabel?.text = comment.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func fetchComments() {
        
        guard let userId = user?.id else { return }
        let pathUrl = "\(ApiConstants.commentsPath)?userId=\(userId)"

        guard let url = URL(string: pathUrl) else { return }

        let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            do {
                self.comments = try JSONDecoder().decode([Comment].self, from: data)
                print(self.comments)
            } catch let error {
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
}
