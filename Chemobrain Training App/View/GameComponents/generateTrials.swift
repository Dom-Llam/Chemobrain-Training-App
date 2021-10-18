//
//  generateTrials.swift
//  Chemobrain Training App
//
//  Created by Dominic Bieniewski on 9/30/21.
//


import SpriteKit
 
extension SpriteKitScene {
    
    func generateTrials(readyCounter: Int) {
        // Create instance of trial Manager for run generation
        var trialManager = TrialManager(type: trialTypes[0], trialNumber: trialTypes[0].trialNumber, coinCongruent: trialTypes[0].coinCongruent, targetBlue: trialTypes[0].targetBlue, targetRight: trialTypes[0].targetRight, flashScreen: trialTypes[0].flashScreen, flashRight: trialTypes[0].flashRight, numberOfCoins: trialTypes[0].numberOfCoins, numberOfWaves: trialTypes[0].numberOfWaves, waveSpacer: trialTypes[0].waveSpacer, cueToInterval: trialTypes[0].cueToInterval, trialsPerBlock: trialTypes[0].trialsPerBlock)
        
        // t to take place of i for delay incrementation
        var t = 0
        
        // Trial start and end segments based on trialsPerBlock
        var trialStart = 0
        var trialEnd = 0
        
        // To generate the blocks to be ran based on trialsPerBlock
        if trialManager.type.trialsPerBlock == 24 {
            switch readyCounter {
            case 1:
                trialStart = 0
                trialEnd = 23
            case 2:
                trialStart = 24
                trialEnd = 47
            case 3:
                trialStart = 48
                trialEnd = 71
            case 4:
                trialStart = 72
                trialEnd = 95
            case 5:
                trialStart = 96
                trialEnd = 119
            case 6:
                trialStart = 120
                trialEnd = 143
            default:
                trialStart = 0
                trialEnd = 0
            }
        } else if trialManager.type.trialsPerBlock == 16 {
            switch readyCounter {
            case 1:
                trialStart = 0
                trialEnd = 15
            case 2:
                trialStart = 16
                trialEnd = 31
            case 3:
                trialStart = 32
                trialEnd = 47
            case 4:
                trialStart = 48
                trialEnd = 63
            case 5:
                trialStart = 64
                trialEnd = 79
            case 6:
                trialStart = 80
                trialEnd = 95
            case 7:
                trialStart = 96
                trialEnd = 111
            case 8:
                trialStart = 112
                trialEnd = 127
            case 9:
                trialStart = 128
                trialEnd = 143
            default:
                trialStart = 0
                trialEnd = 0
            }
        } else if trialManager.type.trialsPerBlock == 18 {
            switch readyCounter {
            case 1:
                trialStart = 0
                trialEnd = 17
            case 2:
                trialStart = 18
                trialEnd = 35
            case 3:
                trialStart = 36
                trialEnd = 53
            case 4:
                trialStart = 54
                trialEnd = 71
            case 5:
                trialStart = 72
                trialEnd = 89
            case 6:
                trialStart = 90
                trialEnd = 107
            case 7:
                trialStart = 108
                trialEnd = 125
            case 8:
                trialStart = 126
                trialEnd = 143
            default:
                trialStart = 0
                trialEnd = 0
            }
        }
        
        // Run trial generation for blocks that can be enter for button pressses
        for i in trialStart...trialEnd {

            trialManager = TrialManager(type: trialTypes[i], trialNumber: trialTypes[i].trialNumber, coinCongruent: trialTypes[i].coinCongruent, targetBlue: trialTypes[i].targetBlue, targetRight: trialTypes[i].targetRight, flashScreen: trialTypes[i].flashScreen, flashRight: trialTypes[i].flashRight, numberOfCoins: trialTypes[i].numberOfCoins, numberOfWaves: trialTypes[i].numberOfWaves, waveSpacer: trialTypes[i].waveSpacer, cueToInterval: trialTypes[i].cueToInterval, trialsPerBlock: trialTypes[i].trialsPerBlock)
            
            // the delay variables for coins/cue/target
            let delay: Double = Double(t) * 10 + 2 + trialTypes[i].cueToInterval
            let cueDelay: Double = Double(t) * 10 - 1
            let coinDelay: Double = Double(t) * 10
            
            // All of the condition possibilities for flash whole
            if trialManager.type.flashScreen && trialManager.type.targetRight && trialManager.type.targetBlue && trialManager.type.coinCongruent {
                // Refactor to using .wait
                
                spawnBlueCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves, waveSpacer: trialManager.type.waveSpacer)
                flashBothCircles(wait: cueDelay)
                spawnRightBlueTarget(wait: delay)
                
            } else if trialManager.type.flashScreen && trialManager.type.targetRight && trialManager.type.targetBlue && !trialManager.type.coinCongruent {
                
                spawnYellowCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves, waveSpacer: trialManager.type.waveSpacer)
                flashBothCircles(wait: cueDelay)
                spawnRightBlueTarget(wait: delay)
                
            } else if trialManager.type.flashScreen && trialManager.type.targetRight && !trialManager.type.targetBlue && trialManager.type.coinCongruent {
                
                spawnYellowCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves, waveSpacer: trialManager.type.waveSpacer)
                flashBothCircles(wait: cueDelay)
                spawnRightYellowTarget(wait: delay)
                
            } else if trialManager.type.flashScreen && trialManager.type.targetRight && !trialManager.type.targetBlue && !trialManager.type.coinCongruent {
                
                spawnBlueCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves, waveSpacer: trialManager.type.waveSpacer)
                flashBothCircles(wait: cueDelay)
                spawnRightYellowTarget(wait: delay)
                
            } else if trialManager.type.flashScreen && !trialManager.type.targetRight && trialManager.type.targetBlue && trialManager.type.coinCongruent {
                
                spawnBlueCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves, waveSpacer: trialManager.type.waveSpacer)
                flashBothCircles(wait: cueDelay)
                spawnLeftBlueTarget(wait: delay)
                
            } else if trialManager.type.flashScreen && !trialManager.type.targetRight && trialManager.type.targetBlue && !trialManager.type.coinCongruent {
                
                spawnYellowCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves, waveSpacer: trialManager.type.waveSpacer)
                flashBothCircles(wait: cueDelay)
                spawnLeftBlueTarget(wait: delay)
                
            } else if trialManager.type.flashScreen && !trialManager.type.targetRight && !trialManager.type.targetBlue && trialManager.type.coinCongruent {
                
                spawnYellowCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves, waveSpacer: trialManager.type.waveSpacer)
                flashBothCircles(wait: cueDelay)
                spawnLeftYellowTarget(wait: delay)
                
            } else if trialManager.type.flashScreen && !trialManager.type.targetRight && !trialManager.type.targetBlue && !trialManager.type.coinCongruent {
                
                spawnBlueCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves, waveSpacer: trialManager.type.waveSpacer)
                flashBothCircles(wait: cueDelay)
                spawnLeftYellowTarget(wait: delay)
                
            }
            
            // All of the condition possibilities for flash right
            
            else if trialManager.type.flashRight && trialManager.type.targetRight && trialManager.type.targetBlue && trialManager.type.coinCongruent {
                
                spawnBlueCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves, waveSpacer: trialManager.type.waveSpacer)
                flashRightCircle(wait: cueDelay)
                spawnRightBlueTarget(wait: delay)
                
            } else if trialManager.type.flashRight && trialManager.type.targetRight && trialManager.type.targetBlue && !trialManager.type.coinCongruent {
                
                spawnYellowCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves, waveSpacer: trialManager.type.waveSpacer)
                flashRightCircle(wait: cueDelay)
                spawnRightBlueTarget(wait: delay)
                
            } else if trialManager.type.flashRight && trialManager.type.targetRight && !trialManager.type.targetBlue && trialManager.type.coinCongruent {
                
                spawnYellowCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves, waveSpacer: trialManager.type.waveSpacer)
                flashRightCircle(wait: cueDelay)
                spawnRightYellowTarget(wait: delay)
                
            } else if trialManager.type.flashRight && trialManager.type.targetRight && !trialManager.type.targetBlue && !trialManager.type.coinCongruent {
                
                spawnBlueCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves, waveSpacer: trialManager.type.waveSpacer)
                flashRightCircle(wait: cueDelay)
                spawnRightYellowTarget(wait: delay)
                
            } else if trialManager.type.flashRight && !trialManager.type.targetRight && trialManager.type.targetBlue && trialManager.type.coinCongruent {
                
                spawnBlueCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves, waveSpacer: trialManager.type.waveSpacer)
                flashRightCircle(wait: cueDelay)
                spawnLeftBlueTarget(wait: delay)
                
            } else if trialManager.type.flashRight && !trialManager.type.targetRight && trialManager.type.targetBlue && !trialManager.type.coinCongruent {
                
                spawnYellowCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves, waveSpacer: trialManager.type.waveSpacer)
                flashRightCircle(wait: cueDelay)
                spawnLeftBlueTarget(wait: delay)
                
            } else if trialManager.type.flashRight && !trialManager.type.targetRight && !trialManager.type.targetBlue && trialManager.type.coinCongruent {
                
                spawnYellowCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves, waveSpacer: trialManager.type.waveSpacer)
                flashRightCircle(wait: cueDelay)
                spawnLeftYellowTarget(wait: delay)
                
            } else if trialManager.type.flashRight && !trialManager.type.targetRight && !trialManager.type.targetBlue && !trialManager.type.coinCongruent {
                
                spawnBlueCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves, waveSpacer: trialManager.type.waveSpacer)
                flashRightCircle(wait: cueDelay)
                spawnLeftYellowTarget(wait: delay)
                
            }
            
            // All of the condition possibilities for flash left
            
            else if !trialManager.type.flashRight && trialManager.type.targetRight && trialManager.type.targetBlue && trialManager.type.coinCongruent {
                
                spawnBlueCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves, waveSpacer: trialManager.type.waveSpacer)
                flashLeftCircle(wait: cueDelay)
                spawnRightBlueTarget(wait: delay)
                
            } else if !trialManager.type.flashRight && trialManager.type.targetRight && trialManager.type.targetBlue && !trialManager.type.coinCongruent {
                
                spawnYellowCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves, waveSpacer: trialManager.type.waveSpacer)
                flashLeftCircle(wait: cueDelay)
                spawnRightBlueTarget(wait: delay)
                
            } else if !trialManager.type.flashRight && trialManager.type.targetRight && !trialManager.type.targetBlue && trialManager.type.coinCongruent {
                
                spawnYellowCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves, waveSpacer: trialManager.type.waveSpacer)
                flashLeftCircle(wait: cueDelay)
                spawnRightYellowTarget(wait: delay)
                
            } else if !trialManager.type.flashRight && trialManager.type.targetRight && !trialManager.type.targetBlue && !trialManager.type.coinCongruent {
                
                spawnBlueCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves, waveSpacer: trialManager.type.waveSpacer)
                flashLeftCircle(wait: cueDelay)
                spawnRightYellowTarget(wait: delay)
                
            } else if !trialManager.type.flashRight && !trialManager.type.targetRight && trialManager.type.targetBlue && trialManager.type.coinCongruent {
                
                spawnBlueCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves, waveSpacer: trialManager.type.waveSpacer)
                flashLeftCircle(wait: cueDelay)
                spawnLeftBlueTarget(wait: delay)
                
            } else if !trialManager.type.flashRight && !trialManager.type.targetRight && trialManager.type.targetBlue && !trialManager.type.coinCongruent {
                
                spawnYellowCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves, waveSpacer: trialManager.type.waveSpacer)
                flashLeftCircle(wait: cueDelay)
                spawnLeftBlueTarget(wait: delay)
                
            } else if !trialManager.type.flashRight && !trialManager.type.targetRight && !trialManager.type.targetBlue && trialManager.type.coinCongruent {
                
                spawnYellowCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves, waveSpacer: trialManager.type.waveSpacer)
                flashLeftCircle(wait: cueDelay)
                spawnLeftYellowTarget(wait: delay)
                
            } else if !trialManager.type.flashRight && !trialManager.type.targetRight && !trialManager.type.targetBlue && !trialManager.type.coinCongruent {
                
                spawnBlueCoinWave(wait: coinDelay, numberOfCoins: trialManager.type.numberOfCoins, numberOfWaves: trialManager.type.numberOfWaves, waveSpacer: trialManager.type.waveSpacer)
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
            // Need to switch on trialsPerBlock here too in order to save and present ready
            if trialManager.type.trialsPerBlock == 24 {
                switch trialManager.type.trialNumber {
                case 24:
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay + 9) {
                        // To stop gameScene and save to user defaults
                        self.dm.saveResonseTimeToUserDefaults(array: self.responseTimeArray)
                        self.dm.saveResponseTargetToUserDefaults(stringArray: self.responseTargetArray)
                        
                        // To save the trial data to Firestore
                        self.dm.saveAnythingAtAllToFirestore(trial: self.dm.trialNumberFireStore, score: self.score, responseTarget: self.responseTargetArray, responseTime: self.responseTimeArray)
                        self.dm.trialNumberFireStore += 1
                        
                        // To save the JSON file for the run
                        // self.dm.jsonToString(json: )
                        
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
                case 48:
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay + 9) {
                        // To stop gameScene and save to user defaults
                        self.dm.saveResonseTimeToUserDefaults(array: self.responseTimeArray)
                        self.dm.saveResponseTargetToUserDefaults(stringArray: self.responseTargetArray)
                        
                        // To save the trial data to Firestore
                        self.dm.saveAnythingAtAllToFirestore(trial: self.dm.trialNumberFireStore, score: self.score, responseTarget: self.responseTargetArray, responseTime: self.responseTimeArray)
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
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay + 9) {
                        // To stop gameScene and save to user defaults
                        
                        self.dm.saveResonseTimeToUserDefaults(array: self.responseTimeArray)
                        self.dm.saveResponseTargetToUserDefaults(stringArray: self.responseTargetArray)
                        
                        // To save the trial data to Firestore
                        self.dm.saveAnythingAtAllToFirestore(trial: self.dm.trialNumberFireStore, score: self.score, responseTarget: self.responseTargetArray, responseTime: self.responseTimeArray)
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
                case 96:
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay + 9) {
                        // To stop gameScene and save to user defaults
                        
                        self.dm.saveResonseTimeToUserDefaults(array: self.responseTimeArray)
                        self.dm.saveResponseTargetToUserDefaults(stringArray: self.responseTargetArray)
                        
                        // To save the trial data to Firestore
                        self.dm.saveAnythingAtAllToFirestore(trial: self.dm.trialNumberFireStore, score: self.score, responseTarget: self.responseTargetArray, responseTime: self.responseTimeArray)
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
                case 120:
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay + 9) {
                        // To stop gameScene and save to user defaults
                        
                        self.dm.saveResonseTimeToUserDefaults(array: self.responseTimeArray)
                        self.dm.saveResponseTargetToUserDefaults(stringArray: self.responseTargetArray)
                        
                        // To save the trial data to Firestore
                        self.dm.saveAnythingAtAllToFirestore(trial: self.dm.trialNumberFireStore, score: self.score, responseTarget: self.responseTargetArray, responseTime: self.responseTimeArray)
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
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay + 9) {
                        // To stop gameScene and save to user defaults
                        self.dm.saveResonseTimeToUserDefaults(array: self.responseTimeArray)
                        self.dm.saveResponseTargetToUserDefaults(stringArray: self.responseTargetArray)
                        
                        // To save the trial data to Firestore
                        self.dm.saveAnythingAtAllToFirestore(trial: self.dm.trialNumberFireStore, score: self.score, responseTarget: self.responseTargetArray, responseTime: self.responseTimeArray)
                        self.dm.trialNumberFireStore += 1
                        
                        //MARK: - Code to show level completion animations
                        
                        //                    self.viewModel.gameComplete = true
                        
                    }
                default:
                    print(trialManager.type.trialNumber)
                }
            } else if trialManager.type.trialsPerBlock == 18 {
                switch trialManager.type.trialNumber {
                case 18:
                    print(self.CTIArray)
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay + 9) {
                        // To stop gameScene and save to user defaults
                        self.dm.saveResonseTimeToUserDefaults(array: self.responseTimeArray)
                        self.dm.saveResponseTargetToUserDefaults(stringArray: self.responseTargetArray)
                        
                        // To save the trial data to Firestore
                        self.dm.saveAnythingAtAllToFirestore(trial: self.dm.trialNumberFireStore, score: self.score, responseTarget: self.responseTargetArray, responseTime: self.responseTimeArray)
                        self.dm.trialNumberFireStore += 1
                        
                        // To save the JSON file for the run
                        // self.dm.jsonToString(json: )
                        
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
                case 36:
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay + 9) {
                        // To stop gameScene and save to user defaults
                        self.dm.saveResonseTimeToUserDefaults(array: self.responseTimeArray)
                        self.dm.saveResponseTargetToUserDefaults(stringArray: self.responseTargetArray)
                        
                        // To save the trial data to Firestore
                        self.dm.saveAnythingAtAllToFirestore(trial: self.dm.trialNumberFireStore, score: self.score, responseTarget: self.responseTargetArray, responseTime: self.responseTimeArray)
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
                case 54:
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay + 9) {
                        // To stop gameScene and save to user defaults
                        
                        self.dm.saveResonseTimeToUserDefaults(array: self.responseTimeArray)
                        self.dm.saveResponseTargetToUserDefaults(stringArray: self.responseTargetArray)
                        
                        // To save the trial data to Firestore
                        self.dm.saveAnythingAtAllToFirestore(trial: self.dm.trialNumberFireStore, score: self.score, responseTarget: self.responseTargetArray, responseTime: self.responseTimeArray)
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
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay + 9) {
                        // To stop gameScene and save to user defaults
                        
                        self.dm.saveResonseTimeToUserDefaults(array: self.responseTimeArray)
                        self.dm.saveResponseTargetToUserDefaults(stringArray: self.responseTargetArray)
                        
                        // To save the trial data to Firestore
                        self.dm.saveAnythingAtAllToFirestore(trial: self.dm.trialNumberFireStore, score: self.score, responseTarget: self.responseTargetArray, responseTime: self.responseTimeArray)
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
                case 90:
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay + 9) {
                        // To stop gameScene and save to user defaults
                        
                        self.dm.saveResonseTimeToUserDefaults(array: self.responseTimeArray)
                        self.dm.saveResponseTargetToUserDefaults(stringArray: self.responseTargetArray)
                        
                        // To save the trial data to Firestore
                        self.dm.saveAnythingAtAllToFirestore(trial: self.dm.trialNumberFireStore, score: self.score, responseTarget: self.responseTargetArray, responseTime: self.responseTimeArray)
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
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay + 9) {
                        // To stop gameScene and save to user defaults
                        
                        self.dm.saveResonseTimeToUserDefaults(array: self.responseTimeArray)
                        self.dm.saveResponseTargetToUserDefaults(stringArray: self.responseTargetArray)
                        
                        // To save the trial data to Firestore
                        self.dm.saveAnythingAtAllToFirestore(trial: self.dm.trialNumberFireStore, score: self.score, responseTarget: self.responseTargetArray, responseTime: self.responseTimeArray)
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
                case 126:
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay + 9) {
                        // To stop gameScene and save to user defaults
                        
                        self.dm.saveResonseTimeToUserDefaults(array: self.responseTimeArray)
                        self.dm.saveResponseTargetToUserDefaults(stringArray: self.responseTargetArray)
                        
                        // To save the trial data to Firestore
                        self.dm.saveAnythingAtAllToFirestore(trial: self.dm.trialNumberFireStore, score: self.score, responseTarget: self.responseTargetArray, responseTime: self.responseTimeArray)
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
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay + 9) {
                        // To stop gameScene and save to user defaults
                        self.dm.saveResonseTimeToUserDefaults(array: self.responseTimeArray)
                        self.dm.saveResponseTargetToUserDefaults(stringArray: self.responseTargetArray)
                        
                        // To save the trial data to Firestore
                        self.dm.saveAnythingAtAllToFirestore(trial: self.dm.trialNumberFireStore, score: self.score, responseTarget: self.responseTargetArray, responseTime: self.responseTimeArray)
                        self.dm.trialNumberFireStore += 1
                        
                        //MARK: - Code to show level completion animations
                        
                        //                    self.viewModel.gameComplete = true
                        
                    }
                default:
                    print(trialManager.type.trialNumber)
                }
            } else if trialManager.type.trialsPerBlock == 16 {
                switch trialManager.type.trialNumber {
                case 16:
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay + 9) {
                        // To stop gameScene and save to user defaults
                        self.dm.saveResonseTimeToUserDefaults(array: self.responseTimeArray)
                        self.dm.saveResponseTargetToUserDefaults(stringArray: self.responseTargetArray)
                        
                        // To save the trial data to Firestore
                        self.dm.saveAnythingAtAllToFirestore(trial: self.dm.trialNumberFireStore, score: self.score, responseTarget: self.responseTargetArray, responseTime: self.responseTimeArray)
                        self.dm.trialNumberFireStore += 1
                        
                        // To save the JSON file for the run
                        // self.dm.jsonToString(json: )
                        
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
                case 32:
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay + 9) {
                        // To stop gameScene and save to user defaults
                        self.dm.saveResonseTimeToUserDefaults(array: self.responseTimeArray)
                        self.dm.saveResponseTargetToUserDefaults(stringArray: self.responseTargetArray)
                        
                        // To save the trial data to Firestore
                        self.dm.saveAnythingAtAllToFirestore(trial: self.dm.trialNumberFireStore, score: self.score, responseTarget: self.responseTargetArray, responseTime: self.responseTimeArray)
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
                case 48:
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay + 9) {
                        // To stop gameScene and save to user defaults
                        
                        self.dm.saveResonseTimeToUserDefaults(array: self.responseTimeArray)
                        self.dm.saveResponseTargetToUserDefaults(stringArray: self.responseTargetArray)
                        
                        // To save the trial data to Firestore
                        self.dm.saveAnythingAtAllToFirestore(trial: self.dm.trialNumberFireStore, score: self.score, responseTarget: self.responseTargetArray, responseTime: self.responseTimeArray)
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
                case 64:
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay + 9) {
                        // To stop gameScene and save to user defaults
                        
                        self.dm.saveResonseTimeToUserDefaults(array: self.responseTimeArray)
                        self.dm.saveResponseTargetToUserDefaults(stringArray: self.responseTargetArray)
                        
                        // To save the trial data to Firestore
                        self.dm.saveAnythingAtAllToFirestore(trial: self.dm.trialNumberFireStore, score: self.score, responseTarget: self.responseTargetArray, responseTime: self.responseTimeArray)
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
                case 80:
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay + 9) {
                        // To stop gameScene and save to user defaults
                        
                        self.dm.saveResonseTimeToUserDefaults(array: self.responseTimeArray)
                        self.dm.saveResponseTargetToUserDefaults(stringArray: self.responseTargetArray)
                        
                        // To save the trial data to Firestore
                        self.dm.saveAnythingAtAllToFirestore(trial: self.dm.trialNumberFireStore, score: self.score, responseTarget: self.responseTargetArray, responseTime: self.responseTimeArray)
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
                case 96:
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay + 9) {
                        // To stop gameScene and save to user defaults
                        
                        self.dm.saveResonseTimeToUserDefaults(array: self.responseTimeArray)
                        self.dm.saveResponseTargetToUserDefaults(stringArray: self.responseTargetArray)
                        
                        // To save the trial data to Firestore
                        self.dm.saveAnythingAtAllToFirestore(trial: self.dm.trialNumberFireStore, score: self.score, responseTarget: self.responseTargetArray, responseTime: self.responseTimeArray)
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
                case 112:
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay + 9) {
                        // To stop gameScene and save to user defaults
                        
                        self.dm.saveResonseTimeToUserDefaults(array: self.responseTimeArray)
                        self.dm.saveResponseTargetToUserDefaults(stringArray: self.responseTargetArray)
                        
                        // To save the trial data to Firestore
                        self.dm.saveAnythingAtAllToFirestore(trial: self.dm.trialNumberFireStore, score: self.score, responseTarget: self.responseTargetArray, responseTime: self.responseTimeArray)
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
                case 128:
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay + 9) {
                        // To stop gameScene and save to user defaults
                        
                        self.dm.saveResonseTimeToUserDefaults(array: self.responseTimeArray)
                        self.dm.saveResponseTargetToUserDefaults(stringArray: self.responseTargetArray)
                        
                        // To save the trial data to Firestore
                        self.dm.saveAnythingAtAllToFirestore(trial: self.dm.trialNumberFireStore, score: self.score, responseTarget: self.responseTargetArray, responseTime: self.responseTimeArray)
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
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay + 9) {
                        // To stop gameScene and save to user defaults
                        self.dm.saveResonseTimeToUserDefaults(array: self.responseTimeArray)
                        self.dm.saveResponseTargetToUserDefaults(stringArray: self.responseTargetArray)
                        
                        // To save the trial data to Firestore
                        self.dm.saveAnythingAtAllToFirestore(trial: self.dm.trialNumberFireStore, score: self.score, responseTarget: self.responseTargetArray, responseTime: self.responseTimeArray)
                        self.dm.trialNumberFireStore += 1
                        
                        //MARK: - Code to show level completion animations
                        
                        //                    self.viewModel.gameComplete = true
                        
                    }
                default:
                    print(trialManager.type.trialNumber)
                }
            }
        }
    }
}
