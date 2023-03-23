//
//  CollectionViewController.swift
//  FixedSpacedCollectionViewLayout
//
//  Created by Toomas Vahter on 11.08.2021.
//

import UIKit

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
    private let items: [[String]]
    
    init(items: [[String]]) {
        self.items = items
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
        cell.button.setTitle(items[indexPath.section][indexPath.item], for: .normal)
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
        let button:  UIButton = {
            let button =  UIButton(type: UIButton.ButtonType.system)
            button.backgroundColor = UIColor.white
            button.configuration = .plain()
            button.layer.cornerRadius = 20
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.systemGray5.cgColor
            button.configuration!.contentInsets = NSDirectionalEdgeInsets(top: 10.0, leading: 22.0, bottom: 10.0, trailing: 22.0)
            
            //State dependent properties title and title color
            button.setTitleColor(.black, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        
    }
}
