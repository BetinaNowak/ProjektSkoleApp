//
//  AnsoegningViewController.swift
//  App Testing
//
//  Created by mediastyle on 29/03/2023.
//

import UIKit

class AnsoegningViewController: UIViewController {
    
    @IBOutlet weak var ansoegerNavn: UITextField!
    @IBOutlet weak var ansoegerSkole: UITextField!
    @IBOutlet weak var ansoegerKlassetrin: UITextField!
    @IBOutlet weak var beskrivelse: UITextView!
    var postId: Int?
    var postTitel: String?
    var postEmail: String?
    var postVirksomhedsnavn: String?
    
    @IBAction func sendAnsoegning(_ sender: Any) {
        var ansoegningArray = [String:Any]()
        ansoegningArray = [
            String("ansoeger_id"): Int(1),
            String("ansoeger_navn"): String(ansoegerNavn.text!),
            String("ansoeger_skole"): String(ansoegerSkole.text!),
            String("ansoeger_klassetrin"): String(ansoegerKlassetrin.text!),
            String("ansoeger_beskrivelse"): String(beskrivelse.text!),
            String("praktik_id"): postId!,
            String("praktik_titel"): String(postTitel!),
            String("praktik_email"): String(postEmail!),
            String("praktik_virksomhedsnavn"): String(postVirksomhedsnavn!)
        ]
        //print(ansoegningArray)
        
        // Send the responses
        SendApplication.callPost(url: URL(string: "http://test-postnord.dk.linux21.curanetserver.dk/api-post-ansoegning.php")!, params: ansoegningArray)
        _ = navigationController?.popViewController(animated: true)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beskrivelse.layer.borderWidth = 1
        //print(index!)

        /*
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
         */
    }
}

