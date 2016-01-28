//
//  Game.swift
//  Lecture52 - OOP Exercise
//
//  Created by Michael Jessey on 20/01/2016.
//  Copyright © 2016 JustOneJess. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class Game: NSObject {
    
    var vc: ViewController!
    var player1: Character!
    var player2: Character!
    
    // Sound Variables
    var attackSound: AVAudioPlayer?
    var deathSound: AVAudioPlayer?
    var backgroundMusic: AVAudioPlayer?
    
    init(vc: ViewController) {
        super.init()
        self.vc = vc
        declareAudio()
        backgroundMusic?.play()
    }
    
    //Set up the AVAudioPlayer.
    func setupAudioPlayerWithFile(file: String, type: String) -> AVAudioPlayer? {
        let path = NSBundle.mainBundle().pathForResource(file, ofType: type)
        let url = NSURL.fileURLWithPath(path!)
        
        var audioPlayer: AVAudioPlayer?
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: url)
        } catch {
            print("Player not available")
        }
        return audioPlayer
    }
    
    // Declare the sound effects and music.
    func declareAudio() {
        if let attackSoundIn = setupAudioPlayerWithFile("Melee_Attack_Sound", type:"wav") {
            attackSound = attackSoundIn
        }
        
        if let deathSoundIn = setupAudioPlayerWithFile("Male_Death_Sound", type: "wav") {
            deathSound = deathSoundIn
        }
        
        if let backgroundMusicIn = setupAudioPlayerWithFile("Arcade_Background_Music", type: "wav") {
            backgroundMusic = backgroundMusicIn
            backgroundMusic?.numberOfLoops = -1
        }
    }
    
    // Create a player.
    func createPlayer(playerNumber: Int, hpIn: Int, attackPowerIn: Int, nameIn: String, imageChoiceIn: Int) {
        if playerNumber == 1 {
            player1 = Character(startHp: hpIn, startAttackPower: attackPowerIn, startName: nameIn, characterChoiceIn: imageChoiceIn)
            vc.player1NameLabel.text = nameIn
            vc.player1Image.image = player1.setPlayerImage(playerNumber, imageChoiceIn: imageChoiceIn)
            hideP1SetUpElements()
            displayP2SetUpElements()
        }
        if playerNumber == 2 {
            player2 = Character(startHp: hpIn, startAttackPower: attackPowerIn, startName: nameIn, characterChoiceIn: imageChoiceIn)
            vc.player2NameLabel.text = nameIn
            vc.player2Image.image = player2.setPlayerImage(playerNumber, imageChoiceIn: imageChoiceIn)
            hideP2SetUpElements()
            startGame()
        }
    }
    
    // Set up the game.
    func setUpGame() {
        displayP1SetUpElements()
    }
    
    // Start game.
    func startGame() {
        updateHPLabels()
        displayGameElements()
        vc.messageLabel.text = "Press 'Attack' to start..."
    }
    
    // Perform an attack.
    func performAttack(attackingPlayerIn: Character, playerBeingAttackedIn: Character) {
        attackSound?.play()
        attackingPlayerIn.performAttack(attackingPlayerIn, playerBeingAttacked: playerBeingAttackedIn)
        vc.messageLabel.text = "\(attackingPlayerIn.name) attacks \(playerBeingAttackedIn.name).\n \(playerBeingAttackedIn.name) loses \(attackingPlayerIn.attackPower) HP."
        // Update the player being attacked HP label.
        updateHPLabels()
        // Reset the player's attacking power back to the original.
        attackingPlayerIn.resetAttackPower()
        // Check if the player being attacked is still alive (if not then the game ends).
        if !playerBeingAttackedIn.isAlive() {
            gameEnded(attackingPlayerIn)
        }
    }
    
    // Temporarily stop the other playing being able to attack (when they've been attacked).
    func tempDisableAttack(attackButtonIn: UIButton) {
        attackButtonIn.enabled = false
        NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "enableAttackButton:", userInfo: attackButtonIn, repeats: false)
    }
    
    // Enable the 'Attack' button once timer finished.
    func enableAttackButton(timer: NSTimer) {
        let buttonToEnable = timer.userInfo as! UIButton
        buttonToEnable.enabled = true
    }
    
    // Change the UI elements when the game ends.
    func gameEnded(winningPlayer: Character) {
        deathSound?.play()
        vc.messageLabel.text = "\(winningPlayer.name) has won."
        hideGameElements()
        displayResultElements()
    }
    
    // Update the players' HP labels and set them to 0 if their HP levels are below that.
    func updateHPLabels() {
        if player1.hp < 0 {
            vc.player1HpLabel.text = "0 HP"
        } else {
            vc.player1HpLabel.text = String(player1.hp) + " HP"
        }
        
        if player2.hp < 0 {
            vc.player2HpLabel.text = "0 HP"
        } else {
            vc.player2HpLabel.text = String(player2.hp) + " HP"
        }
    }
    
    // Restart the game.
    func restartGame() {
        hideResultElements()
        setUpGame()
    }
    
    // Hide and display relevant UI elements for the different screens.
    // Hide player 1's set up UI elements.
    func hideP1SetUpElements() {
        vc.player1StackView.hidden = true
    }
    
    // Display player 1's set up UI elements.
    func displayP1SetUpElements() {
        vc.player1StackView.hidden = false
        // Change the message panel label.
        vc.messageLabel.text = "Enter player 1's details."
    }
    
    // Hide player 2's set up UI elements.
    func hideP2SetUpElements() {
        vc.player2StackView.hidden = true
    }
    
    // Display player 2's set up UI elements.
    func displayP2SetUpElements() {
        vc.player2StackView.hidden = false
        // Change the message panel label.
        vc.messageLabel.text = "Enter player 2's details."
    }
    
    // Hide game elements.
    func hideGameElements() {
        vc.player1AttackButton.hidden = true
        vc.player2AttackButton.hidden = true
        vc.player1Image.hidden = true
        vc.player2Image.hidden = true
        vc.player1NameLabel.hidden = true
        vc.player2NameLabel.hidden = true
        vc.player1HpLabel.hidden = true
        vc.player2HpLabel.hidden = true
    }
    
    // Display game elements.
    func displayGameElements() {
        vc.player1AttackButton.hidden = false
        vc.player2AttackButton.hidden = false
        vc.player1Image.hidden = false
        vc.player2Image.hidden = false
        vc.player1NameLabel.hidden = false
        vc.player2NameLabel.hidden = false
        vc.player1HpLabel.hidden = false
        vc.player2HpLabel.hidden = false
    }
    
    // Hide result elements.
    func hideResultElements() {
        vc.restartButton.hidden = true
    }
    
    // Display result elements.
    func displayResultElements() {
        vc.restartButton.hidden = false
    }
    
}