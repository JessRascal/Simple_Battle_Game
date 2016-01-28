//
//  ViewController.swift
//  Lecture52 - OOP Exercise
//
//  Created by Michael Jessey on 19/01/2016.
//  Copyright © 2016 JustOneJess. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var player1HpLabel: UILabel!
    @IBOutlet weak var player2HpLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var player1NameLabel: UILabel!
    @IBOutlet weak var player2NameLabel: UILabel!
    @IBOutlet weak var player1AttackButton: UIButton!
    @IBOutlet weak var player2AttackButton: UIButton!
    @IBOutlet weak var player1Image: UIImageView!
    @IBOutlet weak var player2Image: UIImageView!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var player1StackView: UIStackView!
    @IBOutlet weak var player2StackView: UIStackView!
    @IBOutlet weak var player1NameField: UITextField!
    @IBOutlet weak var player2NameField: UITextField!
    @IBOutlet weak var player1SegmentedControl: UISegmentedControl!
    @IBOutlet weak var player2SegmentedControl: UISegmentedControl!
    
    
    var gameInstance: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialise the game and the set up screen.
        gameInstance = Game(vc: self)
        gameInstance.setUpGame()
    }

    @IBAction func player1Attack(sender: AnyObject) {
        // Temporarily disable the other player's 'Attack' button. (Commented out in favour of a turn based approach.)
        //gameInstance.tempDisableAttack(player2AttackButton)
        
        // Disable player 1's 'Attack' button and enable player 2's.
        player1AttackButton.enabled = false
        player2AttackButton.enabled = true
        // Perform the attack.
        gameInstance.performAttack(gameInstance.player1, playerBeingAttackedIn: gameInstance.player2)
    }

    @IBAction func player2Attack(sender: AnyObject) {
        // Temporarily disable the other player's 'Attack' button. (Commented out in favour of a turn based approach.)
        //gameInstance.tempDisableAttack(player1AttackButton)
        
        // Disable player 2's 'Attack' button and enable player 1's.
        player1AttackButton.enabled = true
        player2AttackButton.enabled = false
        // Perform the attack.
        gameInstance.performAttack(gameInstance.player2, playerBeingAttackedIn: gameInstance.player1)
    }
    
    @IBAction func restartButtonTapped(sender: AnyObject) {
        // Restart the game when the 'Restart' button is pressed.
        gameInstance.restartGame()
    }
    
    @IBAction func player1AcceptButtonTapped(sender: AnyObject) {
        // Create player 1.
        gameInstance.createPlayer(1, hpIn: 100, attackPowerIn: 20, nameIn: player1NameField.text!, imageChoiceIn: player1SegmentedControl.selectedSegmentIndex)
    }
    
    @IBAction func player2AcceptButtonTapped(sender: AnyObject) {
        // Create player 2.
        gameInstance.createPlayer(2, hpIn: 100, attackPowerIn: 20, nameIn: player2NameField.text!, imageChoiceIn: player2SegmentedControl.selectedSegmentIndex)
    }
}

