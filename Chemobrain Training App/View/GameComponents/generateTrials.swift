//
//  generateTrials.swift
//  Chemobrain Training App
//
//  Created by Dominic Bieniewski on 9/30/21.
//


import SpriteKit
 
extension SpriteKitScene {
    
    func generateTrials(for trialStart: Int, thru trialEnd: Int) {
        
        // Create instance of trial Manager so that it can be used in response functionality
        var trialManager = TrialManager(type: trialTypes[0], trialNumber: trialTypes[0].trialNumber, coinCongruent: trialTypes[0].coinCongruent, targetBlue: trialTypes[0].targetBlue, targetRight: trialTypes[0].targetRight, flashScreen: trialTypes[0].flashScreen, flashRight: trialTypes[0].flashRight, numberOfCoins: trialTypes[0].numberOfCoins, numberOfWaves: trialTypes[0].numberOfWaves)
        // t to take place of i for delay incrementation?
        var t = 0
        // Run trial generation for blocks that can be enter for button pressses
        for i in trialStart...trialEnd {
            
            let delay: Double = Double(t) * 10 + 3.5 + 0 - 1 /// cueToInterval in place of this 0
            let cueDelay: Double = Double(t) * 10 - 1
            let coinDelay: Double = Double(t) * 10
            
            trialManager = TrialManager(type: trialTypes[i], trialNumber: trialTypes[i].trialNumber, coinCongruent: trialTypes[i].coinCongruent, targetBlue: trialTypes[i].targetBlue, targetRight: trialTypes[i].targetRight, flashScreen: trialTypes[i].flashScreen, flashRight: trialTypes[i].flashRight, numberOfCoins: trialTypes[i].numberOfCoins, numberOfWaves: trialTypes[i].numberOfWaves)
            
            
            // All of the condition possibilities for flash whole
            
            if trialManager.type.flashScreen && trialManager.type.targetRight && trialManager.type.targetBlue && trialManager.type.coinCongruent {
                // Refactor to using .wait
                
                spawnBlueCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves)
                flashBothCircles(wait: cueDelay)
                spawnRightBlueTarget(wait: delay)
                
            } else if trialManager.type.flashScreen && trialManager.type.targetRight && trialManager.type.targetBlue && !trialManager.type.coinCongruent {
                
                spawnYellowCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves)
                flashBothCircles(wait: cueDelay)
                spawnRightBlueTarget(wait: delay)
                
            } else if trialManager.type.flashScreen && trialManager.type.targetRight && !trialManager.type.targetBlue && trialManager.type.coinCongruent {
                
                spawnYellowCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves)
                flashBothCircles(wait: cueDelay)
                spawnRightYellowTarget(wait: delay)
                
            } else if trialManager.type.flashScreen && trialManager.type.targetRight && !trialManager.type.targetBlue && !trialManager.type.coinCongruent {
                
                spawnBlueCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves)
                flashBothCircles(wait: cueDelay)
                spawnRightYellowTarget(wait: delay)
                
            } else if trialManager.type.flashScreen && !trialManager.type.targetRight && trialManager.type.targetBlue && trialManager.type.coinCongruent {
                
                spawnBlueCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves)
                flashBothCircles(wait: cueDelay)
                spawnLeftBlueTarget(wait: delay)
                
            } else if trialManager.type.flashScreen && !trialManager.type.targetRight && trialManager.type.targetBlue && !trialManager.type.coinCongruent {
                
                spawnYellowCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves)
                flashBothCircles(wait: cueDelay)
                spawnLeftBlueTarget(wait: delay)
                
            } else if trialManager.type.flashScreen && !trialManager.type.targetRight && !trialManager.type.targetBlue && trialManager.type.coinCongruent {
                
                spawnYellowCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves)
                flashBothCircles(wait: cueDelay)
                spawnLeftYellowTarget(wait: delay)
                
            } else if trialManager.type.flashScreen && !trialManager.type.targetRight && !trialManager.type.targetBlue && !trialManager.type.coinCongruent {
                
                spawnBlueCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves)
                flashBothCircles(wait: cueDelay)
                spawnLeftYellowTarget(wait: delay)
                
            }
            
            // All of the condition possibilities for flash right
            
            else if trialManager.type.flashRight && trialManager.type.targetRight && trialManager.type.targetBlue && trialManager.type.coinCongruent {
                
                spawnBlueCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves)
                flashRightCircle(wait: cueDelay)
                spawnRightBlueTarget(wait: delay)
                
            } else if trialManager.type.flashRight && trialManager.type.targetRight && trialManager.type.targetBlue && !trialManager.type.coinCongruent {
                
                spawnYellowCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves)
                flashRightCircle(wait: cueDelay)
                spawnRightBlueTarget(wait: delay)
                
            } else if trialManager.type.flashRight && trialManager.type.targetRight && !trialManager.type.targetBlue && trialManager.type.coinCongruent {
                
                spawnYellowCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves)
                flashRightCircle(wait: cueDelay)
                spawnRightYellowTarget(wait: delay)
                
            } else if trialManager.type.flashRight && trialManager.type.targetRight && !trialManager.type.targetBlue && !trialManager.type.coinCongruent {
                
                spawnBlueCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves)
                flashRightCircle(wait: cueDelay)
                spawnRightYellowTarget(wait: delay)
                
            } else if trialManager.type.flashRight && !trialManager.type.targetRight && trialManager.type.targetBlue && trialManager.type.coinCongruent {
                
                spawnBlueCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves)
                flashRightCircle(wait: cueDelay)
                spawnLeftBlueTarget(wait: delay)
                
            } else if trialManager.type.flashRight && !trialManager.type.targetRight && trialManager.type.targetBlue && !trialManager.type.coinCongruent {
                
                spawnYellowCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves)
                flashRightCircle(wait: cueDelay)
                spawnLeftBlueTarget(wait: delay)
                
            } else if trialManager.type.flashRight && !trialManager.type.targetRight && !trialManager.type.targetBlue && trialManager.type.coinCongruent {
                
                spawnYellowCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves)
                flashRightCircle(wait: cueDelay)
                spawnLeftYellowTarget(wait: delay)
                
            } else if trialManager.type.flashRight && !trialManager.type.targetRight && !trialManager.type.targetBlue && !trialManager.type.coinCongruent {
                
                spawnBlueCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves)
                flashRightCircle(wait: cueDelay)
                spawnLeftYellowTarget(wait: delay)
                
            }
            
            // All of the condition possibilities for flash left
            
            else if !trialManager.type.flashRight && trialManager.type.targetRight && trialManager.type.targetBlue && trialManager.type.coinCongruent {
                
                spawnBlueCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves)
                flashLeftCircle(wait: cueDelay)
                spawnRightBlueTarget(wait: delay)
                
            } else if !trialManager.type.flashRight && trialManager.type.targetRight && trialManager.type.targetBlue && !trialManager.type.coinCongruent {
                
                spawnYellowCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves)
                flashLeftCircle(wait: cueDelay)
                spawnRightBlueTarget(wait: delay)
                
            } else if !trialManager.type.flashRight && trialManager.type.targetRight && !trialManager.type.targetBlue && trialManager.type.coinCongruent {
                
                spawnYellowCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves)
                flashLeftCircle(wait: cueDelay)
                spawnRightYellowTarget(wait: delay)
                
            } else if !trialManager.type.flashRight && trialManager.type.targetRight && !trialManager.type.targetBlue && !trialManager.type.coinCongruent {
                
                spawnBlueCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves)
                flashLeftCircle(wait: cueDelay)
                spawnRightYellowTarget(wait: delay)
                
            } else if !trialManager.type.flashRight && !trialManager.type.targetRight && trialManager.type.targetBlue && trialManager.type.coinCongruent {
                
                spawnBlueCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves)
                flashLeftCircle(wait: cueDelay)
                spawnLeftBlueTarget(wait: delay)
                
            } else if !trialManager.type.flashRight && !trialManager.type.targetRight && trialManager.type.targetBlue && !trialManager.type.coinCongruent {
                
                spawnYellowCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves)
                flashLeftCircle(wait: cueDelay)
                spawnLeftBlueTarget(wait: delay)
                
            } else if !trialManager.type.flashRight && !trialManager.type.targetRight && !trialManager.type.targetBlue && trialManager.type.coinCongruent {
                
                spawnYellowCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves)
                flashLeftCircle(wait: cueDelay)
                spawnLeftYellowTarget(wait: delay)
                
            } else if !trialManager.type.flashRight && !trialManager.type.targetRight && !trialManager.type.targetBlue && !trialManager.type.coinCongruent {
                
                spawnBlueCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves)
                flashLeftCircle(wait: cueDelay)
                spawnLeftYellowTarget(wait: delay)
            }
            
//            if trialManager.type.trialNumber == trialTypes.count {
//                DispatchQueue.main.asyncAfter(deadline: .now() + cueDelay) {
//                    // To stop gameScene and save to user defaults
//                    self.view?.isPaused = true
//                    self.dm.saveResonseTimeToUserDefaults(array: self.responseTimeArray)
//                    self.dm.saveResponseTargetToUserDefaults(stringArray: self.responseTargetArray)
//
//                    // To save the trial data to Firestore
//                    self.dm.saveAnythingAtAllToFirestore(trial: self.dm.trialNumberFireStore, responseTarget: self.responseTargetArray, responseTime: self.responseTimeArray)
//                    self.dm.trialNumberFireStore += 1
//
//
//                }
//            }
            // Increment t at the end of each loop the same as i would have been
            t += 1
            
            switch trialManager.type.trialNumber {
            case 6:
                DispatchQueue.main.asyncAfter(deadline: .now() + cueDelay + 10) {
                    // To stop gameScene and save to user defaults
                    
                    self.dm.saveResonseTimeToUserDefaults(array: self.responseTimeArray)
                    self.dm.saveResponseTargetToUserDefaults(stringArray: self.responseTargetArray)
                    
                    // To save the trial data to Firestore
                    self.dm.saveAnythingAtAllToFirestore(trial: self.dm.trialNumberFireStore, responseTarget: self.responseTargetArray, responseTime: self.responseTimeArray)
                    self.dm.trialNumberFireStore += 1
                    
//                    self.ready.name = "ready"
                    self.ready.position = CGPoint(x: 0, y: 0)
                    self.ready.zPosition = 2
                    self.ready.size = CGSize(width: 200, height: 100)
                    self.ready.alpha = 1
//                    self.ready.physicsBody?.isDynamic = false
                    self.addChild(self.ready)
                    
                    // To allow for response to target when trial sections are generated
                    self.targetResponse = false
                    self.cueFlashed = true
                }
            case 72:
                DispatchQueue.main.asyncAfter(deadline: .now() + cueDelay + 10) {
                    // To stop gameScene and save to user defaults
                    self.dm.saveResonseTimeToUserDefaults(array: self.responseTimeArray)
                    self.dm.saveResponseTargetToUserDefaults(stringArray: self.responseTargetArray)
                    
                    // To save the trial data to Firestore
                    self.dm.saveAnythingAtAllToFirestore(trial: self.dm.trialNumberFireStore, responseTarget: self.responseTargetArray, responseTime: self.responseTimeArray)
                    self.dm.trialNumberFireStore += 1
                    
                    //                    self.ready.name = "ready"
                    self.ready.position = CGPoint(x: 0, y: 0)
                    self.ready.zPosition = 2
                    self.ready.size = CGSize(width: 200, height: 100)
                    self.ready.alpha = 1
                    //                    self.ready.physicsBody?.isDynamic = false
                    self.addChild(self.ready)
                    
                    // To allow for response to target when trial sections are generated
                    self.targetResponse = false
                    self.cueFlashed = true
                }
            case 108:
                DispatchQueue.main.asyncAfter(deadline: .now() + cueDelay + 10) {
                    // To stop gameScene and save to user defaults
                    
                    self.dm.saveResonseTimeToUserDefaults(array: self.responseTimeArray)
                    self.dm.saveResponseTargetToUserDefaults(stringArray: self.responseTargetArray)
                    
                    // To save the trial data to Firestore
                    self.dm.saveAnythingAtAllToFirestore(trial: self.dm.trialNumberFireStore, responseTarget: self.responseTargetArray, responseTime: self.responseTimeArray)
                    self.dm.trialNumberFireStore += 1
                    
                    //                    self.ready.name = "ready"
                    self.ready.position = CGPoint(x: 0, y: 0)
                    self.ready.zPosition = 2
                    self.ready.size = CGSize(width: 200, height: 100)
                    self.ready.alpha = 1
                    //                    self.ready.physicsBody?.isDynamic = false
                    self.addChild(self.ready)
                    
                    // To allow for response to target when trial sections are generated
                    self.targetResponse = false
                    self.cueFlashed = true
                }
            case 144:
                DispatchQueue.main.asyncAfter(deadline: .now() + cueDelay + 10) {
                    // To stop gameScene and save to user defaults
                    self.dm.saveResonseTimeToUserDefaults(array: self.responseTimeArray)
                    self.dm.saveResponseTargetToUserDefaults(stringArray: self.responseTargetArray)
                    
                    // To save the trial data to Firestore
                    self.dm.saveAnythingAtAllToFirestore(trial: self.dm.trialNumberFireStore, responseTarget: self.responseTargetArray, responseTime: self.responseTimeArray)
                    self.dm.trialNumberFireStore += 1
                    
                    //MARK: - Code to show level completion animations
                    
                }
            default:
                print(trialManager.type.trialNumber)
            }
        }
    }
}
