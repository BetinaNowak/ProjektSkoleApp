//
//  AllCompaniesViewController.swift
//  App Testing
//
//  Created by mediastyle on 06/06/2023.
//

import Foundation
import UIKit


class AllCompaniesViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchControllerDelegate  {
    
    var allCompanies = [Virksomhed]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCompanies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cellViewCompanies"
          let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AllCompaniesTableViewCell

          // Fetches the appropriate meal for the data source layout.
          let singleCompany = allCompanies[indexPath.row]

          cell.navnLabel.text = singleCompany.navn
          cell.kortBeskrivelseLabel.text = singleCompany.kort_beskrivelse
          cell.adresseLabel.text = singleCompany.adresse
          cell.typeLabel.text = singleCompany.type
        
        let imgUrl = "http://test-postnord.dk" + (singleCompany.billede!)
        cell.companyImageView.downloadedimg(from: imgUrl, contentMode: .scaleAspectFill)
       // cell.saveBtn.isSelected = true


          return cell
    }
    
    // Segue for showing single post TODO
    /*override func prepare(for seque: UIStoryboardSegue, sender: Any?) {
        if let destination = seque.destination as? SingleCompanyViewController {
            destination.post = allCompanies[AllCompaniesTableView.indexPathForSelectedRow!.row]
        }
    }*/

    
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
   // @IBOutlet weak var whiteBackground: UIImageView!
    
    
    @IBOutlet weak var AllCompaniesTableView: UITableView!
    
    //var savedInternship: Opslag?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        AllCompaniesTableView.delegate = self
        AllCompaniesTableView.dataSource = self
        
       
        setMenuBtn(menuBtn)
        
        
        // Style custom background
      /*  whiteBackground.layer.shadowRadius = 6
        whiteBackground.layer.shadowOpacity = 1
        whiteBackground.layer.shadowOffset = CGSize(width: 2, height: 2)
        whiteBackground.layer.shadowColor = UIColor.gray.cgColor */
        
        
        // Fetch internship posts
        NetworkServiceCompanies.sharedObj.getCompanies { (Virksomhed) in
            self.allCompanies = Virksomhed
            self.AllCompaniesTableView.reloadData()
        }
        //self.tableView.register(UITableViewCell.self, forCellWithReuseIdentifier: "SavedTableViewCell")
    }
    
    
    

    // Function for menu action
    func setMenuBtn(_ menuBar: UIBarButtonItem) {
        menuBar.target = revealViewController()
        menuBar.action = #selector(SWRevealViewController.revealToggle(_:))
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }

}

//protocol ItemCellDelegate {
  //  func itemCell(didTapButton button: UIButton)
//}

