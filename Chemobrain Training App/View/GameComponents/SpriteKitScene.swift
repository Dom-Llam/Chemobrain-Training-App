//
//  SpriteKitScene.swift
//  Chemobrain Training App
//
//  Created by Dominic Bieniewski on 7/26/21.
//

import SpriteKit
import Foundation
import AudioToolbox
import SwiftUI


// An Enum to track the identification of collisions/physic bodies
enum CollisionType: UInt32 {
    case player = 1
    case coin = 2
    case target = 4
    case distractorLaser = 8
}

class SpriteKitScene: SKScene, SKPhysicsContactDelegate {
    
//    GameScene().environmentObject(AppViewModel)

    // To decode the hardcoded JSON file into an array of TrialType
    let trialTypes = Bundle.main.decode([TrialType].self, from: "test-trial.json")
    
    // Create an instance of the difficulty manager
    var dl = DifficultyLevel(scoreAndTrial: [0:0])
    let dm = DataManager()
    
    @StateObject public var appViewModel = AppViewModel.shared
    
    
    // Setting up reaction time variables
    var reactionTime: Timer?
    var rt: Double = 0.0
    var targetResponse: Bool = false
    var responseTimeArray:Array<Double> = []
    var responseTargetArray:Array<String> = []
    
    // To validate right/left responses to target (ie. not record random button taps
    var cueFlashed: Bool = false
    
    // Setting up the score
    let scoreLabel = SKLabelNode(fontNamed: "Baskerville-Bold")
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    // Response variables
    var currentColor: String = ""
    var currentDirection: String = ""
    
    // Second attempt to match responses, key is an array that is appended at each iteration of [i] in dispatch for loop
    // Response count should be incremented each time that a response is tapped.
    var responseKey = [""]

    
    // Setting up images for the scene itself
    let fixedSky = SKSpriteNode(imageNamed: "fixedSky")
    let tile = SKSpriteNode(imageNamed: "tile")
    let player = SKSpriteNode(imageNamed: "player")
    let portal = SKSpriteNode(imageNamed: "gas0")
    let moveRight = SKSpriteNode(imageNamed: "move")
    let moveLeft = SKSpriteNode(imageNamed: "move")
    
    // Generates the images to be looped through as textures for portal
    let gas0 = SKTexture(imageNamed: "gas0")
    let gas1 = SKTexture(imageNamed: "gas1")
    let gas2 = SKTexture(imageNamed: "gas2")
    let gas3 = SKTexture(imageNamed: "gas3")
    let gas4 = SKTexture(imageNamed: "gas4")
    let gas5 = SKTexture(imageNamed: "gas5")
    let gas6 = SKTexture(imageNamed: "gas6")
    let gas7 = SKTexture(imageNamed: "gas7")
    let gas8 = SKTexture(imageNamed: "gas8")
    let gas9 = SKTexture(imageNamed: "gas9")
    let gas10 = SKTexture(imageNamed: "gas10")
    let gas11 = SKTexture(imageNamed: "gas11")
    let gas12 = SKTexture(imageNamed: "gas12")
    let gas13 = SKTexture(imageNamed: "gas13")
    let gas14 = SKTexture(imageNamed: "gas14")
    let gas15 = SKTexture(imageNamed: "gas15")
    let gas16 = SKTexture(imageNamed: "gas16")
    let gas17 = SKTexture(imageNamed: "gas17")
    let gas18 = SKTexture(imageNamed: "gas18")
    let gas19 = SKTexture(imageNamed: "gas19")
    let gas20 = SKTexture(imageNamed: "gas20")
    let gas21 = SKTexture(imageNamed: "gas21")
    let gas22 = SKTexture(imageNamed: "gas22")
    let gas23 = SKTexture(imageNamed: "gas23")
    let gas24 = SKTexture(imageNamed: "gas24")
    
    
    // Add targets here to make them globally available
    let rightYellowTarget = SKSpriteNode(imageNamed: "yellowSmall")
    let rightBlueTarget = SKSpriteNode(imageNamed: "blueSmall")
    let leftYellowTarget = SKSpriteNode(imageNamed: "yellowSmall")
    let leftBlueTarget = SKSpriteNode(imageNamed: "blueSmall")
    // Add cues here to make them globally available
    let leftCircle = SKShapeNode(circleOfRadius: 60)
    let rightCircle = SKShapeNode(circleOfRadius: 60)
    // For response circles
    let yellow = SKShapeNode(circleOfRadius: 55)
    let blue = SKShapeNode(circleOfRadius: 55)
    
    // ADD INVISIBLE to use in place of .removeFromParent so there is only ever one of each node.
//x
    let resetRightTarget = SKAction.move(to: CGPoint(x: 500, y: 200), duration: 0)
    let resetLeftTarget = SKAction.move(to: CGPoint(x: -500, y: 200), duration: 0)
    
    let invisible = SKAction.fadeOut(withDuration: 0)
    let visible = SKAction.fadeIn(withDuration: 0)
    let targetVisible = SKAction.fadeIn(withDuration: 0)
    
    var onlyOne: Bool = false
    var cueToInterval = 0.0
    var CTIArray: Array<Double> = []
    
    
    
    let music = SKAudioNode(fileNamed: "the-hero.mp3")
    
    // Setting up properties to control the scene
    let center: CGFloat = 0
    var moveCount = 0
    

    override func didMove(to view: SKView) {
        
        // Add targets/cues to view here once and toggle alpha throughout game
        // Right Blue
        rightBlueTarget.position = CGPoint(x: 500, y: 200)
        rightBlueTarget.size = CGSize(width: 150, height: 45)
        rightBlueTarget.zPosition = 1
        rightBlueTarget.alpha = 1
        rightBlueTarget.name = "blueTarget"

        rightBlueTarget.physicsBody = SKPhysicsBody(texture: rightBlueTarget.texture!, size: CGSize(width: 50, height: 50))
        rightBlueTarget.physicsBody?.categoryBitMask = CollisionType.target.rawValue
        rightBlueTarget.physicsBody?.contactTestBitMask = CollisionType.player.rawValue | CollisionType.coin.rawValue
        rightBlueTarget.physicsBody?.isDynamic = false
        self.addChild(rightBlueTarget)
        
        // Right Yellow
        rightYellowTarget.position = CGPoint(x: 500, y: 200)
        rightYellowTarget.size = CGSize(width: 150, height: 45)
        rightYellowTarget.zPosition = 1
        rightYellowTarget.alpha = 1
        rightYellowTarget.name = "yellowTarget"

        rightYellowTarget.physicsBody = SKPhysicsBody(texture: rightBlueTarget.texture!, size: CGSize(width: 50, height: 50))
        rightYellowTarget.physicsBody?.categoryBitMask = CollisionType.target.rawValue
        rightYellowTarget.physicsBody?.contactTestBitMask = CollisionType.player.rawValue | CollisionType.coin.rawValue
        rightYellowTarget.physicsBody?.isDynamic = false
        self.addChild(rightYellowTarget)
        
        // Left Yellow
        leftYellowTarget.position = CGPoint(x: 500, y: 200)
        leftYellowTarget.size = CGSize(width: 150, height: 45)
        leftYellowTarget.zPosition = 1
        leftYellowTarget.alpha = 1
        leftYellowTarget.name = "yellowTarget"

        leftYellowTarget.physicsBody = SKPhysicsBody(texture: rightBlueTarget.texture!, size: CGSize(width: 50, height: 50))
        leftYellowTarget.physicsBody?.categoryBitMask = CollisionType.target.rawValue
        leftYellowTarget.physicsBody?.contactTestBitMask = CollisionType.player.rawValue | CollisionType.coin.rawValue
        leftYellowTarget.physicsBody?.isDynamic = false
        self.addChild(leftYellowTarget)
        
        // Left Blue
        leftBlueTarget.position = CGPoint(x: 500, y: 200)
        leftBlueTarget.size = CGSize(width: 150, height: 45)
        leftBlueTarget.zPosition = 1
        leftBlueTarget.alpha = 1
        leftBlueTarget.name = "blueTarget"

        leftBlueTarget.physicsBody = SKPhysicsBody(texture: rightBlueTarget.texture!, size: CGSize(width: 50, height: 50))
        leftBlueTarget.physicsBody?.categoryBitMask = CollisionType.target.rawValue
        leftBlueTarget.physicsBody?.contactTestBitMask = CollisionType.player.rawValue | CollisionType.coin.rawValue
        leftBlueTarget.physicsBody?.isDynamic = false
        self.addChild(leftBlueTarget)
        
        // leftCircle Cue
        leftCircle.position = CGPoint(x: -403, y: 100)
        leftCircle.name = "leftRedCircle"
        leftCircle.strokeColor = SKColor.red
        leftCircle.glowWidth = 10.0
        leftCircle.fillColor = SKColor.red
        leftCircle.physicsBody?.isDynamic = false
        leftCircle.zPosition = 1
        leftCircle.alpha = 0
        self.addChild(leftCircle)
        
        // rightCircle Cue
        rightCircle.position = CGPoint(x: 403, y: 100)
        rightCircle.name = "rightRedCircle"
        rightCircle.strokeColor = SKColor.red
        rightCircle.glowWidth = 10.0
        rightCircle.fillColor = SKColor.red
        rightCircle.physicsBody?.isDynamic = false
        rightCircle.zPosition = 1
        rightCircle.alpha = 0
        self.addChild(rightCircle)
        
        // Yellow response circle on left side
        yellow.position = CGPoint(x: -325, y: -350)
        yellow.name = "yellow"
        yellow.lineWidth = 6
        yellow.strokeColor = SKColor.black
        yellow.glowWidth = 10.0
        yellow.fillColor = SKColor.yellow
        yellow.physicsBody?.isDynamic = false
        yellow.zPosition = 1
        yellow.alpha = 1
        self.addChild(yellow)
        // The same for blue on right
        blue.position = CGPoint(x: 325, y: -350)
        blue.name = "blue"
        blue.lineWidth = 6
        blue.strokeColor = SKColor.black
        blue.glowWidth = 10.0
        blue.fillColor = SKColor.blue
        blue.physicsBody?.isDynamic = false
        blue.zPosition = 1
        blue.alpha = 1
        self.addChild(blue)
        
        // Create instance of trial Manager so that it can be used in response functionality
        var trialManager = TrialManager(type: trialTypes[0], trialNumber: trialTypes[0].trialNumber, coinCongruent: trialTypes[0].coinCongruent, targetBlue: trialTypes[0].targetBlue, targetRight: trialTypes[0].targetRight, flashScreen: trialTypes[0].flashScreen, flashRight: trialTypes[0].flashRight, numberOfCoins: trialTypes[0].numberOfCoins, numberOfWaves: trialTypes[0].numberOfWaves)
        
        // Simply leave after two models
       
            DispatchQueue.main.asyncAfter(deadline: .now() + 120) {
                self.dl.appendScoreAndTrial(score: self.score)
            }
        
        
        //Set up scene here
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        physicsWorld.contactDelegate = self
        addChild(music)
        
        // For score
        scoreLabel.fontColor = UIColor.white.withAlphaComponent(0.5)
        scoreLabel.position = CGPoint(x: 310, y: 450)
        scoreLabel.zPosition = 2
        addChild(scoreLabel)
        score = 0
        
        // Add starfields - can create a siwtch on theme Enum? to switch which type of particle emitter for space, water, etc.
        if let particles = SKEmitterNode(fileNamed: "Starfield") {
            particles.position = CGPoint(x: 0, y: 1080)
            particles.zPosition = -1
            particles.advanceSimulationTime(60)
            addChild(particles)
        }
        // Adds the energy sparks around the central portal
        if let particles = SKEmitterNode(fileNamed: "PortalSparks") {
            particles.position = CGPoint(x: 0, y: 300)
            particles.zPosition = 1
            particles.advanceSimulationTime(60)
            addChild(particles)
        }
        // Adds the player engine blaster
        if let particles = SKEmitterNode(fileNamed: "PlayerEngine") {
            particles.targetNode = player
            particles.zPosition = -1
            
            particles.position = CGPoint(x: 0, y: 50)
            player.addChild(particles)
        }
        

        // Setting up the animation components for the portal
        let portalArray = [gas0, gas1, gas2, gas3, gas4, gas5, gas6, gas7, gas8, gas9, gas10, gas11, gas12, gas13, gas14, gas15, gas16, gas17, gas18, gas19, gas20, gas21, gas22, gas23, gas24]
        let portalAnim = SKAction.animate(with: portalArray, timePerFrame: 0.175)
        let portalForever = SKAction.repeatForever(portalAnim)
        
        // Initiating the portal
        portal.name = "portal"
        portal.position = CGPoint(x: 0, y: 300)
        portal.size.height = 450
        portal.size.width = 450
        portal.run(portalForever)
        portal.zPosition = 2
        addChild(portal)
        
        // For the movement buttons
        moveRight.name = "moveRight"
        moveRight.position = CGPoint(x: 325, y: -475)
        moveRight.size = CGSize(width: moveRight.frame.width, height: moveRight.frame.height)
        moveRight.zPosition = 2
        addChild(moveRight)
        
        moveLeft.name = "moveLeft"
        moveLeft.position = CGPoint(x: -325, y: -475)
        moveLeft.size = CGSize(width: moveLeft.frame.width, height: moveLeft.frame.height)
        moveLeft.zPosition = 2
        addChild(moveLeft)
        
        // Initiating the player
        player.name = "player"
        player.position.y = frame.minY + 150
        player.position.x = 0
        player.zPosition = 2
        player.size = CGSize(width: 100, height: 100)
        player.zRotation = .pi / 1
        //Adding physics body to allow collisions with coins and obstacles and distractor laser
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.texture!.size())
        player.physicsBody?.categoryBitMask = CollisionType.player.rawValue
        player.physicsBody?.collisionBitMask = CollisionType.coin.rawValue | CollisionType.target.rawValue | CollisionType.distractorLaser.rawValue
        player.physicsBody?.contactTestBitMask = CollisionType.coin.rawValue | CollisionType.target.rawValue | CollisionType.distractorLaser.rawValue
        player.physicsBody?.isDynamic = false
        addChild(player)
        
        //Place sky
        fixedSky.name = "sky"
        fixedSky.size = CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.height)!)
        fixedSky.zPosition = -2

        addChild(fixedSky)
        
        
        
        for i in 0...35 {
            
            let delay: Double = Double(i) * 10 + 3.5 + 1
            let cueDelay: Double = Double(i) * 10
            let coinDelay: Double = Double(i) * 10

            trialManager = TrialManager(type: trialTypes[i], trialNumber: trialTypes[i].trialNumber, coinCongruent: trialTypes[i].coinCongruent, targetBlue: trialTypes[i].targetBlue, targetRight: trialTypes[i].targetRight, flashScreen: trialTypes[i].flashScreen, flashRight: trialTypes[i].flashRight, numberOfCoins: trialTypes[i].numberOfCoins, numberOfWaves: trialTypes[i].numberOfWaves)
            
            
            if trialManager.type.targetRight == true && trialManager.type.targetBlue == true {
                responseKey.append("rightBlue")
            } else if trialManager.type.targetRight == true && trialManager.type.targetBlue == false {
                responseKey.append("rightYellow")
            } else if trialManager.type.targetRight == false && trialManager.type.targetBlue == true {
                responseKey.append("leftBlue")
            } else if trialManager.type.targetRight == false && trialManager.type.targetBlue == false {
                responseKey.append("leftYellow")
            }

            func printStats() {
                print("Trial: \(trialManager.type.trialNumber)")
                print("FlashRight: \(trialManager.type.flashRight)")
                print("TargetRight: \(trialManager.type.targetRight)")
                print("TargetBlue: \(trialManager.type.targetBlue)")
                print("CoinCongruent: \(trialManager.type.coinCongruent)")
                print("FlashScreen: \(trialManager.type.flashScreen)")
                print("CurrentDirect: \(currentDirection)")
                print("CurrentColor: \(currentColor)")
                print(responseKey[i + 1])
            }

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
            
            if trialManager.type.trialNumber == 24 {
                DispatchQueue.main.asyncAfter(deadline: .now() + cueDelay + 30) {
                    // To stop gameScene and save to user defaults
                    self.view?.isPaused = true
                    self.dm.saveResonseTimeToUserDefaults(array: self.responseTimeArray)
                    self.dm.saveResponseTargetToUserDefaults(stringArray: self.responseTargetArray)
                    
                    // To save the trial data to Firestore
                    self.dm.saveAnythingAtAllToFirestore(trial: self.dm.trialNumberFireStore, responseTarget: self.responseTargetArray, responseTime: self.responseTimeArray)
                    self.dm.trialNumberFireStore += 1
                    
                    
                }
            }
        }
    }
    
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        // Make sure both nodes in contact exist and are still a part of our game scene
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        let sortedNodes = [nodeA, nodeB].sorted { $0.name ?? "" < $1.name ?? "" }
        let firstNode = sortedNodes[0]
        let secondNode = sortedNodes[1]
        
        if secondNode.name == "player" {
            run(SKAction.playSoundFileNamed("score.wav", waitForCompletion: false))
            firstNode.removeFromParent()

            score += 1
        } else if secondNode.name == "rightTarget" {

            firstNode.removeFromParent()
            run(SKAction.playSoundFileNamed("confirmation_002.wav", waitForCompletion: false))
            
            score += 5
        } else if secondNode.name == "leftTarget" {

            firstNode.removeFromParent()
            run(SKAction.playSoundFileNamed("confirmation_002.wav", waitForCompletion: false))
            
            score += 5
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //To capture the first touch on screen - more to come
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let node: SKNode = self.atPoint(location)
        
        // Touch either directional nodes and mark response to target
        if cueFlashed == true {
            let resetRight = SKAction.sequence([resetRightTarget, targetVisible])
            let resetLeft = SKAction.sequence([resetLeftTarget, targetVisible])
            
            let sequenceRight = SKAction.sequence([invisible, resetRight])
            let sequenceLeft = SKAction.sequence([invisible, resetLeft])
            
            if node.name == "yellow" {
                
                if intersects(rightYellowTarget) || intersects(leftYellowTarget) {
                    score += 100
                    if intersects(rightYellowTarget) {
                        // The action to stop it and move it to player
                        let moveToPlayer = SKAction.move(to: player.position, duration: 1)
                        let sequence = SKAction.sequence([moveToPlayer, invisible, resetRightTarget])
                        rightYellowTarget.run(sequence)
                    } else if intersects(leftYellowTarget) {
                        // The action to stop it and move it to player
                        let moveToPlayer = SKAction.move(to: player.position, duration: 1)
                        let sequence = SKAction.sequence([moveToPlayer, invisible, resetLeftTarget])
                        leftYellowTarget.run(sequence)
                    }
                    run(SKAction.playSoundFileNamed("upgrade1.wav", waitForCompletion: false))
                    
                    self.responseTargetArray.append(node.name!)
                    targetResponse = true
                    cueFlashed = false
                    
                    let newResponse = rt
                    print("newResponse(rt) from correct answer: \(rt)")
                    self.responseTimeArray.append(newResponse)
                                        
                } else if intersects(leftBlueTarget) || intersects(rightBlueTarget) {
                    // what happens if the response does not match
                    // The ship explodes with sound
                    
                    if intersects(rightBlueTarget) {
                        if let particles = SKEmitterNode(fileNamed: "Explosion") {
                            particles.position = rightBlueTarget.position
                            particles.zPosition = 2
                            
                            addChild(particles)
                            rightBlueTarget.run(sequenceRight)
                        }
                    } else if intersects(leftBlueTarget) {
                        if let particles = SKEmitterNode(fileNamed: "Explosion") {
                            particles.position = leftBlueTarget.position
                            particles.zPosition = 2
                            
                            addChild(particles)
                            leftBlueTarget.run(sequenceLeft)
                        }
                    }
                    
                    run(SKAction.playSoundFileNamed("explosion1.wav", waitForCompletion: false))
                    // Vibrate the device
                    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
                    
                    // Still need to append and change response parameters if they get the wrong answer
                    self.responseTargetArray.append(node.name!)
                    targetResponse = true
                    cueFlashed = false
                    
                    let newResponse = rt
                    print("New response time from incorrect response: \(rt)")
                    
                    self.responseTimeArray.append(newResponse)
                    // Either way the timer needs to be invalidated
                }
                
                
                
                
            } else if node.name == "blue" {
                
                if intersects(rightBlueTarget) || intersects(leftBlueTarget) {
                    score += 100
                    if intersects(rightBlueTarget) {
                        // The action to stop it and move it to player
                        let moveToPlayer = SKAction.move(to: player.position, duration: 1)
                        let sequence = SKAction.sequence([moveToPlayer, invisible, resetRightTarget])
                        rightBlueTarget.run(sequence)
                    } else if intersects(leftBlueTarget) {
                        // The action to stop it and move it to player
                        let moveToPlayer = SKAction.move(to: player.position, duration: 1)
                        let sequence = SKAction.sequence([moveToPlayer, invisible, resetLeftTarget])
                        leftBlueTarget.run(sequence)
                    }
                    run(SKAction.playSoundFileNamed("upgrade1.wav", waitForCompletion: false))
                    
                    
                    self.responseTargetArray.append(node.name!)
                    targetResponse = true
                    cueFlashed = false
                    
                    let newResponse = rt
                    print("newResponse from correct answer: \(rt)")
                    
                    self.responseTimeArray.append(newResponse)
                    

                } else if intersects(leftYellowTarget) || intersects(rightYellowTarget) {
                    // what happens if the response does not match
                    // The ship explodes with sound
                    if intersects(leftYellowTarget) {
                        if let particles = SKEmitterNode(fileNamed: "Explosion") {
                            particles.position = leftYellowTarget.position
                            particles.zPosition = 2
                            
                            addChild(particles)
                            leftYellowTarget.run(sequenceLeft)
                        }
                    } else if intersects(rightYellowTarget) {
                        if let particles = SKEmitterNode(fileNamed: "Explosion") {
                            particles.position = rightYellowTarget.position
                            particles.zPosition = 2

                            addChild(particles)
                            rightYellowTarget.run(sequenceRight)
                        }
                    }
                    run(SKAction.playSoundFileNamed("explosion1.wav", waitForCompletion: false))
                    // Vibrate the device
                    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
                    
                    // Still need to append and change response parameters if they get the wrong answer
                    self.responseTargetArray.append(node.name!)
                    targetResponse = true
                    cueFlashed = false
                    
                    let newResponse = rt
                    print("New response time from incorrect answer: \(rt)")
                    
                    self.responseTimeArray.append(newResponse)
                    // Either way the timer needs to be invalidated
                    
                }
                
            }
            
        }
        
        // Touch movement pads to move left or right
        if node.name == "moveRight" {
            guard moveCount != 1 else { return }
            let moveRight = SKAction.moveBy(x: +163, y: 0, duration: 0.5)
            player.run(moveRight)
            moveCount += 1
        } else if node.name == "moveLeft" {
            guard moveCount != -1 else { return }
            moveCount -= 1
            let moveLeft = SKAction.moveBy(x: -163, y: 0, duration: 0.5)
            player.run(moveLeft)
        }
        // Touch anywhere on the screen left/right of center line and player moves
//        if location.x < center {
//            guard moveCount != -1 else { return }
//            moveCount -= 1
//            let moveLeft = SKAction.moveBy(x: -163, y: 0, duration: 0.5)
//            player.run(moveLeft)
//        } else {
//
//            guard moveCount != 1 else { return }
//            let moveRight = SKAction.moveBy(x: +163, y: 0, duration: 0.5)
//            player.run(moveRight)
//            moveCount += 1
//
//        }
    }
    
    // Var to tally to only allow one timer until response
    
    
    override func update(_ currentTime: TimeInterval) {
        //This is called before each frame is rendered
        if dl.trainingDay == true {
//            AppViewModel.shared.exitView = true
//            print("ExitView activated in update.")
            
            // Try just gameScene
//            appViewModel.playGame()
//            print(".playGame toggled. AppViewModel.playGame: \(appViewModel.playGame())")
        }
        // First attempt at updating screen if target is flying towards player, how to update path accurately
        if leftCircle.alpha == 1 || rightCircle.alpha == 1 {
            cueFlashed = true
            
            if onlyOne == true {
                rt = 0
                reactionTime?.invalidate()
                
                
            reactionTime = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(reactToTarget), userInfo: nil, repeats: true)
            onlyOne = false
            
                // Maybe find a way to put an incrementer somewhere like here - happens once per trial/user action independent.
            }
        }
//        if cueFlashed == true && intersects(rightBlueTarget) {
//            let captured = cueToInterval
//            print("captured = \(captured)")
//            CTIArray.append(captured)
//            intervalTimer?.invalidate()
//            cueToInterval = 0
//        } else if cueFlashed == true && intersects(rightYellowTarget) {
//            let captured = cueToInterval
//            print("captured = \(captured)")
//
//            CTIArray.append(captured)
//            intervalTimer?.invalidate()
//            cueToInterval = 0
//        } else if cueFlashed == true && intersects(leftBlueTarget) {
//            let captured = cueToInterval
//            print("captured = \(captured)")
//
//            CTIArray.append(captured)
//            intervalTimer?.invalidate()
//            cueToInterval = 0
//        } else if cueFlashed == true && intersects(leftYellowTarget) {
//            let captured = cueToInterval
//            print("captured = \(captured)")
//
//            CTIArray.append(captured)
//            intervalTimer?.invalidate()
//            cueToInterval = 0
//        }
    }

    
    @objc func reactToInterval() {
        if cueFlashed == true {
            cueToInterval += 0.1
        }
    }
    
    @objc func reactToTarget() {
        if targetResponse == false {
            rt += 0.1
        } else if targetResponse == true {
            
        }
    }
    
    func checkPhysics() {

    // Create an array of all the nodes with physicsBodies
    var physicsNodes = [SKNode]()

    //Get all physics bodies
        enumerateChildNodes(withName: "//.") { node, _ in
        if let _ = node.physicsBody {
            physicsNodes.append(node)
        } else {
            print("\(node.name) does not have a physics body so cannot collide or be involved in contacts.")
        }
    }

    //For each node, check it's category against every other node's collion and contctTest bit mask
    for node in physicsNodes {
        let category = node.physicsBody!.categoryBitMask
        // Identify the node by its category if the name is blank
        let name = node.name != nil ? node.name : "Category \(category)"
        let collisionMask = node.physicsBody!.collisionBitMask
        let contactMask = node.physicsBody!.contactTestBitMask

        // If all bits of the collisonmask set, just say it collides with everything.
        if collisionMask == UInt32.max {
            print("\(name) collides with everything")
        }

        for otherNode in physicsNodes {
            if (node != otherNode) && (node.physicsBody?.isDynamic == true) {
                let otherCategory = otherNode.physicsBody!.categoryBitMask
                // Identify the node by its category if the name is blank
                let otherName = otherNode.name != nil ? otherNode.name : "Category \(otherCategory)"

                // If the collisonmask and category match, they will collide
                if ((collisionMask & otherCategory) != 0) && (collisionMask != UInt32.max) {
                    print("\(name) collides with \(otherName)")
                }
                // If the contactMAsk and category match, they will contact
                if (contactMask & otherCategory) != 0 {print("\(name) notifies when contacting \(otherName)")}
            }
        }
    }
    }
    

  
    func moveCoins() {
        //First attempt at making lanes move
        self.enumerateChildNodes(withName: "redResources", using: ({
        (node, error) in
            
        
            for _ in 1...16 {

                let moveCoin = SKAction.moveBy(x: 0, y: -0.5, duration: 0.75)
                node.run(moveCoin)
            }
            if node.position.y < -((self.scene?.size.height)!) {
                
                node.position.y = 300
            }
        }))
    }
    

}

