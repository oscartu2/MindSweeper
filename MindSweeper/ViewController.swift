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
    var moves:Int = 0 {
        didSet {
            self.movesLabel.text = "Moves: \(moves)"
            self.movesLabel.sizeToFit()
        }
    }
    var timeTaken:Int = 0 {
        didSet {
            self.timeLabel.text = "Time: \(timeTaken)"
            self.timeLabel.sizeToFit()
        }
    }
    var oneSecondTimer: Timer?
    
    @IBOutlet weak var boardView: UIView!
    @IBOutlet weak var movesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func newGamePressed() {
        self.endCurrentGame()
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
            if (sender.getLabelText() == "") {
                floodFill(sender)
            }
            sender.setTitle("\(sender.getLabelText())", for: [])
            self.moves = self.moves + 1
        }
        if sender.square.isMineLocation {
            self.minePressed()
        }
    }
    
    func floodFill(sender: SquareButton) {
        if (sender.getLabelText() != "") {
            return
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
        self.timeTaken = 0
        self.moves = 0
        self.oneSecondTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.oneSecond), userInfo: nil, repeats: true)
    }
    
    @objc func oneSecond() {
        self.timeTaken = self.timeTaken + 1
    }
    
    func endCurrentGame() {
        self.oneSecondTimer!.invalidate()
        self.oneSecondTimer = nil
    }
    
    func minePressed() {
        self.endCurrentGame()
        // show an alert when you tap on a mine
        let alert = UIAlertController(title: "BOOM!", message: "You tapped on a mine.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "New Game", style: .default, handler: { action in
            self.startNewGame()
        }))
        self.present(alert, animated: true)
    }
    
    func resetBoard() {
        // resets the board with new mine locations & sets isRevealed to flase for each square
        self.board.resetBoard()
        // iterates through each button and resets the text to the default value
        for squareButton in self.squareButtons {
            squareButton.setTitle(":^)", for: [])
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

