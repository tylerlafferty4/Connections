//
//  GameOverViewController.swift
//  Connections
//
//  Created by Tyler Lafferty on 5/23/19.
//  Copyright © 2019 Tyler Lafferty. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {
    
    // -- Outlets --
    @IBOutlet weak var playAgainBtn: UIButton!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet weak var highScoreLbl: UILabel!
    
    // -- Vars --
    var score: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLbl.text = "\(score!)"
        determineHighScore()
        // Do any additional setup after loading the view.
    }
    
    // MARK: Button Actions
    @IBAction func playAgain(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func mainMenu(_ sender: Any) {
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - Helpers
extension GameOverViewController {
    
    func determineHighScore() {
        if let highScore = UserDefaults.standard.object(forKey: HIGH_SCORE) as? Int {
            if score > highScore {
                // New high score
                highScoreLbl.text = "\(score!)"
                ConnectionsShared.updateHighScore(score: score)
            } else {
                highScoreLbl.text = "\(highScore)"
            }
        } else {
            highScoreLbl.text = "\(score!)"
        }
    }
}
