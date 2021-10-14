//
//  TrialType.swift
//  Chemobrain Training App
//
//  Created by Dominic Bieniewski on 8/23/21.
//

import SpriteKit

struct TrialType: Codable {
    // First level of each JSON file indicates which trial in the run to be executed
    let trialNumber: Int
    // Congruent indicates which coins to match to which satellites: true == blue coins && blue satellite etc.
    let coinCongruent: Bool
    // Target color indicates blue or yellow satellites: Blue == true, Yellow == false
    let targetBlue: Bool
    // Target Direction indicates left or right target Spawn regardless of cue: right == true, left == false (congruency comes from target to coin match/dissimilarity
    let targetRight: Bool
 
    // Flash types indicate which cue type to give
    let flashScreen: Bool
    let flashRight: Bool
    
    // For the number of coins and waves and spacer
    let numberOfCoins: Int
    let numberOfWaves: Int
    let waveSpacer: Double
    
    // fpr cueToInterval and trialsPerBlock
    let cueToInterval: Double
    let trialsPerBlock: Int
    
}
