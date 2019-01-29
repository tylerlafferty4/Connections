//
//  GameBoardViewController.swift
//  Connections
//
//  Created by Tyler Lafferty on 1/22/19.
//  Copyright © 2019 Tyler Lafferty. All rights reserved.
//

import UIKit

class GameBoardViewController: UIViewController {
    
    // -- Outlets --
    @IBOutlet weak var gameBoard: UITableView!
    @IBOutlet weak var guessField: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    
    // -- Vars --
    var currentConnection: Puzzle!
    var correctWords: [Int]! = [0]
    var row2LettersShown = 0
    var row3LettersShown = 0
    var row4LettersShown = 0
    var row5LettersShown = 0
    var row6LettersShown = 0
    var selectedRow: Int!
    var timeToSubmit = false
    var difficulty: Difficulty!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Easy Puzzle Test
        if difficulty == .easy {
            currentConnection = EASY_PUZZLES[0]
        } else if difficulty == .normal {
            currentConnection = NORMAL_PUZZLES[0]
        } else if difficulty == .medium {
            currentConnection = MEDIUM_PUZZLES[0]
        } else if difficulty == .hard {
            currentConnection = HARD_PUZZLES[2]
        }
        
        correctWords.append(Int(getRowCount()-1))
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func submitGuess(_ sender: Any) {
        if selectedRow == nil {
            showAlert(message: SELECT_A_LETTER)
            return
        }
        if timeToSubmit == false {
            showAlert(message: SELECT_A_LETTER)
            return
        }
        if let guess = guessField.text {
            let stripped = guess.replacingOccurrences(of: " ", with: "")
            if stripped != "" {
                timeToSubmit = false
                guessField.text = ""
                checkGuess(guess: stripped, rowToCheck: selectedRow)
            }
        }
    }
}

// MARK: - UITable View Delegate Datasource
extension GameBoardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let count = getRowCount()
        return self.gameBoard.frame.height/count
    }
    
    func getRowCount() -> CGFloat {
        if currentConnection.word5 == "" {
            return 4
        } else if currentConnection.word6 == "" {
            return 5
        } else if currentConnection.word7 == "" {
            return 6
        }
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wordCell", for: indexPath) as! WordTableViewCell
        var numLettersToShow = 0
        var word = ""
        switch indexPath.row {
        case 0:
            word = currentConnection.word1
        case 1:
            word = currentConnection.word2
            numLettersToShow = row2LettersShown
        case 2:
            word = currentConnection.word3
            numLettersToShow = row3LettersShown
        case 3:
            word = currentConnection.word4
            numLettersToShow = row4LettersShown
        case 4:
            word = currentConnection.word5!
            numLettersToShow = row5LettersShown
        case 5:
            word = currentConnection.word6!
            numLettersToShow = row6LettersShown
        case 6:
            word = currentConnection.word7!
        default:
            break
        }
        cell.setupCell(index: indexPath.row, word: word, lettersToShow: numLettersToShow, count: Int(getRowCount()-1))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if timeToSubmit {
            showAlert(message: SUBMIT_GUESS)
            return
        }
        if indexPath.row == 0 || indexPath.row == Int(getRowCount()-1) || correctWords.contains(indexPath.row) {
            showAlert(message: ALREADY_SOLVED)
            return
        }
        
        // Set the selected row that the guess will happen too
        selectedRow = indexPath.row
        
        if !correctWords.contains(indexPath.row+1) && !correctWords.contains(indexPath.row-1) {
            showAlert(message: ALREADY_SOLVED)
            return
        } else {
            switch indexPath.row {
            case 1:
                row2LettersShown += 1
                if row2LettersShown == currentConnection.word2.count {
                    correctWords.append(indexPath.row)
                }
            case 2:
                row3LettersShown += 1
                if row3LettersShown == currentConnection.word3.count {
                    correctWords.append(indexPath.row)
                }
            case 3:
                row4LettersShown += 1
                if row4LettersShown == currentConnection.word4.count {
                    correctWords.append(indexPath.row)
                }
            case 4:
                row5LettersShown += 1
                if row5LettersShown == currentConnection.word5!.count {
                    correctWords.append(indexPath.row)
                }
            case 5:
                row6LettersShown += 1
                if row6LettersShown == currentConnection.word6!.count {
                    correctWords.append(indexPath.row)
                }
            default:
                break
            }
            timeToSubmit = true
            gameBoard.reloadRows(at: [indexPath], with: .fade)
        }
    }
}

// MARK: - Helpers
extension GameBoardViewController {
    
    func checkGuess(guess : String, rowToCheck : Int) {
        print("Checking guess")
        switch rowToCheck {
        case 1:
            if guess == currentConnection.word2 {
                correctWords.append(rowToCheck)
                row2LettersShown = currentConnection.word2.count
                gameBoard.reloadRows(at: [IndexPath(row: rowToCheck, section: 0)], with: .fade)
            } else {
                showIncorrectAnswer(row: rowToCheck)
            }
        case 2:
            if guess == currentConnection.word3 {
                correctWords.append(rowToCheck)
                row3LettersShown = currentConnection.word3.count
                gameBoard.reloadRows(at: [IndexPath(row: rowToCheck, section: 0)], with: .fade)
            }
        case 3:
            if guess == currentConnection.word4 {
                correctWords.append(rowToCheck)
                row4LettersShown = currentConnection.word4.count
                gameBoard.reloadRows(at: [IndexPath(row: rowToCheck, section: 0)], with: .fade)
            }
        case 4:
            if guess == currentConnection.word5 {
                correctWords.append(rowToCheck)
                row5LettersShown = currentConnection.word5!.count
                gameBoard.reloadRows(at: [IndexPath(row: rowToCheck, section: 0)], with: .fade)
            }
        case 5:
            if guess == currentConnection.word6 {
                correctWords.append(rowToCheck)
                row6LettersShown = currentConnection.word6!.count
                gameBoard.reloadRows(at: [IndexPath(row: rowToCheck, section: 0)], with: .fade)
            }
        default:
            break
        }
        if checkAllSolved() {
            showAlert(message: CONGRATULATIONS)
        }
    }
    
    func checkAllSolved() -> Bool {
        switch getRowCount() {
        case 4:
            if correctWords.contains(0) && correctWords.contains(1) && correctWords.contains(2) && correctWords.contains(3) {
                return true
            }
        case 5:
            if correctWords.contains(0) && correctWords.contains(1) && correctWords.contains(2) && correctWords.contains(3) && correctWords.contains(4) {
                return true
            }
        case 6:
            if correctWords.contains(0) && correctWords.contains(1) && correctWords.contains(2) && correctWords.contains(3) && correctWords.contains(4) && correctWords.contains(5) {
                return true
            }
        case 7:
            if correctWords.contains(0) && correctWords.contains(1) && correctWords.contains(2) && correctWords.contains(3) && correctWords.contains(4) && correctWords.contains(5) && correctWords.contains(6) {
                return true
            }
        default:
            return false
        }
        return false
    }
    
    func showIncorrectAnswer(row : Int) {
        gameBoard.cellForRow(at: IndexPath(row: row, section: 0))?.backgroundColor = INCORRECT_COLOR
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            UIView.animate(withDuration: 0.3, animations: {
                self.gameBoard.cellForRow(at: IndexPath(row: row, section: 0))?.backgroundColor = EMPTY_COLOR
            })
//            , completion: { (complete) in
//                UIView.animate(withDuration: 0.3, animations: {
//                    self.gameBoard.cellForRow(at: IndexPath(row: row, section: 0))?.backgroundColor = INCORRECT_COLOR
//                }, completion: { (complete) in
//                    UIView.animate(withDuration: 0.3, animations: {
//                        self.gameBoard.cellForRow(at: IndexPath(row: row, section: 0))?.backgroundColor = EMPTY_COLOR
//                    })
//                })
//            })
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Connections", message: message, preferredStyle: .alert)
        let confirm = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(confirm)
        self.present(alert, animated: true, completion: nil)
    }
}

