//
//  MenuController.swift
//  tictactoe
//
//  Created by Sergio P. on 7/18/19.
//  Copyright © 2019 Sergio P. All rights reserved.
//

import UIKit

class MainMenuController: UIViewController {
    
    var gameModeSelected:GameMode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.1882352941, blue: 0.1882352941, alpha: 1)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let game = segue.destination as? GameViewController
        game?.mode = gameModeSelected
    }
    
    @IBAction func pvpSelected(_ sender: Any) {
        gameModeSelected = GameMode.PVP
        performSegue(withIdentifier: "toGameView", sender: self)
    }
    
    @IBAction func cpuSelected(_ sender: Any) {
        gameModeSelected = GameMode.CPU
        performSegue(withIdentifier: "toGameView", sender: self)
    }
}

