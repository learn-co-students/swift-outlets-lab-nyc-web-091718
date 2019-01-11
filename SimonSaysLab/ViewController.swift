//
//  ViewController.swift
//  SimonSaysLab
//
//  Created by James Campagno on 5/31/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayColorView: UIView!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var winLabel: UILabel!
    var simonSaysGame = SimonSays()
    var buttonsClicked = 0
    
    @IBAction func tapRed(_ sender: Any) {
        simonSaysGame.guessRed()
        checkIfGameWon()
    }
    @IBAction func tapGreen(_ sender: Any) {
        simonSaysGame.guessGreen()
        checkIfGameWon()
    }
    @IBAction func tapYellow(_ sender: Any) {
        simonSaysGame.guessYellow()
        checkIfGameWon()
    }
    @IBAction func tapBlue(_ sender: Any) {
        simonSaysGame.guessBlue()
        checkIfGameWon()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func checkIfGameWon(){
        buttonsClicked = buttonsClicked + 1
        if simonSaysGame.wonGame() && buttonsClicked==5 {
            winLabel.text =  "You win"
        }else if !simonSaysGame.wonGame() && buttonsClicked==5{
            winLabel.text = "You Lose!"
        }else{
            winLabel.text="Playing..."
        }
    }
}

// MARK: - SimonSays Game Methods
extension ViewController {
    
    @IBAction func startGameTapped(_ sender: UIButton) {
        UIView.transition(with: startGameButton, duration: 0.9, options: .transitionFlipFromBottom , animations: {
            self.startGameButton.isHidden = true
            }, completion: nil)
        
        displayTheColors()
    }
    
    fileprivate func displayTheColors() {
        self.view.isUserInteractionEnabled = false
        UIView.transition(with: displayColorView, duration: 1.5, options: .transitionCurlUp, animations: {
            self.displayColorView.backgroundColor = self.simonSaysGame.nextColor()?.colorToDisplay
            self.displayColorView.alpha = 0.0
            self.displayColorView.alpha = 1.0
            }, completion: { _ in
                if !self.simonSaysGame.sequenceFinished() {
                    self.displayTheColors()
                } else {
                    self.view.isUserInteractionEnabled = true
                    print("Pattern to match: \(self.simonSaysGame.patternToMatch)")
                }
        })
    }
}
