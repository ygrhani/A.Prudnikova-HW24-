import UIKit

enum UserActions: String, CaseIterable /* позволяет из перечисления сделать массив */ {
    case downloadImage = "Download Image"
    case users = "Users"
}
class InformSectionsCVC: UICollectionViewController {
    
    private let reuseIdentifier = "Cell"
    private let userActions = UserActions.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return userActions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? InformSectionsCell else { return UICollectionViewCell() }
        
        cell.informActionLbl.text = userActions[indexPath.row].rawValue
        cell.backgroundColor = .black
        cell.informActionLbl.textColor = .white
        cell.informActionLbl.font = .boldSystemFont(ofSize: 20)
        cell.layer.cornerRadius = 27
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.row]
        switch userAction {
        case .downloadImage:
            guard let imageVC = storyboard?.instantiateViewController(withIdentifier: "ImageVC") as? ImageVC else {return}
            navigationController?.pushViewController(imageVC, animated: true)
        case .users:
            guard let usersVC = storyboard?.instantiateViewController(withIdentifier: "UsersTVC") as? UsersTVC else {return}
            navigationController?.pushViewController(usersVC, animated: true)
        }
    }

}

extension InformSectionsCVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (UIScreen.main.bounds.width - 20), height: 80)
    }
}
