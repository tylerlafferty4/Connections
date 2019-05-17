//
//  HomeViewController.swift
//  Connections
//
//  Created by Tyler Lafferty on 1/28/19.
//  Copyright © 2019 Tyler Lafferty. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController : UIViewController {
    
    // -- Outlets --
    @IBOutlet weak var easyBtn: UIButton!
    @IBOutlet weak var normalBtn: UIButton!
    @IBOutlet weak var mediumBtn: UIButton!
    @IBOutlet weak var hardBtn: UIButton!
    
    // -- Vars --
    var selectedDifficulty: Difficulty!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConnectionsShared.storeInitialPuzzles()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGameboard" {
            let vc = segue.destination as! GameBoardViewController
            vc.difficulty = selectedDifficulty
        }
    }
    @IBAction func easyTapped(_ sender: Any) {
        selectedDifficulty = .easy
        performSegue(withIdentifier: "showGameboard", sender: self)
    }
    
    @IBAction func mediumTapped(_ sender: Any) {
        selectedDifficulty = .medium
        performSegue(withIdentifier: "showGameboard", sender: self)
    }
    
    @IBAction func hardTapped(_ sender: Any) {
        selectedDifficulty = .hard
        performSegue(withIdentifier: "showGameboard", sender: self)
    }
    
    @IBAction func resetPuzzles(_ sender: Any) {
        ConnectionsShared.resetGame()
        ConnectionsShared.storeInitialPuzzles()
    }
}
