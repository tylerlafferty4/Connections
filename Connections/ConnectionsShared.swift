//
//  ConnectionsShared.swift
//  Connections
//
//  Created by Tyler Lafferty on 1/28/19.
//  Copyright © 2019 Tyler Lafferty. All rights reserved.
//

import Foundation
import UIKit

enum Difficulty {
    case easy, medium, hard
}

class ConnectionsShared {
    
    var shared: ConnectionsShared! = ConnectionsShared()
    
    var score: Int!
    
    class func updateHighScore(score: Int) {
        UserDefaults.standard.set(score, forKey: HIGH_SCORE)
        UserDefaults.standard.synchronize()
    }
    
    class func resetGame() {
        UserDefaults.standard.removeObject(forKey: INITIAL_LOAD)
        UserDefaults.standard.synchronize()
    }
    
    class func storeInitialPuzzles() {
        if let _ = UserDefaults.standard.object(forKey: INITIAL_LOAD) {
            return
        }
        print("Storing puzzles")
        do {
            let easy: Data = try NSKeyedArchiver.archivedData(withRootObject: EASY_PUZZLES, requiringSecureCoding: false)
            UserDefaults.standard.set(easy, forKey: EASY_KEY)
            let medium: Data = try NSKeyedArchiver.archivedData(withRootObject: MEDIUM_PUZZLES, requiringSecureCoding: false)
            UserDefaults.standard.set(medium, forKey: MEDIUM_KEY)
            let hard: Data = try NSKeyedArchiver.archivedData(withRootObject: HARD_PUZZLES, requiringSecureCoding: false)
            UserDefaults.standard.set(hard, forKey: HARD_KEY)
            UserDefaults.standard.set(true, forKey: INITIAL_LOAD)
            UserDefaults.standard.synchronize()
        } catch {
            print("Failed to store initial puzzles")
        }
    }
    
    class func storePuzzles(puzzles: [Puzzle], key: String) {
        do {
            let encoded: Data = try NSKeyedArchiver.archivedData(withRootObject: puzzles, requiringSecureCoding: false)
            UserDefaults.standard.set(encoded, forKey: key)
            UserDefaults.standard.synchronize()
        } catch {
            print("Failed to store puzzles")
        }
    }
    
    class func resetPuzzles(puzzles: [Puzzle], key: String) {
        for puzzle in puzzles {
            puzzle.solved = false
        }
        storePuzzles(puzzles: puzzles, key: key)
    }
    
    class func updatePuzzle(difficulty: Difficulty) {
        
    }
    
    class func retrievePuzzles(key: String) -> [Puzzle] {
//        do {
            let decoded = UserDefaults.standard.object(forKey: key) as! Data
            return NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [Puzzle]
//            if let puzzles = try NSKeyedUnarchiver.unarchivedObject(ofClass: Puzzle.self, from: decoded) as? [Puzzle] {
//
//            }
//        } catch {
//            print("Retrieving puzzles failed")
//            return []
//        }
    }
}

class SegueFromLeft: UIStoryboardSegue {
    override func perform() {
        let src = self.source
        let dst = self.destination
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: src.view.frame.size.width, y: 0)
        
        UIView.animate(withDuration: 0.25,
                       delay: 0.0,
                       options: .curveEaseInOut,
                       animations: {
                        dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
        },
                       completion: { finished in
                        src.present(dst, animated: false, completion: nil)
        }
        )
    }
}

// MARK: - Alert Messages
var SELECT_A_LETTER="Please select a row for a letter before submitting a guess"
var SUBMIT_GUESS="Please submit a guess before you can reveal another letter"
var ALREADY_SOLVED="You've already solved this word. Please select another word"
var NO_MORE_LETTERS="There are no more letters to show"
var CONGRATULATIONS="Congratulations on solving the puzzle"
var GAME_OVER="Time is up. Game Over"

// MARK: - Colors
var UNSOLVED_TEXT=UIColor.black
var SOLVED_TEXT=UIColor.black
var EMPTY_COLOR=UIColor.clear
var CORRECT_COLOR=UIColor.green
var INCORRECT_COLOR=UIColor.red

// MARK: - Timers
var EASY_SECONDS=30
var MEDIUM_SECONDS=45
var HARD_SECONDS=60

// MARK: - Standard Defaults
var EASY_KEY="easy"
var MEDIUM_KEY="medium"
var HARD_KEY="hard"
var INITIAL_LOAD="initialLoadDone"
var HIGH_SCORE="highScore"
