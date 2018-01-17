//
//  Board.swift
//  MindSweeper
//
//  Created by Oscar on 1/17/18.
//  Copyright © 2018 UGames. All rights reserved.
//

import Foundation

class Board {
    let size:Int
    var squares:[[Square]] = [] // a 2d array of square cells, indexed by [row][col]
    
    init(size:Int) {
        self.size = size
        for row in 0 ..< size {
            var squareRow:[Square] = []
            for col in 0 ..< size {
                let square = Square(row: row, col: col)
                squareRow.append(square)
            }
            squares.append(squareRow)
        }
    }
    
    func calculateMineLocationForSquare(square: Square) {
        square.isMineLocation = ((arc4random()%10) == 0) // 1 in 10 chance that this square is True for mine location
    }
    
    func getTileAtLocation(row: Int, col: Int) -> Square? {
        if row >= 0 && row < self.size && col >= 0 && col < self.size {
            return squares[row][col]
        } else {
            return nil
        }
    }
    
    func getNeighbouringSquares(square: Square) -> [Square] {
        var neighbours:[Square] = []
        // an array of tuples containing the relative position of each neighbour to the square
        let adjacentOffsets =
            [(-1,-1), (0, -1), (1, -1),
             (-1, 0), (1, 0),
             (-1, -1), (0, 1), (1, 1)]
        for (rowOffset, colOffset) in adjacentOffsets {
            // getTileAtLocation might return square or nil, so use optional datatype of "?"
            let optionalNeighbour:Square? = getTileAtLocation(row: square.row+rowOffset, col: square.col+colOffset)
            // only evaluates true if the optional tile isn't nil
            if let neighbour = optionalNeighbour {
                neighbours.append(neighbour)
            }
        }
        return neighbours
    }
    
    func calculateNumNeighbourMinesForSquare(square: Square) {
        // first get list of adjacent squares
        let neighbours = getNeighbouringSquares(square: square)
        var numNeighbouringMines = 0
        // for each neighbour with mine, num++
        for neighbourSquare in neighbours {
            if neighbourSquare.isMineLocation {
                numNeighbouringMines += 1
            }
        }
        square.numNeighbouringMines = numNeighbouringMines
    }
    
    // Call this method everytime we start a new game
    func resetBoard() {
        // assign mines to squares
        for row in 0 ..< size {
            for col in 0 ..< size {
                squares[row][col].isRevealed = false
                self.calculateMineLocationForSquare(square: squares[row][col])
            }
        }
        
        for row in 0 ..< size {
            for col in 0 ..< size {
                self.calculateNumNeighbourMinesForSquare(square: squares[row][col])
            }
        }
    }
}
