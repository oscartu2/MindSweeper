//
//  ViewController.swift
//  MindSweeper
//
//  Created by Oscar on 1/16/18.
//  Copyright © 2018 UGames. All rights reserved.
//
import Foundation
import UIKit

class ViewController: UIViewController {
    let BOARD_SIZE:Int = 10
    var board:Board
    var squareButtons:[SquareButton] = []
    
    @IBOutlet weak var boardView: UIView!
    @IBOutlet weak var movesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func newGamePressed() {
        print("New Game pressed")
        self.startNewGame()
    }
    
    required init(coder aDecoder: NSCoder) {
        self.board = Board(size: BOARD_SIZE)
        super.init(coder: aDecoder)!
    }
    
    @objc func squareButtonPressed(sender: SquareButton) {
        if (!sender.square.isRevealed) {
            sender.square.isRevealed = true
            sender.setTitle("\(sender.getLabelText())", for: [])
        }
        if sender.square.isMineLocation {
            self.minePressed()
        }
    }
    
    func initializeBoard() {
        for row in 0 ..< board.size {
            for col in 0 ..< board.size {
                let square = board.squares[row][col]
                let squareSize:CGFloat = self.boardView.frame.width / CGFloat(BOARD_SIZE)
                let squareMargin:CGFloat = 1.0
                let squareButton = SquareButton(squareModel: square, squareSize: squareSize, squareMargin: squareMargin)
                squareButton.setTitleColor(UIColor.darkGray, for: [])
                squareButton.addTarget(self, action: #selector(self.squareButtonPressed), for: .touchUpInside)
                self.boardView.addSubview(squareButton)
                self.squareButtons.append(squareButton)
            }
        }
    }
    
    func startNewGame() {
        self.resetBoard()
    }
    
    func minePressed() {
        // show an alert when you tap on a mine
        let alert = UIAlertController(title: "New Game", message = "You tapped on a mine.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok"))
    }
    
    func resetBoard() {
        // resets the board with new mine locations & sets isRevealed to flase for each square
        self.board.resetBoard()
        // iterates through each button and resets the text to the default value
        for squareButton in self.squareButtons {
            squareButton.setTitle("[x]", for: [])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeBoard()
        self.startNewGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

