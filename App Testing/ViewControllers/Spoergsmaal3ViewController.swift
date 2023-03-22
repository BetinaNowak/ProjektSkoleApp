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
    
    
    
    //MARK: View Making methods
    func makeButtonWithAnswer(text:String) -> UIButton {
        let answerButton = UIButton(type: UIButton.ButtonType.system)
        answerButton.frame = CGRect(x: 30, y: 30, width: 50, height: 10)
        //answerButton.backgroundColor = UIColor(white: 0.25, alpha: 1.0)
        
        //State dependent properties title and title color
        answerButton.setTitle(text, for: .normal)
        answerButton.setTitleColor(.black, for: .normal)
        return answerButton
    }
    
    
    
    func displayAnswerButtons(count:Int){
        for i in stride(from: 0, to: AnswersArray.count, by: 1){
            let titleString = String(AnswersArray[i].svar_tekst!)
            //let titleString = String(format:"Hello Button %i",i)
            let button = makeButtonWithAnswer(text:titleString)
            mainStackView.addArrangedSubview(button)
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
