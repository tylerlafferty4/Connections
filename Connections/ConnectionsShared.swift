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
    case easy, normal, medium, hard
}

class ConnectionsShared {
    
}

// MARK: - Alert Messages
var SELECT_A_LETTER="Please select a row for a letter before submitting a guess"
var SUBMIT_GUESS="Please submit a guess before you can reveal another letter"
var ALREADY_SOLVED="You've already solved this word. Please select another word"
var CONGRATULATIONS="Congratulations on solving the puzzle"

// MARK: - Colors
var EMPTY_COLOR=UIColor.clear
var CORRECT_COLOR=UIColor.green
var INCORRECT_COLOR=UIColor.red
