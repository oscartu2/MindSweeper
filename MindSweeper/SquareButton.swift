//
//  SquareButton.swift
//  MindSweeper
//
//  Created by Oscar on 1/17/18.
//  Copyright © 2018 UGames. All rights reserved.
//

import Foundation
import UIKit


class SquareButton : UIButton {
    let squareSize:CGFloat
    let squareMargin:CGFloat
    var square:Square

    
    init(squareModel: Square, squareSize: CGFloat, squareMargin: CGFloat) {
        self.square = squareModel
        self.squareSize = squareSize
        self.squareMargin = squareMargin
        let x = CGFloat(self.square.col) * (squareSize + squareMargin)
        let y = CGFloat(self.square.row) * (squareSize + squareMargin)
        let squareFrame = CGRectMake(x, y, squareSize, squareSize)
        super.init(frame: squareFrame)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getLabelText() -> String {
        // check the isMineLocation and numNeighboringMines properties to determine the text to display
        if !self.square.isMineLocation {
            if self.square.numNeighbouringMines == 0 {
                // case 1 no mine and no neighbouring mines
                return ""
            } else {
                // case 2 no mine but there are neighbouring mines
                return "\(self.square.numNeighbouringMines)"
            }
        }
        // case 3 there is mine
        return "xD"
    }
}

func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
    return CGRect(x: x, y: y, width: width, height: height)
}
