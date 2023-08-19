//
//  ViewController.swift
//  SetGame
//
//  Created by Саша Восколович on 06.08.2023.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Outlets for various UI elements
   
    
    // The game board view where Set cards are displayed.
    @IBOutlet weak var boardView: BorderView! {
        didSet {
            
            // Add swipe and rotation gestures to the board view.
            let swape = UISwipeGestureRecognizer(target: self, action: #selector(deal3))
            swape.direction = .down
            boardView.addGestureRecognizer(swape)
            
            let rotate = UIRotationGestureRecognizer(target: self, action: #selector(reshuffle))
            boardView.addGestureRecognizer(rotate)
        }
    }
    
    @IBOutlet weak var dealButton: BorderButton!
    
    @IBOutlet weak var newGameButton: BorderButton!
    
    @IBOutlet weak var hintButton: BorderButton!
    
    @IBOutlet weak var deckLabel: UILabel!
    
    @IBOutlet weak var infoLabel: UILabel!
   
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    // MARK: Private Variables
    private var game = SetGame()
    
    // Variables for button configurations
    private weak var timer: Timer?
    private var lastHint = 0
    private let flashTime = 1.5
   
    
    // MARK: View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromModel()
    }

    
    // MARK: Private Functions
    
    // Function to update the entire view based on the game model
    private func updateViewFromModel() {
        updateCardViewFromModel()
        updateHintButton()
        
        deckLabel.text = "Deck: \(game.deckCount)"
        scoreLabel.text = "Score: \(game.score)"
        if let result = game.isSet {
            infoLabel.text = result ? "SET" : "NOT SET"
        } else {
            infoLabel.text = ""
        }
        dealButton.isHidden = game.deckCount == 0
        hintButton.disable = game.hints.count == 0
        
    }
    
    // Update card views based on the game model.
    private func updateCardViewFromModel() {
        if boardView.cardViews.count - game.cardsOnTheTable.count > 0 {
            let cardViews = boardView.cardViews[..<game.cardsOnTheTable.count]
            boardView.cardViews = Array(cardViews)
        }
        
        let numberCardViews = boardView.cardViews.count
        
        for index in game.cardsOnTheTable.indices {
            let card = game.cardsOnTheTable[index]
            
            if index > numberCardViews - 1 {// New card
                
                let cardView = SetCardView()
                updateCardView(cardView, for: card)
                addTapGestureRecognizer(for: cardView)
                boardView.cardViews.append(cardView)// OOoo there is a new card on the game
                
            } else {
                let cardView = boardView.cardViews[index]// Just update cards, maybe selected or matched etc.
                updateCardView(cardView, for: card)
            }
        }
    }
    
    // Add a tap gesture recognizer to a card view.
    private func addTapGestureRecognizer(for cardView: SetCardView) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapedCard))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        cardView.addGestureRecognizer(tap)
    }
    
    // Handle tap gestures on card views.
    @objc private func tapedCard(recognized recognizer: UIGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            if let card = recognizer.view! as? SetCardView {
                game.chooseCard(at: boardView.cardViews.firstIndex(of: card)!)
            }
        default: break
        }
     updateViewFromModel()
    }
    
    
    // Update a card view based on the card model.
    private func updateCardView(_ view: SetCardView, for card: SetCard) {
        view.colorInt = card.color.rawValue
        view.fillInt = card.fill.rawValue
        view.symbolInt = card.shape.rawValue
        view.count = card.number.rawValue
        view.isSelected = game.selectedCards.contains(card)
        if let isItSet = game.isSet {
            if game.tryMatchedCards.contains(card) {
                view.isMatched = isItSet
            }
        } else {
            view.isMatched = nil
        }
    }
    
    
    // Function to update the hint button based on available hints
    private func updateHintButton() {
        hintButton.setTitle("\(game.hints.count) sets", for: .normal)
        lastHint = 0
    }
    
    
    // MARK: Actions
    
    // Action for dealing 3 more cards
    @IBAction func deal3() {
        game.deal3()
        updateViewFromModel()
    }
    
   // Action for requesting a hint
    @IBAction func hint() {
        timer?.invalidate()
        if game.hints.count > 0 {
            game.hints[lastHint].forEach { (idx) in
                boardView.cardViews[idx].hint()
            }
            infoLabel.text = "Set \(lastHint + 1) Wait..."
            timer = Timer.scheduledTimer(withTimeInterval: flashTime,
                                         repeats: false) { [weak self] time in
                self?.lastHint = (self?.lastHint)!.incrementCicle(in:(self?.game.hints.count)!)
                self?.infoLabel.text = ""
                self?.updateCardViewFromModel()
            }
        }
    }
    
    // Action for starting a new game
    @IBAction func newGame() {
        game = SetGame()
        boardView.cardViews.removeAll()
        updateViewFromModel()
    }
    
    // Reshuffle action.
    @objc func reshuffle(_ sender: UIGestureRecognizer) {
        switch sender.state {
        case .ended:
            game.shuffle()
            updateViewFromModel()
        default: break
      }
        
    }
}

