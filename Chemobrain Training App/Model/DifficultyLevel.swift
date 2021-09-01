//
//  difficultyLevel.swift
//  Chemobrain Training App
//
//  Created by Dominic Bieniewski on 8/28/21.
//

import SpriteKit
import SwiftUI

struct DifficultyLevel {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    // Each games current score and level and run counter
    var score: Int = 0
    var level: Int = 0
    var trialNumber: Int = 1 /// This should be incremented once per game
    
    // The best score they've had and the most recent score to use for comparisons/achievements
    var bestScore: Int = 0
    var lastScore: Int = 0
    
    
    var trainingDay: Bool = false
    
    // A dictionary to keep track the key pairs trialNumber and score
    var scoreAndTrial: Dictionary<Int,Int>
    mutating func appendScoreAndTrial (score: Int) {
        // Called at the end of the game session
        scoreAndTrial[self.trialNumber] = score
        self.trialNumber += 1
        
        // And take us back to the home screen
//        viewModel.playGame()
    }
    
    
}
