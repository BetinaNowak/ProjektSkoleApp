//
//  CollectionViewController.swift
//  FixedSpacedCollectionViewLayout
//
//  Created by Toomas Vahter on 11.08.2021.
//

import UIKit
var SelectedAnswersArrayLocal = [[String? : Int?]]()

extension UICollectionViewLayout {
    static func fixedSpacedFlowLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(50), heightDimension: .estimated(50))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .fixed(8), top: .fixed(4), trailing: .fixed(8), bottom: .fixed(4))
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
}

class CollectionViewController : UICollectionViewController {
    private let items: [[[String : Any]]]
    
    init(items: [[[String : Any]]]) {
        self.items = items
        //print(self.items)
        super.init(collectionViewLayout: UICollectionViewLayout.fixedSpacedFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private static let cellIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(LabelCell.self, forCellWithReuseIdentifier: Self.cellIdentifier)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items[section].count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.cellIdentifier, for: indexPath) as! LabelCell
        //print(items[indexPath.section][indexPath.item]["title"]!)
        let titleString = items[indexPath.section][indexPath.item]["title"]! as? String
        let titleInt = items[indexPath.section][indexPath.item]["id"]! as? Int
        cell.button.setTitle(titleString!, for: .normal)
        cell.button.tag = titleInt!
        return cell
    }
}

extension CollectionViewController {
    final class LabelCell: UICollectionViewCell {
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundView = {
                let view = UIView(frame: frame)
                //view.backgroundColor = .systemTeal
                //view.layer.cornerRadius = 8
                return view
            }()
            
            //contentView.addSubview(label)
            contentView.addSubview(button)
            /*NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
            ])*/
            NSLayoutConstraint.activate([
                button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
            ])
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        /*let label: UILabel = {
            let label = UILabel(frame: .zero)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }() */
        lazy var button:  UIButton = {
            let button =  UIButton(type: UIButton.ButtonType.system)
            button.backgroundColor = UIColor.white
            button.configuration = .plain()
            button.frame = CGRect(x: 30, y: 30, width: 50, height: 10)
            button.layer.cornerRadius = 20
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.white.cgColor
            button.configuration!.contentInsets = NSDirectionalEdgeInsets(top: 10.0, leading: 22.0, bottom: 10.0, trailing: 22.0)
            
            // Shadow
            button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.50).cgColor
            button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            button.layer.shadowOpacity = 0.3
            button.layer.shadowRadius = 4.0
            button.layer.masksToBounds = false
            
            //State dependent properties title and title color
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font =  UIFont(name: "Montserrat Bold", size: 20)

            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(pressedAction(_:)), for: .touchUpInside)
            return button
            
            
        }()
        

        @objc func pressedAction(_ sender: UIButton) {
           // do your stuff here
            var tempArray = [String:Int]()
            tempArray = [
                String("bruger_id"): 1,
                String("spoergsmaal_id"): 1,
                String("svar_id"): sender.tag
            ]
            if(SelectedAnswersArrayLocal.contains(tempArray)){
                sender.backgroundColor = UIColor.white
                sender.layer.borderColor = UIColor.white.cgColor
                SelectedAnswersArrayLocal.removeAll(where: { $0 == tempArray })
                UserDefaults.standard.removeObject(forKey: "SelectedAnswersArray")
                UserDefaults.standard.set(SelectedAnswersArrayLocal, forKey: "SelectedAnswersArray")
            } else if (SelectedAnswersArrayLocal.count == 3){
                sender.shake()
            } else {
                sender.backgroundColor = #colorLiteral(red: 0.9978314042, green: 0.7260365486, blue: 0.009917389601, alpha: 1)
                sender.layer.borderColor = #colorLiteral(red: 0.9978314042, green: 0.7260365486, blue: 0.009917389601, alpha: 1)
                
                SelectedAnswersArrayLocal.append(tempArray)
                UserDefaults.standard.removeObject(forKey: "SelectedAnswersArray")
                UserDefaults.standard.set(SelectedAnswersArrayLocal, forKey: "SelectedAnswersArray")
            }
        }
        
    }
    
}

extension UIView {

    // Using SpringWithDamping
    func shake(duration: TimeInterval = 0.5, xValue: CGFloat = 12, yValue: CGFloat = 0) {
        self.transform = CGAffineTransform(translationX: xValue, y: yValue)
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)

    }

}
