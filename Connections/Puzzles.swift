//
//  Puzzles.swift
//  Connections
//
//  Created by Tyler Lafferty on 1/23/19.
//  Copyright © 2019 Tyler Lafferty. All rights reserved.
//

import UIKit

class Puzzle {
    var word1: String!
    var word2: String!
    var word3: String!
    var word4: String!
    var word5: String?
    var word6: String?
    var word7: String?
    
    init(word1: String, word2: String, word3: String, word4: String, word5: String?="", word6: String?="", word7: String?="") {
        self.word1 = word1
        self.word2 = word2
        self.word3 = word3
        self.word4 = word4
        self.word5 = word5
        self.word6 = word6
        self.word7 = word7
    }
}

var EASY_PUZZLES: [Puzzle] =
    [
        Puzzle(word1: "crack", word2: "open", word3: "sesame", word4: "street")
]

var NORMAL_PUZZLES: [Puzzle] =
    [
        Puzzle(word1: "crack", word2: "open", word3: "sesame", word4: "street", word5: "smart")
]

var MEDIUM_PUZZLES: [Puzzle] =
    [
        Puzzle(word1: "crack", word2: "open", word3: "sesame", word4: "street", word5: "smart", word6: "cookie")
]

var HARD_PUZZLES: [Puzzle] =
    [
        Puzzle(word1: "crack", word2: "open", word3: "sesame", word4: "street", word5: "smart", word6: "cookie", word7: "monster"),
        Puzzle(word1: "strange", word2: "brew", word3: "pub", word4: "food", word5: "bank", word6: "card", word7: "table"),
        Puzzle(word1: "lionel", word2: "richie", word3: "rich", word4: "husband", word5: "material", word6: "gain", word7: "weight")
]
