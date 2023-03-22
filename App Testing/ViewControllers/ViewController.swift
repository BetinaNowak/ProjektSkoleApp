//
//  ViewController.swift
//  App Testing
//
//  Created by Betina Svendsen on 17/03/2023.
//


import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    
    //var selectedInfo: TestInfo!
    
    @IBOutlet weak var infoTable: UITableView!

    var InfoArray = [TestInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.infoTable.delegate = self
        self.infoTable.dataSource = self
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Info"
        
        NetworkService.sharedObj.getInfo { (TestInfo) in
            self.InfoArray = TestInfo
            self.infoTable.reloadData()
        }
    }
    
    
    
    // Number of rows = number of dataset
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return InfoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        print("cell")
        //print(InfoArray)
            
            
        cell.textLabel?.text = String(InfoArray[indexPath.row].age!)
            
        //print(cell)
        return cell
        
    }
    
    
    // Selected?
    /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedInfo = InfoArray[indexPath.row]
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    // Delete?
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            self.InfoArray.remove(at: indexPath.row)
            self.infoTable.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // Go to detail view (not made)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? InfoVC
        {
            destinationVC.info = selectedInfo
        }
    }*/
    
    


}



