//
//  DisplayAnswersViewController.swift
//  App Testing
//
//  Created by mediastyle on 31/03/2023.
//

import UIKit

var ButtonsArray = [PassableUIButton]()
var SelectedAnswersArray = UserDefaults.standard.object(forKey: "SelectedAnswersArray") as? [[String? : Int?]]

class PassableUIButton: UIButton{
    var spoergsmaal: Int
    var svar: Int
    override init(frame: CGRect) {
        self.spoergsmaal = 0
        self.svar = 0
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        self.spoergsmaal = 0
        self.svar = 0
        super.init(coder: aDecoder)
    }
}

extension UIViewController {
    //MARK: View Making methods
    func makeButtonWithAnswerSimple(text:String, id:Int, spoergsmaal:Int) -> PassableUIButton {
            let answerButton = PassableUIButton(type: UIButton.ButtonType.system)
            
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
            answerButton.addTarget(self, action: #selector(pressedActionSimple(_:)), for: .touchUpInside)
            answerButton.tag = id
            answerButton.spoergsmaal = spoergsmaal
            ButtonsArray.append(answerButton)
            return answerButton
        }
    
    @objc func pressedActionSimple(_ sender: PassableUIButton) {
       // do your stuff here
        styleButtonsSimple(tag: sender.tag, spoergsmaal: sender.spoergsmaal)
        print(SelectedAnswersArray!)
    }
    
    func styleButtonsSimple(tag:Int, spoergsmaal:Int){
        let tag = tag
        let spoergsmaal = spoergsmaal
        for button in ButtonsArray {
            if(button.tag != tag && button.spoergsmaal == spoergsmaal) {
                button.backgroundColor = UIColor.white
                button.layer.borderColor = UIColor.white.cgColor
                var tempArray = [String:Int]()
                tempArray = [
                    String("bruger_id"): 1,
                    String("spoergsmaal_id"): button.spoergsmaal,
                    String("svar_id"): button.tag
                ]
                if(SelectedAnswersArray!.contains(tempArray)) {
                    SelectedAnswersArray!.removeAll(where: { $0 == tempArray })
                    UserDefaults.standard.removeObject(forKey: "SelectedAnswersArray")
                    UserDefaults.standard.set(SelectedAnswersArray, forKey: "SelectedAnswersArray")
                }
                
                view.layoutIfNeeded()
            } else if(button.spoergsmaal == spoergsmaal){
                button.backgroundColor = #colorLiteral(red: 0.9978314042, green: 0.7260365486, blue: 0.009917389601, alpha: 1)
                button.layer.borderColor = #colorLiteral(red: 0.9978314042, green: 0.7260365486, blue: 0.009917389601, alpha: 1)
                var tempArray = [String:Int]()
                tempArray = [
                    String("bruger_id"): 1,
                    String("spoergsmaal_id"): spoergsmaal,
                    String("svar_id"): tag
                ]
                if(!SelectedAnswersArray!.contains(tempArray)) {
                    SelectedAnswersArray!.append(tempArray)
                    UserDefaults.standard.removeObject(forKey: "SelectedAnswersArray")
                    UserDefaults.standard.set(SelectedAnswersArray, forKey: "SelectedAnswersArray")
                }
                view.layoutIfNeeded()
            }
        }
    }

    
    
}
