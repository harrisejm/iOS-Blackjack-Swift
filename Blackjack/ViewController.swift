//
//  ViewController.swift
//  Blackjack
//
//  Created by Eddie Harris on 9/10/19.
//  Copyright © 2019 Eddie Harris. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var card1: UIImageView!
    @IBOutlet weak var card2: UIImageView!
    @IBOutlet weak var card3: UIImageView!
    @IBOutlet weak var card4: UIImageView!
    @IBOutlet weak var card5: UIImageView!
    @IBOutlet weak var card6: UIImageView!
    @IBOutlet weak var card7: UIImageView!
    @IBOutlet weak var card8: UIImageView!
    @IBOutlet weak var card9: UIImageView!
    
    @IBOutlet weak var dealerCard1: UIImageView!
    @IBOutlet weak var dealerCard2: UIImageView!
    @IBOutlet weak var dealerCard3: UIImageView!
    @IBOutlet weak var dealerCard4: UIImageView!
    @IBOutlet weak var dealerCard5: UIImageView!
    @IBOutlet weak var dealerCard6: UIImageView!
    @IBOutlet weak var dealerCard7: UIImageView!
    @IBOutlet weak var dealerCard8: UIImageView!
    @IBOutlet weak var dealerCard9: UIImageView!
    
    
    @IBOutlet weak var score: UILabel!
    
    @IBOutlet weak var scoreDealer: UILabel!
    
    @IBOutlet weak var gameStatus: UILabel!
    
    
    let values = Cards()
    
    var arrOfCards : [UIImageView] = []
    var arrOfDealerCards : [UIImageView] = []
    
    var cardCount = 0
    var total = 0
    var totalDealer = 0
    var aces = 0
    var playerTurn : Bool = true
    var restartButton : Bool = true
    
    func bust(_ score: Int, _ player: String) -> String {
        if score > 21 {
            playerTurn = false
            restartButton = true
            return "Bust, \(player) loses"
        } else if score == 21 {
            playerTurn = false
            restartButton = true
            return " \(player) wins"
        } else {
            return "Turn: \(player)"
        }
    }

    @IBAction func hit(_ sender: UIButton) {
        if total < 21 && playerTurn == true {
            let randomCard = Int.random(in: 1...52)
            arrOfCards[cardCount].image = UIImage(named: "card\(randomCard)")
            cardCount += 1
            let cardValue = values.cardValues[randomCard]!
            if cardValue == 11 {
                aces += 1
            }
            if aces > 0 && total + cardValue > 21 {
                total -= 10
                aces -= 1
            }
            total += cardValue
            score.text = String(total)// + " " + bust(total,"player 1")
            gameStatus.text = bust(total,"Player 1")
        }
    }
    
    @IBAction func stay(_ sender: UIButton) {
        if playerTurn == true {
            cardCount = 0
           // total = 0
            gameStatus.text = "Turn: Dealer"
            aces = 0
            playerTurn = false
            restartButton = false
            dealerDraw()
        }
    }
    
    @IBAction func continueGame(_ sender: UIButton) {
        if restartButton == true {
        for i in 0...arrOfCards.count-1 {
            arrOfCards[i].image = nil
            arrOfDealerCards[i].image = nil
        }
        total = 0
        totalDealer = 0
        cardCount = 0
        aces = 0
        score.text = "0"
        scoreDealer.text = "0"
        gameStatus.text = "Turn: Player 1"
        playerTurn = true
        restartButton = true
        }
    }
    
    func dealerDraw(){
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            
//            if self.total < 21 {
                let randomCard = Int.random(in: 1...52)
                self.arrOfDealerCards[self.cardCount].image = UIImage(named: "card\(randomCard)")
                self.cardCount += 1
          //    let cardValue = self.values.cardValues[randomCard]!
            
                var cardValue : Int
            if let test = self.values.cardValues[randomCard] {
                cardValue = test
            } else {
                cardValue = 0
            }
            
                if cardValue == 11 {
                    self.aces += 1
                }
                if self.aces > 0 && self.totalDealer + cardValue > 21 {
                    self.totalDealer -= 10
                    self.aces -= 1
                }
                self.totalDealer += cardValue
                self.scoreDealer.text = String(self.totalDealer)
                self.gameStatus.text = self.bust(self.totalDealer,"Dealer")
        //    }
            if self.totalDealer >= 17 {
                timer.invalidate()
                if self.totalDealer > self.total && self.totalDealer <= 21 {
                    self.restartButton = true
                    self.gameStatus.text = "Dealer Wins"
                    
                } else if self.totalDealer < self.total || self.totalDealer > 21 {
                    self.restartButton = true
                    self.gameStatus.text = "Player 1 wins"
                } else if self.totalDealer == self.total {
                    self.restartButton = true
                    self.gameStatus.text = "Draw"
                }
                self.playerTurn = true
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrOfCards = [card1,card2,card3,card4,card5,card6,card7,card8,card9]
        arrOfDealerCards =  [dealerCard1,dealerCard2,dealerCard3,dealerCard4,dealerCard5,dealerCard6,dealerCard7,dealerCard8,dealerCard9]
    }

}
