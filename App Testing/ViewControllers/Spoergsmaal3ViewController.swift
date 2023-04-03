//
//  Spoergsmaal3ViewController.swift
//  App Testing
//
//  Created by Betina Svendsen on 22/03/2023.
//

import UIKit

class Spoergsmaal3ViewController: UIViewController {
    
    @IBOutlet weak var Spoergsmaal3Label: UILabel!
    
    @IBOutlet weak var Spoergsmaal3SubLabel: UILabel!
    
    @IBOutlet weak var Spoergsmaal3Icon: UIImageView!
    
    @IBOutlet weak var mainStackView: UIStackView!
    
    
    var QuestionsArray = [Spoergsmaal]()
    var AnswersArray = [Svar]()
    
    var SelectedAnswersArray =  [[String? : Int?]]()

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "collectingUserAnswers3"){
                    let displayVC = segue.destination as! Spoergsmaal4ViewController
                    let SelectedAnswersArray = UserDefaults.standard.object(forKey: "SelectedAnswersArray") as? [[String? : Int?]]

                    displayVC.SelectedAnswersArray = SelectedAnswersArray!
                    print(displayVC.SelectedAnswersArray)

            }
      }
    
    
    func displayAnswerButtons(type:String){
        for i in stride(from: 0, to: AnswersArray.count, by: 1){
            let titleString = String(AnswersArray[i].svar_tekst!)
            let titleInt = Int(AnswersArray[i].id!)
            if(type == "simple"){
                let button = makeButtonWithAnswerSimple(text:titleString, id:titleInt, spoergsmaal: 3)
                mainStackView.addArrangedSubview(button)
            } else {
                //let button = makeButtonWithAnswerMulti(text:titleString, id:titleInt)
                //mainStackView.addArrangedSubview(button)
            }
        }
    }

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NetworkServiceQuestions.sharedObj.getQuestions { (Questions) in
                    self.QuestionsArray = Questions
                    self.Spoergsmaal3Label.text = String(self.QuestionsArray[2].spoergsmaal_tekst!)
            // if the max_antal_svar is greater than 1, display the message
            if(Int(self.QuestionsArray[2].max_antal_svar!) > 1){
                self.Spoergsmaal3SubLabel.text = "Du kan vælge op til " + String(self.QuestionsArray[0].max_antal_svar!) + " svar"
            } else {
                self.Spoergsmaal3SubLabel.isHidden = true
            }
                    
                }
        
        NetworkServiceAnswers3.sharedObj.getAnswers { (Answers) in
            self.AnswersArray = Answers
            if(Int(self.QuestionsArray[2].max_antal_svar!) > 1){
                self.displayAnswerButtons(type:"multi")
            } else {
                self.displayAnswerButtons(type:"simple")
            }
        }
        
        mainStackView.spacing = 1.0
        
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }

}
