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
    
    // -- Vars --
    var currentConnection: Puzzle!
    var correctWords: [Int]! = [0,6]
    var submittedGuess = true
    var letterToReveal: Int!
    var row2LettersShown = 0
    var row3LettersShown = 0
    var row4LettersShown = 0
    var row5LettersShown = 0
    var row6LettersShown = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        currentConnection = EASY_PUZZLES[0]
        // Do any additional setup after loading the view, typically from a nib.
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
        return self.gameBoard.frame.height/7
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
            word = currentConnection.word5
            numLettersToShow = row5LettersShown
        case 5:
            word = currentConnection.word6
            numLettersToShow = row6LettersShown
        case 6:
            word = currentConnection.word7
        default:
            break
        }
        cell.setupCell(index: indexPath.row, word: word, lettersToShow: numLettersToShow)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 || indexPath.row == 6 {
            return
        }
        if !correctWords.contains(indexPath.row+1) && !correctWords.contains(indexPath.row-1) {
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
                if row5LettersShown == currentConnection.word5.count {
                    correctWords.append(indexPath.row)
                }
            case 5:
                row6LettersShown += 1
                if row6LettersShown == currentConnection.word6.count {
                    correctWords.append(indexPath.row)
                }
            default:
                break
            }
            gameBoard.reloadRows(at: [indexPath], with: .none)
        }
        if submittedGuess {
            letterToReveal = indexPath.row
        }
    }
}

