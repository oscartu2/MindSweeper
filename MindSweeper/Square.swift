//
//  Square.swift
//  MindSweeper
//
//  Created by Oscar on 1/17/18.
//  Copyright © 2018 UGames. All rights reserved.
//

import Foundation
class Square {
    let row:Int
    let col:Int
    
    // give these default values which we will reassign later when initializing
    var numNeighbouringMines = 0
    var isMineLocation = false
    var isRevealed = false
    
    init(row:Int, col:Int) {
        // store row and col info of square in the grid
        self.row = row
        self.col = col
    }
}
