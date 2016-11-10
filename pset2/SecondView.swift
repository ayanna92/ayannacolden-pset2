//
//  SecondView.swift
//  pset2
//
//  Created by Ayanna Colden on 07/11/2016.
//  Copyright © 2016 Ayanna Colden. All rights reserved.
//

import UIKit

class SecondView: UIViewController {

    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var wordCount: UILabel!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var nounLabel: UILabel!
    @IBOutlet weak var resultsButton: UIButton!

    var newStory = Story(stream: "")
    var count = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Uses array to make random selection from textfiles.
        let array = ["madlib0_simple", "madlib1_tarzan", "madlib2_university", "madlib3_clothes", "madlib4_dance"]
        let randomIndex = Int(arc4random_uniform(UInt32(array.count)))
        
        let s = try! String(contentsOfFile: Bundle.main.path(forResource: "\(array[randomIndex])", ofType: "txt")!)
        
        newStory = Story(stream: s)
        
        // Set placeholder in textfield.
        let placeholder = newStory.getNextPlaceholder()
        inputField.placeholder = "\(placeholder)"
        nounLabel.text = "Please type in \(placeholder)"
        
        // Display the word count.
        count = newStory.getPlaceholderRemainingCount()
        wordCount.text = "\(count) Word(s) left"
        
        // Hide results button when view is loaded.
        resultsButton.isHidden = true

    }
    

    
    // When you press the OK! button:
    @IBAction func nextWord(_ sender: UIButton) {
        count -= 1
        wordCount.text = "\(count) Word(s) left"
        
        // Save users input for later use.
        let words = inputField.text
        
        if (words != "") {
            newStory.fillInPlaceholder(word: words!)
        }
        
        let placeholder = newStory.getNextPlaceholder()
        inputField.placeholder = "\(placeholder)"
        nounLabel.text = "Please type in \(placeholder)"
        
        // If words left is zero, disable use of OK button and show results button.
        if (count == 0){
            okButton.isHidden = true
            resultsButton.isHidden = false
            nounLabel.text = "Go read your story!"
        }
        else {
            resultsButton.isHidden = true
        }
        
        inputField.text?.removeAll()
    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Send filled in story to ThirdView.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let wordSubmitted = segue.destination as! ThirdView
        wordSubmitted.text = newStory
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
