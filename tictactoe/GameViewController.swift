//
//  GameViewController.swift
//  tictactoe
//
//  Created by Sergio P. on 7/18/19.
//  Copyright © 2019 Sergio P. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    var mode:GameMode = GameMode.PVP
    
    @IBOutlet weak var modeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        switch mode {
        case .PVP:
            modeLabel.text = "PVP Selected"
        case .CPU:
            modeLabel.text = "CPU Selected"
        }
    }
    
    func initGameMode(from selectedMode: Int) {
        
    }

}
