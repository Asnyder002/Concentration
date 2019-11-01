//
//  Card.swift
//  Concentration
//
//  Created by Adam on 3/19/19.
//  Copyright © 2019 Adam Snyder. All rights reserved.
//

import Foundation

// Struct created to hold all information for the card.
struct Card {
    
    var isFaceUp = false
    var isMatched = false
    var mismatch = false
    var identifier: Int
    
    // Static variable that belongs to the object itself instead of new instances of the object
    static var identifierFactory = 0
    
    // Static method that gets a new ID and returns an int
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
