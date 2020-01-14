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
    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet weak var backArrow: UIImageView!
    
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
    var timer = Timer()
    var seconds: Int! = 60
    var score: Int! = 0
    var currentPuzzles: [Puzzle]! = []
    var easyPuzzles: [Puzzle]! = []
    var mediumPuzzles: [Puzzle]! = []
    var normalPuzzles: [Puzzle]! = []
    var hardPuzzles: [Puzzle]! = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(GameBoardViewController.dismissController))
        backArrow.addGestureRecognizer(tap)
        
        scoreLbl.text = "\(score!)"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updatePuzzles()
        createPuzzle()
        correctWords.append(Int(getRowCount()-1))
        setPuzzleTime()
        startTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    
    @IBAction func submitGuess(_ sender: Any) {
        submitGuess()
    }
    
    @objc func dismissController() {
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gameOver" {
            let vc = segue.destination as! GameOverViewController
            vc.score = score
        }
    }
}

// MARK: - UITable View Delegate Datasource
extension GameBoardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(getRowCount())
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let count = getRowCount()
        return self.gameBoard.frame.height/count
    }
    
    func getRowCount() -> CGFloat {
        if currentConnection != nil {
            if difficulty == Difficulty.easy {
                return 4
            } else if difficulty == Difficulty.medium {
                return 5
            } else if difficulty == Difficulty.hard {
                return 6
            }
            return 0
        }
        return 0
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
        cell.setupCell(index: indexPath.row, word: word, lettersToShow: numLettersToShow, count: Int(getRowCount()-1), solved: correctWords.contains(indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if timeToSubmit {
            showAlert(message: SUBMIT_GUESS, color: INCORRECT_COLOR)
            return
        }
        if indexPath.row == 0 || indexPath.row == Int(getRowCount()-1) || correctWords.contains(indexPath.row) {
            showAlert(message: ALREADY_SOLVED, color: INCORRECT_COLOR)
            return
        }
        
        // Set the selected row that the guess will happen too
        selectedRow = indexPath.row
        
        if !correctWords.contains(indexPath.row+1) && !correctWords.contains(indexPath.row-1) {
            showAlert(message: ALREADY_SOLVED, color: INCORRECT_COLOR)
            return
        } else {
            switch indexPath.row {
            case 1:
                if row2LettersShown == currentConnection.word2.count {
                    showAlert(message: NO_MORE_LETTERS, color: INCORRECT_COLOR)
                } else {
                    row2LettersShown += 1
                }
            case 2:
                if row3LettersShown == currentConnection.word3.count {
                    showAlert(message: NO_MORE_LETTERS, color: INCORRECT_COLOR)
                } else {
                    row3LettersShown += 1
                }
            case 3:
                if row4LettersShown == currentConnection.word4.count {
                    showAlert(message: NO_MORE_LETTERS, color: INCORRECT_COLOR)
                } else {
                    row4LettersShown += 1
                }
            case 4:
                if row5LettersShown == currentConnection.word5!.count {
                    showAlert(message: NO_MORE_LETTERS, color: INCORRECT_COLOR)
                } else {
                    row5LettersShown += 1
                }
            case 5:
                if row6LettersShown == currentConnection.word6!.count {
                    showAlert(message: NO_MORE_LETTERS, color: INCORRECT_COLOR)
                } else {
                    row6LettersShown += 1
                }
            default:
                break
            }
            timeToSubmit = true
            guessField.becomeFirstResponder()
            gameBoard.reloadRows(at: [indexPath], with: .fade)
        }
    }
}

// MARK: - Text Field Delegate
extension GameBoardViewController : UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if selectedRow == nil {
            showAlert(message: SELECT_A_LETTER, color: INCORRECT_COLOR)
            return false
        }
        if timeToSubmit == false {
            showAlert(message: SELECT_A_LETTER, color: INCORRECT_COLOR)
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        submitGuess()
        return true
    }
}

// MARK: - Timer Logic
extension GameBoardViewController {
    
    @objc func updateTimer() {
        seconds -= 1
        timerLbl.text = "\(seconds!)"
        if seconds == 0 {
            timer.invalidate()
            timer.invalidate()
////            showAlert(message: GAME_OVER, color: INCORRECT_COLOR)
//            let customAlert = CustomAlertView()
//            let mainMenu = CustomAlertAction(title: "Main Menu") {
//
//            }
//            let playAgain = CustomAlertAction(title: "Play Again") {
//
//            }
//            customAlert.showAlertView(superview: self.view, title: "Connections", text: GAME_OVER, confirmAction: mainMenu, cancelAction: playAgain)
            self.performSegue(withIdentifier: "gameOver", sender: self)
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(GameBoardViewController.updateTimer), userInfo: nil, repeats: true)
    }
    
    func setPuzzleTime() {
        if difficulty == .easy {
            seconds = EASY_SECONDS
        } else if difficulty == .medium {
            seconds = MEDIUM_SECONDS
        } else if difficulty == .hard {
            seconds = HARD_SECONDS
        }
        timerLbl.text = "\(seconds!)"
    }
}

// MARK: - Puzzle Logic
extension GameBoardViewController {
    
    func createPuzzle() {
        if determineAllPuzzlesSolved(puzzles: currentPuzzles) {
            var foundPuzzle = false
            while !foundPuzzle {
                let puzzle = currentPuzzles[getRandom(count: currentPuzzles.count)]
                if !puzzle.solved {
                    currentConnection = puzzle
                    gameBoard.reloadData()
                    foundPuzzle = true
                }
            }
        } else {
            var key = ""
            if difficulty == Difficulty.easy {
                key = EASY_KEY
                difficulty = Difficulty.medium
            } else if difficulty == Difficulty.medium {
                key = MEDIUM_KEY
                difficulty = Difficulty.hard
            } else if difficulty == Difficulty.hard {
                key = HARD_KEY
            }
            ConnectionsShared.resetPuzzles(puzzles: currentPuzzles, key: key)
            updatePuzzles()
            loadNextPuzzle()
        }
    }
    
    func createMediumPuzzle() {
        if determineAllPuzzlesSolved(puzzles: mediumPuzzles) {
            let puzzle = mediumPuzzles[getRandom(count: mediumPuzzles.count)]
            if puzzle.solved {
                createMediumPuzzle()
            } else {
                currentConnection = puzzle
            }
        } else {
            ConnectionsShared.resetPuzzles(puzzles: mediumPuzzles, key: MEDIUM_KEY)
            updatePuzzles()
        }
    }
    
    func createHardPuzzle() {
        if determineAllPuzzlesSolved(puzzles: hardPuzzles) {
            let puzzle = hardPuzzles[getRandom(count: hardPuzzles.count)]
            if puzzle.solved {
                createHardPuzzle()
            } else {
                currentConnection = puzzle
            }
        } else {
            ConnectionsShared.resetPuzzles(puzzles: hardPuzzles, key: HARD_KEY)
            updatePuzzles()
        }
    }
    
    func determineAllPuzzlesSolved(puzzles : [Puzzle]) -> Bool {
        var unsolved = false
        for puzzle in puzzles {
            if !puzzle.solved {
                unsolved = true
                break
            }
        }
        return unsolved
    }
    
    func getRandom(count : Int) -> Int {
        if count-1 == 0 {
            return 0
        }
        return Int.random(in: 0 ..< count)
    }
    
//    func determinePuzzleDifficulty() {
//        if difficulty == Difficulty.easy {
//            createEasyPuzzle()
//        } else if difficulty == Difficulty.medium {
//            createMediumPuzzle()
//        } else if difficulty == Difficulty.hard {
//            createHardPuzzle()
//        }
//    }
    
    func updatePuzzles() {
        if difficulty == Difficulty.easy {
            currentPuzzles = ConnectionsShared.retrievePuzzles(key: EASY_KEY)
        } else if difficulty == Difficulty.medium {
            currentPuzzles = ConnectionsShared.retrievePuzzles(key: MEDIUM_KEY)
        } else if difficulty == Difficulty.hard {
            currentPuzzles = ConnectionsShared.retrievePuzzles(key: HARD_KEY)
        }
    }
    
    func loadNextPuzzle() {
        row2LettersShown = 0
        row3LettersShown = 0
        row4LettersShown = 0
        row5LettersShown = 0
        row6LettersShown = 0
        setPuzzleTime()
        createPuzzle()
        correctWords = [0, Int(getRowCount()-1)]
        gameBoard.reloadData()
        startTimer()
    }
}

// MARK: - Helpers
extension GameBoardViewController {
    
    func submitGuess() {
        if selectedRow == nil {
            showAlert(message: SELECT_A_LETTER, color: INCORRECT_COLOR)
            return
        }
        if timeToSubmit == false {
            showAlert(message: SELECT_A_LETTER, color: INCORRECT_COLOR)
            return
        }
        if let guess = guessField.text {
            let stripped = guess.replacingOccurrences(of: " ", with: "")
            if stripped != "" {
                timeToSubmit = false
                guessField.text = ""
                checkGuess(guess: stripped, rowToCheck: selectedRow)
                guessField.resignFirstResponder()
            }
        }
    }
    
    func checkGuess(guess : String, rowToCheck : Int) {
        var correct = false
        switch rowToCheck {
        case 1:
            if guess == currentConnection.word2 {
                correctWords.append(rowToCheck)
                row2LettersShown = currentConnection.word2.count
                correct = true
            }
        case 2:
            if guess == currentConnection.word3 {
                correctWords.append(rowToCheck)
                row3LettersShown = currentConnection.word3.count
                correct = true
            }
        case 3:
            if guess == currentConnection.word4 {
                correctWords.append(rowToCheck)
                row4LettersShown = currentConnection.word4.count
                correct = true
            }
        case 4:
            if guess == currentConnection.word5 {
                correctWords.append(rowToCheck)
                row5LettersShown = currentConnection.word5!.count
                correct = true
            }
        case 5:
            if guess == currentConnection.word6 {
                correctWords.append(rowToCheck)
                row6LettersShown = currentConnection.word6!.count
                correct = true
            }
        default:
            break
        }
        if correct {
            gameBoard.reloadRows(at: [IndexPath(row: rowToCheck, section: 0)], with: .fade)
        } else {
            showIncorrectAnswer(row: rowToCheck)
        }
        if checkAllSolved() {
            timer.invalidate()
            guessField.resignFirstResponder()
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (timer) in
                self.score += 1
                self.scoreLbl.text = "\(self.score!)"
                self.currentConnection.solved = true
                self.loadNextPuzzle()
            }
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
        }
    }
    
    func showAlert(message: String, color: UIColor) {
//        let alert = UIAlertController(title: "Connections", message: message, preferredStyle: .alert)
//        let confirm = UIAlertAction(title: "OK", style: .default, handler: nil)
//        alert.addAction(confirm)
//        self.present(alert, animated: true, completion: nil)
        let banner = Banner(title: "Connections", subtitle: message, backgroundColor: color)
        banner.dismissesOnTap = true
        banner.show(duration: 3)
    }
}





//        let word1 = PUZZLES[getRandom(count: PUZZLES.count)]
//        let word2 = getSubWord(word: word1.word, allowFinal: false) //word1.subWords[getRandom(count: word1.subWords.count)].word!
//        let word3 = getSubWord(word: word2, allowFinal: false)
//        let word4 = getSubWord(word: word3, allowFinal: false)
//        let word5 = getSubWord(word: word4, allowFinal: false)
//        let word6 = getSubWord(word: word5, allowFinal: false)
//        let word7 = getSubWord(word: word6, allowFinal: true)
//        currentConnection = Puzzle(word1: word1.word, word2: word2, word3: word3, word4: word4, word5: word5, word6: word6, word7: word7)
//    func getSubWord(word: String, allowFinal: Bool) -> String {
//        for wordKey in PUZZLES {
//            // Find the key for the word above
//            if word == wordKey.word {
//                // Determine the sub word
//                var solved = false
//                var sub: SubWord!
//                while solved == false {
//                    sub = wordKey.subWords[getRandom(count: wordKey.subWords.count)]
//                    if sub.solved == false {
//                        if allowFinal == false {
//                            if determineFinal(word: sub.word) {
//                                solved = true
//                            }
//                        } else {
//                            solved = true
//                        }
//                    }
//                }
//                if sub != nil {
//                    return sub.word
//                }
//            }
//        }
//        return ""
//    }
//
//    func determineFinal(word: String) -> Bool {
//        for wordKey in PUZZLES {
//            if word == wordKey.word {
//                if wordKey.subWords.count > 0 {
//                    return true
//                } else {
//                    return false
//                }
//            }
//        }
//        return false
//    }

