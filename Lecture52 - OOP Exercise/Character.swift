//
//  Character.swift
//  Lecture52 - OOP Exercise
//
//  Created by Michael Jessey on 19/01/2016.
//  Copyright © 2016 JustOneJess. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class Character {
    
    private var _hp: Int = 100
    private var _attackPower: Int = 20
    private var _name: String = "CharacterName"
    private var _characterChoice: Int = 1
    
    // Getters (computed properties).
    var hp: Int {
        get { return _hp }
    }
    
    var attackPower: Int {
        get { return _attackPower }
    }
    
    var name: String {
        get { return _name }
    }
    
    var characterChoice: Int {
        get {return _characterChoice }
    }
    
    // Initialiser.
    init(startHp: Int, startAttackPower: Int, startName: String, characterChoiceIn: Int) {
        self._hp = startHp
        self._attackPower = startAttackPower
        self._name = startName
        self._characterChoice = characterChoiceIn
    }
    
    // Perform an attack.
    func performAttack(attackingPlayer: Character, playerBeingAttacked: Character) {
        // Randomise the attack power before attacking.
        attackingPlayer.randomiseAttackPower()
        
        if playerBeingAttacked._hp > 0 {
            playerBeingAttacked._hp -= attackingPlayer._attackPower
        }
    }
    
    // Check if still alive (i.e. HP above 0).
    func isAlive () -> Bool {
        if self._hp <= 0 {            
            return false
        }
        return true
    }
    
    // Randomise the attack power.
    func randomiseAttackPower() {
        self._attackPower = Int(arc4random_uniform(UInt32(_attackPower)))
    }
    
    // Reset the attack power back to the default.
    func resetAttackPower() {
        self._attackPower = 20
    }
    
    // Set the player's image (and flip the image if needed).
    func setPlayerImage(playerNumberIn: Int, imageChoiceIn: Int) -> UIImage {
        if imageChoiceIn == 1 {
            if playerNumberIn == 1 {
                let flippedImage = UIImage(CGImage: UIImage(named: "player")!.CGImage!, scale: 1.0, orientation: .UpMirrored)
                return flippedImage
            } else {
                return UIImage(named: "player")!
            }
            
        } else {
            if playerNumberIn == 2 {
                let flippedImage = UIImage(CGImage: UIImage(named: "enemy")!.CGImage!, scale: 1.0, orientation: .UpMirrored)
                return flippedImage
            } else {
                return UIImage(named: "enemy")!
            }
        }
    }
}