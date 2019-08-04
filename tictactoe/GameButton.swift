//
//  GameButton.swift
//  tictactoe
//
//  Created by Sergio P. on 8/3/19.
//  Copyright © 2019 Sergio P. All rights reserved.
//

import UIKit

class GameButton: UIButton {
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        self.layer.borderWidth = 1
        self.layer.borderColor = lineColor.cgColor
        self.layer.cornerRadius = 5
    }

}
