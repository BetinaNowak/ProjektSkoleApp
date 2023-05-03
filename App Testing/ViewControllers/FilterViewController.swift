//
//  FilterViewController.swift
//  App Testing
//
//  Created by Betina Svendsen on 19/04/2023.
//

import UIKit

class FilterSection {
    var headerLabel: String?
    var filterLabel: [String]?
    
    init(headerLabel: String, filterLabel: [String]) {
        self.headerLabel = headerLabel
        self.filterLabel = filterLabel
    }
}



class FilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var filterSection = [FilterSection]()

    var items = [String]()
    
    @IBOutlet weak var filterTableView: UITableView!
    @IBOutlet weak var filterBtn: UIBarButtonItem!
    
    
    @IBAction func fitlerBtnPressed(_ sender: Any) {
        /*items.removeAll()
        
        if let selectedRows = filterTableView.indexPathsForVisibleRows {
            
            for iPath in selectedRows {
                items.append(filterSection[iPath.row])
            }
        }*/
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        filterSection.append(FilterSection.init(headerLabel: "Kategori", filterLabel: ["Håndværk", "Konditori"]))
        
        filterSection.append(FilterSection.init(headerLabel: "By", filterLabel: ["Lyngby", "Gladsaxe"]))
        
        
        self.filterTableView.allowsMultipleSelection = true;
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterSection[section].filterLabel!.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = filterSection[indexPath.section].filterLabel?[indexPath.row]
        
        cell.selectionStyle = .none
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        filterTableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        filterTableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return filterSection.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return filterSection[section].headerLabel
    }

}
