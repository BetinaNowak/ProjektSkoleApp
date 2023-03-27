//
//  Spoergsmaal4ViewController.swift
//  App Testing
//
//  Created by Betina Svendsen on 22/03/2023.
//

import UIKit

class Spoergsmaal4ViewController: UIViewController {

    @IBOutlet weak var Spoergsmaal4Label: UILabel!
    
    @IBOutlet weak var Spoergsmaal4SubLabel: UILabel!
    
    @IBOutlet weak var Spoergsmaal4Icon: UIImageView!
    
    @IBOutlet weak var mainStackView: UIStackView!
    
    
    var QuestionsArray = [Spoergsmaal]()
    var AnswersArray = [Svar]()
    
    var SelectedAnswersArray =  [[String? : Int?]]()

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "collectingUserAnswers4"){
            let SelectedAnswersArray = UserDefaults.standard.object(forKey: "SelectedAnswersArray") as? [[String? : Int?]]
                   /* let displayVC = segue.destination as! XXXXXX
                    let SelectedAnswersArray = UserDefaults.standard.object(forKey: "SelectedAnswersArray") as? [[String? : Int?]]

                    displayVC.SelectedAnswersArray = SelectedAnswersArray!
                    print(displayVC.SelectedAnswersArray)
                    */
                // Send the responses to the DB
            ApiService.callPost(url: URL(string: "http://test-postnord.dk.linux21.curanetserver.dk/api-post-svar.php")!, params: SelectedAnswersArray!)
            }
      }
    
    //MARK: View Making methods
    func makeButtonWithAnswer(text:String, id:Int) -> UIButton {
        let answerButton = UIButton(type: UIButton.ButtonType.system)
        answerButton.frame = CGRect(x: 30, y: 30, width: 50, height: 10)
        answerButton.backgroundColor = UIColor.white
        answerButton.configuration = .plain()
        answerButton.layer.cornerRadius = 20
        answerButton.layer.borderWidth = 1
        answerButton.layer.borderColor = UIColor.white.cgColor
        answerButton.configuration!.contentInsets = NSDirectionalEdgeInsets(top: 12.0, leading: 8.0, bottom: 12.0, trailing: 8.0)
        
        // Shadow
        answerButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.50).cgColor
        answerButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        answerButton.layer.shadowOpacity = 0.3
        answerButton.layer.shadowRadius = 4.0
        answerButton.layer.masksToBounds = false

        
        //State dependent properties title and title color
        answerButton.setTitle(text, for: .normal)
        answerButton.setTitleColor(.black, for: .normal)
        answerButton.addTarget(self, action: #selector(pressedAction(_:)), for: .touchUpInside)
        answerButton.tag = id

        return answerButton
    }
    
    @objc func pressedAction(_ sender: UIButton) {
       // do your stuff here
        //print("you clicked on button \(sender.tag)")
        var tempArray = [String:Int]()
        tempArray = [
            String("bruger_id"): 1,
            String("spoergsmaal_id"): 4,
            String("svar_id"): sender.tag
        ]
        
        SelectedAnswersArray.append(tempArray)
        UserDefaults.standard.removeObject(forKey: "SelectedAnswersArray")
        UserDefaults.standard.set(SelectedAnswersArray, forKey: "SelectedAnswersArray")
        print(SelectedAnswersArray)

    }
    
    
    func displayAnswerButtons(count:Int){
        for i in stride(from: 0, to: AnswersArray.count, by: 1){
            let titleString = String(AnswersArray[i].svar_tekst!)
            let titleInt = Int(AnswersArray[i].id!)
            let button = makeButtonWithAnswer(text:titleString, id:titleInt)
            mainStackView.addArrangedSubview(button)
        }
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NetworkServiceQuestions.sharedObj.getQuestions { (Questions) in
                    self.QuestionsArray = Questions
                    self.Spoergsmaal4Label.text = String(self.QuestionsArray[3].spoergsmaal_tekst!)
            // if the max_antal_svar is greater than 1, display the message
            if(Int(self.QuestionsArray[3].max_antal_svar!) > 1){
                self.Spoergsmaal4SubLabel.text = "Du kan vælge op til " + String(self.QuestionsArray[0].max_antal_svar!) + " svar"
            } else {
                self.Spoergsmaal4SubLabel.isHidden = true
                //self.SpoergsmaalSubLabelIcon.isHidden = true
            }
            //self.displayAnswerButtons(count: 1)
                    
                }
        
        NetworkServiceAnswers3.sharedObj.getAnswers { (Answers) in
            self.AnswersArray = Answers
            self.displayAnswerButtons(count: 1)
        }
        
        mainStackView.spacing = 1.0
    }

}
