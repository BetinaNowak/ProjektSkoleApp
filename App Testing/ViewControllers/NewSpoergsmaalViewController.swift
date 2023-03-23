//
//  NewSpoergsmaalViewController.swift
//  App Testing
//
//  Created by mediastyle on 21/03/2023.
//


import UIKit

class NewSpoergsmaalViewController: UIViewController{
   
    
    //var selectedInfo: TestInfo!
    @IBOutlet weak var SpoergsmaalLabel: UILabel!
    @IBOutlet weak var SpoergsmaalSubLabel: UILabel!
    
    @IBOutlet weak var SpoergsmaalSubLabelIcon: UIImageView!
    
    @IBOutlet weak var stackView: UIStackView!
    var QuestionsArray = [Spoergsmaal]()
    var AnswersArray = [Svar]()
    var objectsArray = [[String : Any]]()
    let cellIdentifier = "cell"
    
    //MARK: View Making methods
    /*func makeButtonWithAnswer(text:String) -> UIButton {
        let answerButton = UIButton(type: UIButton.ButtonType.system)
        answerButton.frame = CGRect(x: 80, y: 80, width: 50, height: 10)
        answerButton.layer.borderWidth = 2
        answerButton.layer.cornerRadius = 5
        answerButton.layer.borderColor = UIColor.black.cgColor
        
        //answerButton.backgroundColor = UIColor(white: 0.25, alpha: 1.0)
        
        //State dependent properties title and title color
        answerButton.setTitle(text, for: .normal)
        answerButton.setTitleColor(.black, for: .normal)
        return answerButton
    }*/
    
    func displayAnswerButtons(){
        for i in stride(from: 0, to: AnswersArray.count, by: 1){
            let titleInt = Int(AnswersArray[i].id!)
            let titleString = String(AnswersArray[i].svar_tekst!)
            //let button = makeButtonWithAnswer(text:titleString)
            var tempArray = [String:Any]()
            tempArray = [
                String("id"): titleInt,
                String("title") : titleString
            ]
            
            objectsArray.append(tempArray)
        }
            
            let items: [[[String : Any]]] = [
                objectsArray
            ]
            let controller = CollectionViewController(items: items)
            controller.view.translatesAutoresizingMaskIntoConstraints = false
            stackView?.addArrangedSubview(controller.view)
            addChild(controller)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkServiceQuestions.sharedObj.getQuestions { (Questions) in
                    self.QuestionsArray = Questions
                    self.SpoergsmaalLabel.text = String(self.QuestionsArray[0].spoergsmaal_tekst!)
                    // if the max_antal_svar is greater than 1, display the message
                    if(Int(self.QuestionsArray[0].max_antal_svar!) > 1){
                        self.SpoergsmaalSubLabel.text = "Du kan vælge op til " + String(self.QuestionsArray[0].max_antal_svar!) + " svar"
                    } else {
                        self.SpoergsmaalSubLabel.isHidden = true
                        self.SpoergsmaalSubLabelIcon.isHidden = true
                    }
                    //self.displayAnswerButtons(count: 1)
                }
        
        NetworkServiceAnswers.sharedObj.getAnswers { (Answers) in
            self.AnswersArray = Answers
            self.displayAnswerButtons()
        }
        
        ApiService.callPost(url: URL(string: "http://test-postnord.dk.linux21.curanetserver.dk/api-post-svar.php")!, params: ["key":"value"])


    }
        
    }
    
  
