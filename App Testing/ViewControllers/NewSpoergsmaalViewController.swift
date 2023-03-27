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
    
    var SelectedAnswersArray =  [[String? : Int?]]()

    
    //MARK: View Making methods
    func makeButtonWithAnswer(text:String) -> UIButton {
        let answerButton = UIButton(type: UIButton.ButtonType.system)
        answerButton.frame = CGRect(x: 80, y: 80, width: 50, height: 10)
        answerButton.backgroundColor = UIColor.white
        answerButton.configuration = .plain()
        answerButton.layer.borderWidth = 2
        answerButton.layer.cornerRadius = 5
        answerButton.layer.borderColor = UIColor.white.cgColor
        
        // Shadow
        answerButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.50).cgColor
        answerButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        answerButton.layer.shadowOpacity = 0.3
        answerButton.layer.shadowRadius = 4.0
        answerButton.layer.masksToBounds = false
        
        //State dependent properties title and title color
        answerButton.setTitle(text, for: .normal)
        answerButton.setTitleColor(.black, for: .normal)
        return answerButton
    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "collectingUserAnswers"){
                    let displayVC = segue.destination as! Spoergsmaal2ViewController
                    let SelectedAnswersArray = UserDefaults.standard.object(forKey: "SelectedAnswersArray") as? [[String? : Int?]]

                    displayVC.SelectedAnswersArray = SelectedAnswersArray!
                    print(displayVC.SelectedAnswersArray)

            }
      }
    
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


    }
        
    }
    
  
