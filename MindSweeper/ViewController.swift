//
//  ViewController.swift
//  MindSweeper
//
//  Created by Oscar on 1/16/18.
//  Copyright © 2018 UGames. All rights reserved.
//

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
    }
    
    required init(coder aDecoder: NSCoder) {
        self.board = Board(size: BOARD_SIZE)
        super.init(coder: aDecoder)
    }
    
    func squareButtonPressed(sender: SquareButton) {
        print("Pressed row:\(sender.square.row), col:\(sender.square.col)")
        sender.setTitle("", forState: .Normal)
    }
    
    func initializeBoard() {
        for row in 0 ..< board.size {
            for col in 0 ..< board.size {
                let square = board.squares[row][col]
                let squareSize:CGFloat = self.boardView.frame.width / CGFloat(BOARD_SIZE)
                let squareButton = SquareButton(squareModel: square, squareSize: squareSize)
                squareButton.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
                squareButton.addTarget(self, action: "squareButtonPressed:", forControlEvents: .TouchUpInside)
                self.boardView.addSubview(view: squareButton)
                self.squareButtons.append(squareButton)
            }
        }
    }
    
    func startNewGame() {
        self.resetBoard()
    }
    
    func resetBoard() {
        // resets the board with new mine locations & sets isRevealed to flase for each square
        self.board.resetBoard()
        // iterates through each button and resets the text to the default value
        for squareButton in self.squareButtons {
            squareButton.setTitle("[x]", forState: .Normal)
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

