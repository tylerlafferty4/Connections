//
//  WordTableViewCell.swift
//  Connections
//
//  Created by Tyler Lafferty on 1/22/19.
//  Copyright © 2019 Tyler Lafferty. All rights reserved.
//

import UIKit

class WordTableViewCell: UITableViewCell {
    
    // -- Outlets --
    @IBOutlet weak var letter1: UILabel!
    @IBOutlet weak var letter2: UILabel!
    @IBOutlet weak var letter3: UILabel!
    @IBOutlet weak var letter4: UILabel!
    @IBOutlet weak var letter5: UILabel!
    @IBOutlet weak var letter6: UILabel!
    @IBOutlet weak var letter7: UILabel!
    @IBOutlet weak var letter8: UILabel!
    @IBOutlet weak var letter9: UILabel!
    @IBOutlet weak var letter10: UILabel!
    @IBOutlet weak var letter11: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addBorders(label: letter1)
        addBorders(label: letter2)
        addBorders(label: letter3)
        addBorders(label: letter4)
        addBorders(label: letter5)
        addBorders(label: letter6)
        addBorders(label: letter7)
        addBorders(label: letter8)
//        addBorders(label: letter9)
//        addBorders(label: letter10)
//        addBorders(label: letter11)
    }
    
    func setupCell(index: Int, word: String, lettersToShow: Int, count: Int, solved: Bool) {
        let letters = Array(word)
        if index == 0 || index == count {
            setFullWord(letters: letters)
            setLetterColors(color: CORRECT_COLOR, textColor: SOLVED_TEXT)
        } else {
            clearLetters()
            setLetters(count: lettersToShow, letters: letters, solved: solved)
        }
    }
    
    func setLetters(count : Int, letters : [Character], solved: Bool) {
        if count >= 1 {
            letter1.text = checkIfEmpty(letters: letters, index: 0).uppercased()
        }
        if count >= 2 {
            letter2.text = checkIfEmpty(letters: letters, index: 1).uppercased()
        }
        if count >= 3 {
            letter3.text = checkIfEmpty(letters: letters, index: 2).uppercased()
        }
        if count >= 4 {
            letter4.text = checkIfEmpty(letters: letters, index: 3).uppercased()
        }
        if count >= 5 {
            letter5.text = checkIfEmpty(letters: letters, index: 4).uppercased()
        }
        if count >= 6 {
            letter6.text = checkIfEmpty(letters: letters, index: 5).uppercased()
        }
        if count >= 7 {
            letter7.text = checkIfEmpty(letters: letters, index: 6).uppercased()
        }
        if count >= 8 {
            letter8.text = checkIfEmpty(letters: letters, index: 7).uppercased()
        }
        if count >= 9 {
            letter9.text = checkIfEmpty(letters: letters, index: 8).uppercased()
        }
        if count >= 10 {
            letter10.text = checkIfEmpty(letters: letters, index: 9).uppercased()
        }
        if count >= 11 {
            letter11.text = checkIfEmpty(letters: letters, index: 10).uppercased()
        }
        if solved {
            setLetterColors(color: CORRECT_COLOR, textColor: SOLVED_TEXT)
        } else {
            setLetterColors(color: EMPTY_COLOR, textColor: UNSOLVED_TEXT)
        }
    }
    
    func setLetterColors(color : UIColor, textColor: UIColor) {
        letter1.backgroundColor = color
        letter1.textColor = textColor
        letter2.backgroundColor = color
        letter2.textColor = textColor
        letter3.backgroundColor = color
        letter3.textColor = textColor
        letter4.backgroundColor = color
        letter4.textColor = textColor
        letter5.backgroundColor = color
        letter5.textColor = textColor
        letter6.backgroundColor = color
        letter6.textColor = textColor
        letter7.backgroundColor = color
        letter7.textColor = textColor
        letter8.backgroundColor = color
        letter8.textColor = textColor
//        letter9.backgroundColor = color
//        letter10.backgroundColor = color
//        letter11.backgroundColor = color
    }
    
    func setFullWord(letters : [Character]) {
        letter1.text = checkIfEmpty(letters: letters, index: 0).uppercased()
        letter2.text = checkIfEmpty(letters: letters, index: 1).uppercased()
        letter3.text = checkIfEmpty(letters: letters, index: 2).uppercased()
        letter4.text = checkIfEmpty(letters: letters, index: 3).uppercased()
        letter5.text = checkIfEmpty(letters: letters, index: 4).uppercased()
        letter6.text = checkIfEmpty(letters: letters, index: 5).uppercased()
        letter7.text = checkIfEmpty(letters: letters, index: 6).uppercased()
        letter8.text = checkIfEmpty(letters: letters, index: 7).uppercased()
//        letter9.text = checkIfEmpty(letters: letters, index: 8).uppercased()
//        letter10.text = checkIfEmpty(letters: letters, index: 9).uppercased()
//        letter11.text = checkIfEmpty(letters: letters, index: 10).uppercased()
    }
    
    func checkIfEmpty(letters : [Character], index: Int) -> String {
        if letters.count >= index+1 {
            return String(letters[index])
        } else {
            return ""
        }
    }
    
    func clearLetters() {
        letter1.text = ""
        letter2.text = ""
        letter3.text = ""
        letter4.text = ""
        letter5.text = ""
        letter6.text = ""
        letter7.text = ""
        letter8.text = ""
//        letter9.text = ""
//        letter10.text = ""
//        letter11.text = ""
    }
    
    func addBorders(label: UILabel) {
        label.layer.cornerRadius = 3
        label.layer.borderColor = UIColor.gray.cgColor
        label.layer.borderWidth = 1
    }
}
