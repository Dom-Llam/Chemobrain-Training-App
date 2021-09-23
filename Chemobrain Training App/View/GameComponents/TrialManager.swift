//
//  TrialTypeClass.swift
//  Chemobrain Training App
//
//  Created by Dominic Bieniewski on 8/23/21.
//

import SpriteKit

class TrialManager {
    var type: TrialType
    
    init(type: TrialType, trialNumber: Int, coinCongruent: Bool, targetBlue: Bool, targetRight: Bool, flashScreen: Bool, flashRight: Bool, numberOfCoins: Int, numberOfWaves: Int) {
        self.type = type
        
    }
}
