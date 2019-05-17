//
//  Puzzles.swift
//  Connections
//
//  Created by Tyler Lafferty on 1/23/19.
//  Copyright © 2019 Tyler Lafferty. All rights reserved.
//

import UIKit

class Puzzle: NSObject, NSCoding {
    var word1: String!
    var word2: String!
    var word3: String!
    var word4: String!
    var word5: String?
    var word6: String?
    var word7: String?
    var solved: Bool!
    
    init(word1: String, word2: String, word3: String, word4: String, word5: String?="", word6: String?="", word7: String?="", solved: Bool) {
        self.word1 = word1
        self.word2 = word2
        self.word3 = word3
        self.word4 = word4
        self.word5 = word5
        self.word6 = word6
        self.word7 = word7
        self.solved = solved
    }
    
    required convenience init(coder aDecoder : NSCoder) {
        let word1 = aDecoder.decodeObject(forKey: "word1") as! String
        let word2 = aDecoder.decodeObject(forKey: "word2") as! String
        let word3 = aDecoder.decodeObject(forKey: "word3") as! String
        let word4 = aDecoder.decodeObject(forKey: "word4") as! String
        let word5 = aDecoder.decodeObject(forKey: "word5") as? String
        let word6 = aDecoder.decodeObject(forKey: "word6") as? String
        let word7 = aDecoder.decodeObject(forKey: "word7") as? String
        let solved = aDecoder.decodeObject(forKey: "solved") as! Bool
        self.init(word1: word1, word2: word2, word3: word3, word4: word4, word5: word5, word6: word6, word7: word7, solved: solved)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(word1, forKey: "word1")
        aCoder.encode(word2, forKey: "word2")
        aCoder.encode(word3, forKey: "word3")
        aCoder.encode(word4, forKey: "word4")
        aCoder.encode(solved, forKey: "solved")
        aCoder.encode(word5, forKey: "word5")
        aCoder.encode(word6, forKey: "word6")
        aCoder.encode(word7, forKey: "word7")
    }
}

var EASY_PUZZLES: [Puzzle] = [
    Puzzle(word1: "smart", word2: "water", word3: "bottle", word4: "opener", solved: false),
    Puzzle(word1: "sesame", word2: "street", word3: "sign", word4: "language", solved: false),
    Puzzle(word1: "lady", word2: "bug", word3: "spray", word4: "tan", solved: false),
    Puzzle(word1: "signature", word2: "dish", word3: "soap", word4: "suds", solved: false),
    Puzzle(word1: "nile", word2: "river", word3: "bank", word4: "account", solved: false)
]

var MEDIUM_PUZZLES: [Puzzle] = [
    Puzzle(word1: "slow", word2: "pitch", word3: "black", word4: "tie", word5: "dye", solved: false),
    Puzzle(word1: "slow", word2: "dance", word3: "break", word4: "ice", word5: "cream", solved: false),
    Puzzle(word1: "green", word2: "bean", word3: "bag", word4: "toss", word5: "salad", solved: false)
]

var HARD_PUZZLES: [Puzzle] = [
    Puzzle(word1: "brick", word2: "wall", word3: "street", word4: "taco", word5: "bell", word6: "pepper", solved: false),
    Puzzle(word1: "bobby", word2: "pin", word3: "cusion", word4: "cover", word5: "letter", word6: "sorting", solved: false),
    Puzzle(word1: "razor", word2: "thin", word3: "line", word4: "cook", word5: "food", word6: "network", solved: false)
]

//class PuzzleKey {
//    var word: String!
//    var subWords: [SubWord]!
//
//    init(word: String, subWords: [SubWord]) {
//        self.word = word
//        self.subWords = subWords
//    }
//}
//
//class SubWord {
//    var word: String!
//    var solved: Bool!
//
//    init(word: String, solved: Bool) {
//        self.word = word
//        self.solved = solved
//    }
//}
//    PuzzleKey(word: "open", subWords: [
//        SubWord(word: "sesame", solved: false),
//        SubWord(word: "door", solved: false)
//    ]),
//    PuzzleKey(word: "sesame", subWords: [
//        SubWord(word: "street", solved: false)
//    ]),
//    PuzzleKey(word: "crack", subWords: [
//        SubWord(word: "open", solved: false)
//    ]),
//    PuzzleKey(word: "street", subWords: [
//        SubWord(word: "smart", solved: false),
//        SubWord(word: "sign", solved: false),
//        SubWord(word: "light", solved: false)
//    ]),
//    PuzzleKey(word: "smart", subWords: [
//        SubWord(word: "water", solved: false)
//    ]),
//    PuzzleKey(word: "water", subWords: [
//        SubWord(word: "crack", solved: false)
//    ]),
//    PuzzleKey(word: "door", subWords: [
//        SubWord(word: "jam", solved: false)
//    ]),
//    PuzzleKey(word: "sign", subWords: [
//        SubWord(word: "language", solved: false)
//    ])

