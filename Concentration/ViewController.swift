//
//  ViewController.swift
//  Concentration
//
//  Created by Adam on 3/18/19.
//  Copyright © 2019 Adam Snyder. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Lazy variable of consentration to find out how many pairs of card there are. Doesn't initilize until called upon.
    // Counts the number of buttons in the array of buttons adds 1 for rounding purposes and divids by two.
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    lazy var gameTheme = getNewTheme(from: emojiChoices)
    
    // Adds flipcount label to the code
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet weak var gameScoreLabel: UILabel!
    
    // Collection of IU buttons
    @IBOutlet var cardButtons: [UIButton]!
    
    var emojiChoices = [["👶", "👧", "👦", "👮‍♂️", "💂‍♀️", "👨‍⚕️", "👩‍🏫", "👨‍✈️", "🧝‍♀️", "🧛‍♂️"],
                        ["😝", "😘", "😈", "😡", "🥶", "🤩", "🤓", "😎", "😇", "😀"],
                        ["🦄", "🐦", "🐽", "🐨", "🐵", "🐸", "🐰", "🐼", "🦊", "🐶"],
                        ["🍈", "🍒", "🥝", "🍇", "🍌", "🍉", "🍑", "🍎", "🍓", "🍏"],
                        ["🥊", "🏑", "🏸", "🎱", "🥏", "🎾", "⚾️", "🏈", "🏀", "⚽️"],
                        ["🇪🇭", "🏴󠁧󠁢󠁳󠁣󠁴󠁿", "🇲🇶", "🇨🇷", "🇩🇲", "🇨🇳", "🇵🇪", "🇸🇳", "🇧🇱", "🇰🇷"]]
    
    lazy var newEmojiChoices = emojiChoices
    
    // Function that oocurs when the card is touched. Sent from the user through the UI Button.
    // Adds +1 to the flip count and finds the index of sender/button pressed in the array of cardButtons.
    // Calls the consentration game method chooseCard with the arugment(Int). Then calls updateView function.
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        else {
            print("chosen card was not in cardButtons")
        }
    }
    
    @IBAction func createNewGame(_ sender: UIButton) {
        gameTheme = getNewTheme(from: emojiChoices)
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        updateViewFromModel()
    }
    
    // For loops runs through all buttons in array. Creates two new constant vars sets one to button index and one to card index.
    // If the state of the card is face up call function emoji and use white background.
    // Otherwise clear the title and if boolean "card.isMatch" is true make background clear otherwise make it orange.
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
            else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        flipCountLabel.text = "Flips: \(game.flipCount)"
        gameScoreLabel.text = "Score: \(game.gameScore)"
    }

    // Dictionary that accosiates the int with a string. Doesn't fill it with anything at this moment.
    var emoji = [Int:String]()
    
    // Function that set emoji by returning the emoji string.
    // Adds emoji as card function is called. If the card doesn't have an emoji yet and if there are emojis left in emojiChoices.
    // Uses random generator to select number between 0 - emojiChoices.count minus 1. Saves that number to random index.
    // Sets that random emoji to the index in dictonary and removes that emoji from the emoji array.
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices[gameTheme].count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices[gameTheme].count)))
            emoji[card.identifier] = emojiChoices[gameTheme].remove(at: randomIndex)
        }
        
        // Gets the int from dictionary and returns the emoji with it. If it's nil, will return question mar.
        return emoji[card.identifier] ?? "?"
    }
    
    func getNewTheme(from emojiArray: [[String]]) -> Int {
        emojiChoices = newEmojiChoices
        return Int(arc4random_uniform(UInt32(emojiChoices.count)))
    }
}

