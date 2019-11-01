//
//  Concentration.swift
//  Concentration
//
//  Created by Adam on 3/18/19.
//  Copyright © 2019 Adam Snyder. All rights reserved.
//


// Imports base layer for everything basiclly
import Foundation


// Model where the actual game is played
class Concentration {
    
    // Array of Card class. Initilized with no cards.
    var cards = [Card]()
    
    //Optional int that holds something if there is only a single face up card
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    var flipCount = 0
    var gameScore = 0
    var gamePenalty = -1
    
    // Function that choose card at the index of array of Card
    // If card is not matched, matchIndex constant = the value of the indexOfOneAndOnlyFaceUpCard
    // And if matchIndex does not == the same card when touched again(choose another card0
    func chooseCard(at index: Int){
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // If one and only face up card id == the second card you chose sets both cards var to true
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    gameScore += 2
                }
                // Even if card isn't matched, the card choosen needs to be face up and since there are 2 matched or unmatched cards
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
                flipCount += 1
                if cards[matchIndex].mismatch && !cards[matchIndex].isMatched {
                    gameScore += gamePenalty
                }
                if cards[index].mismatch && !cards[index].isMatched{
                    gameScore += gamePenalty
                }
                cards[matchIndex].mismatch = true
                cards[index].mismatch = true
            }
            else {
                // Flips all cards face down through for loop using countable range "indices"
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                // Flips choosen card face up and set the index value to index of only face up card
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
                flipCount += 1
            }
        }
    }
    
    // Initilizer that sets cards array with values. Accepts an int and counts from 1 to that int
    // Sets constant card to new instance of card. Due to card being a struct each time you pass
    // a card into array cards it creates a copy. Two copies of the same card with the same ID.
    // Shuffles the array.
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
}
