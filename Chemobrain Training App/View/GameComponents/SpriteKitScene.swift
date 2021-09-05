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
    @StateObject public var appViewModel = AppViewModel.shared
    
    // Create an initializer to take in the instance of appViewModel from Swiftui GameScene
//    init(viewModel: AppViewModel) {
//        self.appViewModel = viewModel
//
//        // Call on super init to avoid error
//        super.init(size: CGSize(width: 1620, height: 2160))
//    }
//
    // Setting up the timer and score
    var timer: Timer?
    var intervalTimer: Timer?
    var interval: Double = 0
    let timerLabel = SKLabelNode(fontNamed: "Baskerville-Bold")
    let scoreLabel = SKLabelNode(fontNamed: "Baskerville-Bold")
    
    var reactionTime: Timer?
    var rt: Double = 0.0
    var targetResponse: Bool = false
    var responseTimeArray:Array<Double> = []
    var responseTargetArray:Array<String> = []
    
    // To validate right/left responses to target (ie. not record random button taps
    var cueFlashed: Bool = false
    
    var countDown = 60.0 {
        didSet {
            let str = String(format: "%.2f", countDown)
            timerLabel.text = "Countdown: \(str)"
            if countDown <= 0 {
                //viewModel.playGame()
            }
        }
    }
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var currentColor: String = ""
    var currentDirection: String = ""
    // Second attempt to match responses, key is an array that is appended at each iteration of [i] in dispatch for loop
    // Response count should be incremented each time that a response is tapped.
    var responseKey = [""]
    var responseCount = 1
    
    // Setting up images for the scene itself
    let fixedSky = SKSpriteNode(imageNamed: "fixedSky")
    let tile = SKSpriteNode(imageNamed: "tile")
    let player = SKSpriteNode(imageNamed: "player")
    let portal = SKSpriteNode(imageNamed: "gas0")
    let yellowLeft = SKSpriteNode(imageNamed: "yellowLeft")
    let yellowRight = SKSpriteNode(imageNamed: "yellowRight")
    let blueLeft = SKSpriteNode(imageNamed: "blueLeft")
    let blueRight = SKSpriteNode(imageNamed: "blueRight")
    let moveRight = SKSpriteNode(imageNamed: "move")
    let moveLeft = SKSpriteNode(imageNamed: "move")
    
    // Add targets here to make them globally available
    let rightYellowTarget = SKSpriteNode(imageNamed: "yellowSmall")
    let rightBlueTarget = SKSpriteNode(imageNamed: "blueSmall")
    let leftYellowTarget = SKSpriteNode(imageNamed: "yellowSmall")
    let leftBlueTarget = SKSpriteNode(imageNamed: "blueSmall")

    let music = SKAudioNode(fileNamed: "the-hero.mp3")
    
    // Setting up properties to control the scene
    let center: CGFloat = 0
    var moveCount = 0
    
    
    var levelNumber = 0
    var waveNumber = 0
    
    let positions = Array(stride(from: -50, through: 50, by: 50))
    
    override func didMove(to view: SKView) {
        
        
        
        // Create instance of trial Manager so that it can be used in response functionality
        var trialManager = TrialManager(type: trialTypes[0], trialNumber: trialTypes[0].trialNumber, coinCongruent: trialTypes[0].coinCongruent, targetBlue: trialTypes[0].targetBlue, targetRight: trialTypes[0].targetRight, flashScreen: trialTypes[0].flashScreen, flashRight: trialTypes[0].flashRight)
        
        // Simply leave after two models
       
            DispatchQueue.main.asyncAfter(deadline: .now() + 120) {
                self.dl.appendScoreAndTrial(score: self.score)
            }
        
        
        //Set up scene here
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        physicsWorld.contactDelegate = self
        addChild(music)
        
        // For countDown
        timerLabel.fontColor = UIColor.white.withAlphaComponent(0.5)
        timerLabel.position = CGPoint(x: 250, y: 400)
        timerLabel.zPosition = 2
        addChild(timerLabel)
        countDown = 60
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(sessionCountDown), userInfo: nil, repeats: true)
        
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
        
        // For the arrow response buttons
        yellowRight.name = "yellowRight"
        yellowRight.position = CGPoint(x: 280, y: -350)
        yellowRight.size = CGSize(width: 75, height: 75)
        yellowRight.zPosition = 2
        addChild(yellowRight)
        
        yellowLeft.name = "yellowLeft"
        yellowLeft.position = CGPoint(x: -280, y: -350)
        yellowLeft.size = CGSize(width: 75, height: 75)
        yellowLeft.zPosition = 2
        addChild(yellowLeft)
        
        blueRight.name = "blueRight"
        blueRight.position = CGPoint(x: 355, y: -350)
        blueRight.size = CGSize(width: 75, height: 75)
        blueRight.zPosition = 2
        addChild(blueRight)
        
        blueLeft.name = "blueLeft"
        blueLeft.position = CGPoint(x: -355, y: -350)
        blueLeft.size = CGSize(width: 75, height: 75)
        blueLeft.zPosition = 2
        addChild(blueLeft)
        
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
            
            let delay: Double = Double(i) * 10 + 3.5
            let coinDelay: Double = Double(i) * 10
            
            
            // Create trial manager, which takes in decoded JSON file as an array of trialTypes with all the necessary parameters
            
            trialManager = TrialManager(type: trialTypes[i], trialNumber: trialTypes[i].trialNumber, coinCongruent: trialTypes[i].coinCongruent, targetBlue: trialTypes[i].targetBlue, targetRight: trialTypes[i].targetRight, flashScreen: trialTypes[i].flashScreen, flashRight: trialTypes[i].flashRight)
            
            
            if trialManager.type.targetRight == true && trialManager.type.targetBlue == true {
                responseKey.append("rightBlue")
            } else if trialManager.type.targetRight == true && trialManager.type.targetBlue == false {
                responseKey.append("rightYellow")
            } else if trialManager.type.targetRight == false && trialManager.type.targetBlue == true {
                responseKey.append("leftBlue")
            } else if trialManager.type.targetRight == false && trialManager.type.targetBlue == false {
                responseKey.append("leftYellow")
            }
            
            // Attempt to append current trial parameters for responseKey for verifying correct response later
//            responseKey.[i] = (trialManager.type.trialNumber, currentColor, currentDirection)
            
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
                printStats()
                // All of the condition possibilities for flash whole
                
                if trialManager.type.flashScreen && trialManager.type.targetRight && trialManager.type.targetBlue && trialManager.type.coinCongruent {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + coinDelay) {
                        self.spawnBlueCoinWave()
                        print("spawning blue coin wave. Trial: 1")
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                        // Invalidate so that timer is always fresh when screen is flashed
                        self.reactionTime?.invalidate()
                        self.rt = 0
                        print("ReactionTime invalidated trial 1"
                        )
                        self.cueToTargetInterval()
                        
                        // Generate wave and target
                        //self.wholeScreenFlash()
                        self.flashRightCircle()
                        self.spawnRightBlueTarget()
                        
                        // increment response Count here? So that the answer is independent of user input
                        print("Response Key with self. = \(self.responseKey[self.responseCount])")
                        
                        // Ommit first and last increment in order for order to stay correct
//                        self.responseCount += 1
//                        print("Count after increment = \(self.responseCount)")
                        
                        
                        print("Trial: 1, blue coins, right blue target.")
                        print("Hard coded: \(self.responseKey[1])")
                    }
                } else if trialManager.type.flashScreen && trialManager.type.targetRight && trialManager.type.targetBlue && !trialManager.type.coinCongruent {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + coinDelay) {
                        self.spawnYellowCoinWave()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                        self.reactionTime?.invalidate()
                        self.rt = 0
                        
                        print("Reaction time invalidated trial 2")
                        //self.wholeScreenFlash()
                        self.flashRightCircle()
                        self.spawnRightBlueTarget()
                        
                        // increment response Count here? So that the answer is independent of user input
                        print("Response Key with self.responseCount = \(self.responseKey[self.responseCount])")
                        
                        self.responseCount += 1
                        print("Count after increment = \(self.responseCount)")
                        
                        print("Trial: 2, yellow coins, right blue target.")
                        print(self.responseKey[2])
                    }
                } else if trialManager.type.flashScreen && trialManager.type.targetRight && !trialManager.type.targetBlue && trialManager.type.coinCongruent {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + coinDelay) {
                        self.spawnYellowCoinWave()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                        self.reactionTime?.invalidate()
                        self.rt = 0
                        
                        print("reaction time invalidated trial 3")
                        self.flashBothCircles()
                        self.spawnRightYellowTarget()
                        
                        // increment response Count here? So that the answer is independent of user input
                        print("Response Key with self. = \(self.responseKey[self.responseCount])")
                        
                        self.responseCount += 1
                        print("Count after increment = \(self.responseCount)")
           
                        print("Trial: 3, yellow coins, right yellow target.")
                        print(self.responseKey[3])
                    }
                } else if trialManager.type.flashScreen && trialManager.type.targetRight && !trialManager.type.targetBlue && !trialManager.type.coinCongruent {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + coinDelay) {
                        self.spawnBlueCoinWave()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                        self.reactionTime?.invalidate()
                        self.rt = 0
                        
                        print("reaction time invalidated trial 4")
                        self.flashBothCircles()
                        self.spawnRightYellowTarget()
                        
                        // increment response Count here? So that the answer is independent of user input
                        print("Response Key with self. = \(self.responseKey[self.responseCount])")
                        
                        self.responseCount += 1
                        print("Count after increment = \(self.responseCount)")
                  
                        print("Trial: 4, blue coins, right yellow target.")
                        print(self.responseKey[4])
                    }
                } else if trialManager.type.flashScreen && !trialManager.type.targetRight && trialManager.type.targetBlue && trialManager.type.coinCongruent {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + coinDelay) {
                        self.spawnBlueCoinWave()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                        self.reactionTime?.invalidate()
                        self.rt = 0
                        
                        print("reaction time invalidated trial 5")
                        self.flashLeftCircle()
                        self.spawnLeftBlueTarget()
                        
                        // increment response Count here? So that the answer is independent of user input
                        print("Response Key with self. = \(self.responseKey[self.responseCount])")
                        
                        self.responseCount += 1
                        print("Count after increment = \(self.responseCount)")
                      
                        print("Trial: 5, blue coins, left blue target.")
                        print(self.responseKey[5])
                    }
                } else if trialManager.type.flashScreen && !trialManager.type.targetRight && trialManager.type.targetBlue && !trialManager.type.coinCongruent {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + coinDelay) {
                        self.spawnYellowCoinWave()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                        self.reactionTime?.invalidate()
                        self.rt = 0
                        
                        print("reactiontime invalidated trial 6")
                        self.flashLeftCircle()
                        self.spawnLeftBlueTarget()
                        
                        // increment response Count here? So that the answer is independent of user input
                        print("Response Key with self. = \(self.responseKey[self.responseCount])")
                        
                        self.responseCount += 1
                        print("Count after increment = \(self.responseCount)")
                       
                        print("Trial: 6, yellow coins, left blue target.")
                        print(self.responseKey[6])
                    }
                } else if trialManager.type.flashScreen && !trialManager.type.targetRight && !trialManager.type.targetBlue && trialManager.type.coinCongruent {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + coinDelay) {
                        self.spawnYellowCoinWave()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                        self.reactionTime?.invalidate()
                        self.rt = 0
                        
                        print("reaction time invalidated trial 7")
                        self.wholeScreenFlash()
                        self.spawnLeftYellowTarget()
                        
                        // increment response Count here? So that the answer is independent of user input
                        print("Response Key with self. = \(self.responseKey[self.responseCount])")
                        
                        self.responseCount += 1
                        print("Count after increment = \(self.responseCount)")
                        
                        print("Trial: 7, yellow coins, left yellow target.")
                        print(self.responseKey[7])
                    }
                } else if trialManager.type.flashScreen && !trialManager.type.targetRight && !trialManager.type.targetBlue && !trialManager.type.coinCongruent {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + coinDelay) {
                        self.spawnBlueCoinWave()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                        self.reactionTime?.invalidate()
                        self.rt = 0
                        
                        self.wholeScreenFlash()
                        self.spawnLeftYellowTarget()
                        // increment response Count here? So that the answer is independent of user input
                        print("Response Key with self. = \(self.responseKey[self.responseCount])")
                        
                        self.responseCount += 1
                        print("Count after increment = \(self.responseCount)")
                         
                        print("Trial: 8, blue coins, left yellow target.")
                        print(self.responseKey[8])
                    }
                }
                
                // All of the condition possibilities for flash right
                
                else if trialManager.type.flashRight && trialManager.type.targetRight && trialManager.type.targetBlue && trialManager.type.coinCongruent {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + coinDelay) {
                        self.spawnBlueCoinWave()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                        self.reactionTime?.invalidate()
                        self.rt = 0
                        
                        self.flashRight()
                        self.spawnRightBlueTarget()
                        // increment response Count here? So that the answer is independent of user input
                        print("Response Key with self. = \(self.responseKey[self.responseCount])")
                        
                        self.responseCount += 1
                        print("Count after increment = \(self.responseCount)")
                         
                        print("Trial: 9, blue coins, right blue target. ")
                        print(self.responseKey[9])
                    }
                } else if trialManager.type.flashRight && trialManager.type.targetRight && trialManager.type.targetBlue && !trialManager.type.coinCongruent {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + coinDelay) {
                        self.spawnYellowCoinWave()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                        self.reactionTime?.invalidate()
                        self.rt = 0
                        
                        self.flashRight()
                        self.spawnRightBlueTarget()
                        // increment response Count here? So that the answer is independent of user input
                        print("Response Key with self. = \(self.responseKey[self.responseCount])")
                        
                        self.responseCount += 1
                        print("Count after increment = \(self.responseCount)")
                         
                        print("Trial: 10, yellow coins, right blue target. ")
                        print(self.responseKey[10])
                    }
                } else if trialManager.type.flashRight && trialManager.type.targetRight && !trialManager.type.targetBlue && trialManager.type.coinCongruent {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + coinDelay) {
                        self.spawnYellowCoinWave()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                        self.reactionTime?.invalidate()
                        self.rt = 0
                        
                        self.flashRight()
                        self.spawnRightYellowTarget()
                        // increment response Count here? So that the answer is independent of user input
                        print("Response Key with self. = \(self.responseKey[self.responseCount])")
                        
                        self.responseCount += 1
                        print("Count after increment = \(self.responseCount)")
                         
                        print("Trial: 11, yellow coins, right yellow target. ")
                        print(self.responseKey[11])
                    }
                } else if trialManager.type.flashRight && trialManager.type.targetRight && !trialManager.type.targetBlue && !trialManager.type.coinCongruent {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + coinDelay) {
                        self.spawnBlueCoinWave()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                        self.reactionTime?.invalidate()
                        self.rt = 0
                        
                        self.flashRight()
                        self.spawnRightYellowTarget()
                        // increment response Count here? So that the answer is independent of user input
                        print("Response Key with self. = \(self.responseKey[self.responseCount])")
                        
                        self.responseCount += 1
                        print("Count after increment = \(self.responseCount)")
                         
                        print("Trial: 12, blue coins, right yellow target. ")
                        print(self.responseKey[12])
                    }
                } else if trialManager.type.flashRight && !trialManager.type.targetRight && trialManager.type.targetBlue && trialManager.type.coinCongruent {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + coinDelay) {
                        self.spawnBlueCoinWave()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                        self.reactionTime?.invalidate()
                        self.rt = 0
                        
                        self.flashRight()
                        self.spawnLeftBlueTarget()
                        // increment response Count here? So that the answer is independent of user input
                        print("Response Key with self. = \(self.responseKey[self.responseCount])")
                        
                        self.responseCount += 1
                        print("Count after increment = \(self.responseCount)")
                         
                        print("Trial: 13, blue coins, left blue target.")
                        print(self.responseKey[13])
                    }
                } else if trialManager.type.flashRight && !trialManager.type.targetRight && trialManager.type.targetBlue && !trialManager.type.coinCongruent {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + coinDelay) {
                        self.spawnYellowCoinWave()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                        self.reactionTime?.invalidate()
                        self.rt = 0
                        
                        self.flashRight()
                        self.spawnLeftBlueTarget()
                        // increment response Count here? So that the answer is independent of user input
                        print("Response Key with self. = \(self.responseKey[self.responseCount])")
                        
                        self.responseCount += 1
                        print("Count after increment = \(self.responseCount)")
                         
                        print("Trial: 14, yellow coins, left blue target. ")
                        print(self.responseKey[14])
                    }
                } else if trialManager.type.flashRight && !trialManager.type.targetRight && !trialManager.type.targetBlue && trialManager.type.coinCongruent {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + coinDelay) {
                        self.spawnYellowCoinWave()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                        self.reactionTime?.invalidate()
                        self.rt = 0
                        
                        self.flashRight()
                        self.spawnLeftYellowTarget()
                        // increment response Count here? So that the answer is independent of user input
                        print("Response Key with self. = \(self.responseKey[self.responseCount])")
                        
                        self.responseCount += 1
                        print("Count after increment = \(self.responseCount)")
                         
                        print("Trial: 15, yellow coins, left yellow target. ")
                        print(self.responseKey[15])
                    }
                } else if trialManager.type.flashRight && !trialManager.type.targetRight && !trialManager.type.targetBlue && !trialManager.type.coinCongruent {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + coinDelay) {
                        self.spawnBlueCoinWave()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                        self.reactionTime?.invalidate()
                        self.rt = 0
                        
                        self.flashRight()
                        self.spawnLeftYellowTarget()
                        // increment response Count here? So that the answer is independent of user input
                        print("Response Key with self. = \(self.responseKey[self.responseCount])")
                        
                        self.responseCount += 1
                        print("Count after increment = \(self.responseCount)")
                         
                        print("Trial: 16, blue coins, left yellow target. ")
                        print(self.responseKey[16])
                    }
                }
                
                // All of the condition possibilities for flash left
                
                else if !trialManager.type.flashRight && trialManager.type.targetRight && trialManager.type.targetBlue && trialManager.type.coinCongruent {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + coinDelay) {
                        self.spawnBlueCoinWave()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                        self.reactionTime?.invalidate()
                        self.rt = 0
                        
                        self.flashLeft()
                        self.spawnRightBlueTarget()
                        // increment response Count here? So that the answer is independent of user input
                        print("Response Key with self. = \(self.responseKey[self.responseCount])")
                        
                        self.responseCount += 1
                        print("Count after increment = \(self.responseCount)")
                         
                        print("Trial: 17, blue coins, right blue target. ")
                        print(self.responseKey[17])
                    }
                } else if !trialManager.type.flashRight && trialManager.type.targetRight && trialManager.type.targetBlue && !trialManager.type.coinCongruent {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + coinDelay) {
                        self.spawnYellowCoinWave()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                        self.reactionTime?.invalidate()
                        self.rt = 0
                        
                        self.flashLeft()
                        self.spawnRightBlueTarget()
                        // increment response Count here? So that the answer is independent of user input
                        print("Response Key with self. = \(self.responseKey[self.responseCount])")
                        
                        self.responseCount += 1
                        print("Count after increment = \(self.responseCount)")
                         
                        print("Trial: 18, yellow coins, right blue target. ")
                        print(self.responseKey[18])
                    }
                } else if !trialManager.type.flashRight && trialManager.type.targetRight && !trialManager.type.targetBlue && trialManager.type.coinCongruent {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + coinDelay) {
                        self.spawnYellowCoinWave()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                        self.reactionTime?.invalidate()
                        self.rt = 0
                        
                        self.flashLeft()
                        self.spawnRightYellowTarget()
                        // increment response Count here? So that the answer is independent of user input
                        print("Response Key with self. = \(self.responseKey[self.responseCount])")
                        
                        self.responseCount += 1
                        print("Count after increment = \(self.responseCount)")
                         
                        print("Trial: 19, yellow coins, right yellow target. ")
                        print(self.responseKey[19])
                    }
                } else if !trialManager.type.flashRight && trialManager.type.targetRight && !trialManager.type.targetBlue && !trialManager.type.coinCongruent {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + coinDelay) {
                        self.spawnBlueCoinWave()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                        self.reactionTime?.invalidate()
                        self.rt = 0
                        
                        self.flashLeft()
                        self.spawnRightYellowTarget()
                        // increment response Count here? So that the answer is independent of user input
                        print("Response Key with self. = \(self.responseKey[self.responseCount])")
                        
                        self.responseCount += 1
                        print("Count after increment = \(self.responseCount)")
                         
                        print("Trial: 20, blue coins, right yellow target. ")
                        print(self.responseKey[20])
                    }
                } else if !trialManager.type.flashRight && !trialManager.type.targetRight && trialManager.type.targetBlue && trialManager.type.coinCongruent {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + coinDelay) {
                        self.spawnBlueCoinWave()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                        self.reactionTime?.invalidate()
                        self.rt = 0
                        
                        self.flashLeft()
                        self.spawnLeftBlueTarget()
                        // increment response Count here? So that the answer is independent of user input
                        print("Response Key with self. = \(self.responseKey[self.responseCount])")
                        
                        self.responseCount += 1
                        print("Count after increment = \(self.responseCount)")
                         
                        print("Trial: 21, blue coins, left blue target. ")
                        print(self.responseKey[21])
                    }
                } else if !trialManager.type.flashRight && !trialManager.type.targetRight && trialManager.type.targetBlue && !trialManager.type.coinCongruent {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + coinDelay) {
                        self.spawnYellowCoinWave()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                        self.reactionTime?.invalidate()
                        self.rt = 0
                        
                        self.flashLeft()
                        self.spawnLeftBlueTarget()
                        // increment response Count here? So that the answer is independent of user input
                        print("Response Key with self. = \(self.responseKey[self.responseCount])")
                        
                        self.responseCount += 1
                        print("Count after increment = \(self.responseCount)")
                         
                        print("Trial: 22, yellow coins, left blue target. ")
                        print(self.responseKey[22])
                    }
                } else if !trialManager.type.flashRight && !trialManager.type.targetRight && !trialManager.type.targetBlue && trialManager.type.coinCongruent {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + coinDelay) {
                        self.spawnYellowCoinWave()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                        self.reactionTime?.invalidate()
                        self.rt = 0
                        
                        self.flashLeft()
                        self.spawnLeftYellowTarget()
                        // increment response Count here? So that the answer is independent of user input
                        print("Response Key with self. = \(self.responseKey[self.responseCount])")
                        
                        self.responseCount += 1
                        print("Count after increment = \(self.responseCount)")
                         
                        print("Trial: 23, yellow coins, left yellow target. ")
                        print(self.responseKey[23])
                    }
                } else if !trialManager.type.flashRight && !trialManager.type.targetRight && !trialManager.type.targetBlue && !trialManager.type.coinCongruent {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + coinDelay) {
                        self.spawnBlueCoinWave()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                        self.reactionTime?.invalidate()
                        self.rt = 0
                        
                        self.flashLeft()
                        self.spawnLeftYellowTarget()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            self.dl.trainingDay = true
                            print("Training day toggled intrial block after spawn left yellow target - Training day: \(self.dl.trainingDay)")
                        }
                        
                        // increment response Count here? So that the answer is independent of user input
                        print("Response Key with self. = \(self.responseKey[self.responseCount])")
                        
                        //Don't increment the last time
//                        self.responseCount += 1
//                        print("Count after increment = \(self.responseCount)")
                         
                        print("Trial: 24, blue coins, left yellow target. ")
                        print(self.responseKey[24])
                    }
                }
            
//            }
        }
        

//        // To check physics
////        checkPhysics()
//        }
//
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
//            print("coin collided with player. First node =  \(firstNode.name ?? "") SecondNode = \(secondNode.name ?? "")")
        } else if secondNode.name == "rightTarget" {
            /// We don't need to be growng or anything right now
//            rightYellowTarget.run(SKAction.sequence([SKAction.scale(to: 1.3, duration: 0.1),
//                                                   SKAction.wait(forDuration: 0.1),
//                                                   SKAction.scale(to: 1, duration: 0.1)
//            ]))
//            rightBlueTarget.run(SKAction.sequence([SKAction.scale(to: 1.3, duration: 0.1),
//                                                   SKAction.wait(forDuration: 0.1),
//                                                   SKAction.scale(to: 1, duration: 0.1)
//            ]))
            firstNode.removeFromParent()
            
            run(SKAction.playSoundFileNamed("confirmation_002.wav", waitForCompletion: false))
            
            score += 5
        } else if secondNode.name == "leftTarget" {
            
//            leftBlueTarget.run(SKAction.sequence([SKAction.scale(to: 1.3, duration: 0.1),
//                                                   SKAction.wait(forDuration: 0.1),
//                                                   SKAction.scale(to: 1, duration: 0.1)
//            ]))
//            leftBlueTarget.run(SKAction.sequence([SKAction.scale(to: 1.3, duration: 0.1),
//                                                   SKAction.wait(forDuration: 0.1),
//                                                   SKAction.scale(to: 1, duration: 0.1)
//            ]))
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
            
            if node.name == "yellowRight" {
                print(responseCount)
                print(responseKey[responseCount])
                if responseKey[responseCount] == "rightYellow" {
                    score += 100
                    
                    // The action to stop it and move it to player
                    rightYellowTarget.removeAllActions()
                    let moveToPlayer = SKAction.move(to: player.position, duration: 1)
                    let sequence = SKAction.sequence([moveToPlayer, .removeFromParent()])
                    rightYellowTarget.run(sequence)
                   
                    run(SKAction.playSoundFileNamed("upgrade1.wav", waitForCompletion: false))
                    
                    print(rt)
                    
                    self.responseTargetArray.append(node.name!)
                    targetResponse = true
                    cueFlashed = false
                    print(node.name!)
                    
                    reactionTime?.invalidate()
                } else if responseKey[responseCount] != "rightYellow" {
                    // what happens if the response does not match
                    // The ship explodes with sound
                    if intersects(rightBlueTarget) {
                        if let particles = SKEmitterNode(fileNamed: "Explosion") {
                            particles.position = rightBlueTarget.position
                            particles.zPosition = 2
                            rightBlueTarget.alpha = 0
                            addChild(particles)
                            
                        }
                    } else if intersects(leftBlueTarget) {
                        if let particles = SKEmitterNode(fileNamed: "Explosion") {
                            particles.position = leftBlueTarget.position
                            particles.zPosition = 2
                            leftBlueTarget.alpha = 0
                            addChild(particles)
                        }
                    } else if intersects(leftYellowTarget) {
                        if let particles = SKEmitterNode(fileNamed: "Explosion") {
                            particles.position = leftYellowTarget.position
                            particles.zPosition = 2
                            leftYellowTarget.alpha = 0
                            addChild(particles)
                        }
                    }
                    
                    run(SKAction.playSoundFileNamed("explosion1.wav", waitForCompletion: false))
                    // Vibrate the device
                    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
                    
                    // Still need to append and change response parameters if they get the wrong answer
                    self.responseTargetArray.append(node.name!)
                    targetResponse = true
                    cueFlashed = false
                    // Either way the timer needs to be invalidated
                    reactionTime?.invalidate()
                    
                }
                
                
                
                
            } else if node.name == "yellowLeft" {
                print(responseCount)
                print(responseKey[responseCount])
                if responseKey[responseCount] == "leftYellow" {
                    score += 100
                    
                    // The action to stop it and move it to player
                    leftYellowTarget.removeAllActions()
                    let moveToPlayer = SKAction.move(to: player.position, duration: 1)
                    let sequence = SKAction.sequence([moveToPlayer, .removeFromParent()])
                    leftYellowTarget.run(sequence)
                    
                    run(SKAction.playSoundFileNamed("upgrade1.wav", waitForCompletion: false))
                    print(rt)
                    
                    self.responseTargetArray.append(node.name!)
                    targetResponse = true
                    cueFlashed = false
                    print(node.name!)
                    
                    reactionTime?.invalidate()
                } else if responseKey[responseCount] != "leftYellow" {
                    // what happens if the response does not match
                    // The ship explodes with sound
                    if intersects(leftBlueTarget) {
                        if let particles = SKEmitterNode(fileNamed: "Explosion") {
                            particles.position = leftBlueTarget.position
                            particles.zPosition = 2
                            leftBlueTarget.alpha = 0
                            addChild(particles)
                        }
                    } else if intersects(rightBlueTarget) {
                        if let particles = SKEmitterNode(fileNamed: "Explosion") {
                            particles.position = rightBlueTarget.position
                            particles.zPosition = 2
                            rightBlueTarget.alpha = 0
                            addChild(particles)
                        }
                    } else if intersects(rightYellowTarget) {
                        if let particles = SKEmitterNode(fileNamed: "Explosion") {
                            particles.position = rightYellowTarget.position
                            particles.zPosition = 2
                            rightYellowTarget.alpha = 0
                            addChild(particles)
                        }
                    }
                    run(SKAction.playSoundFileNamed("explosion1.wav", waitForCompletion: false))
                    // Vibrate the device
                    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
                    // Still need to append and change response parameters if they get the wrong answer
                    self.responseTargetArray.append(node.name!)
                    targetResponse = true
                    cueFlashed = false
                    // Either way the timer needs to be invalidated
                    reactionTime?.invalidate()
                }
                
                
            
            } else if node.name == "blueRight" {
                print(responseCount)
                print(responseKey[responseCount])
                
                if responseKey[responseCount] == "rightBlue" {
                    score += 100
                    
                    // The action to stop it and move it to player
                    rightBlueTarget.removeAllActions()
                    let moveToPlayer = SKAction.move(to: player.position, duration: 1)
                    let sequence = SKAction.sequence([moveToPlayer, .removeFromParent()])
                    rightBlueTarget.run(sequence)
                    player.run(SKAction.sequence([SKAction.scale(to: 1.3, duration: 0.1),
                                                  SKAction.wait(forDuration: 0.1),
                                                  SKAction.scale(to: 1, duration: 0.1)
           ]))
                    run(SKAction.playSoundFileNamed("upgrade1.wav", waitForCompletion: false))
                    print(rt)
                    
                    self.responseTargetArray.append(node.name!)
                    targetResponse = true
                    cueFlashed = false
                    print(node.name!)
                    
                    reactionTime?.invalidate()
                } else if responseKey[responseCount] != "rightBlue" {
                    // what happens if the response does not match
                    // The ship explodes with sound
                    if intersects(rightYellowTarget) {
                        if let particles = SKEmitterNode(fileNamed: "Explosion") {
                            particles.position = rightYellowTarget.position
                            particles.zPosition = 2
                            rightYellowTarget.alpha = 0
                            addChild(particles)
                        }
                    } else if intersects(leftBlueTarget) {
                        if let particles = SKEmitterNode(fileNamed: "Explosion") {
                            particles.position = leftBlueTarget.position
                            particles.zPosition = 2
                            leftBlueTarget.alpha = 0
                            addChild(particles)
                        }
                    } else if intersects(leftYellowTarget) {
                        if let particles = SKEmitterNode(fileNamed: "Explosion") {
                            particles.position = leftYellowTarget.position
                            particles.zPosition = 2
                            leftYellowTarget.alpha = 0
                            addChild(particles)
                        }
                    }
                    run(SKAction.playSoundFileNamed("explosion1.wav", waitForCompletion: false))
                    // Vibrate the device
                    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
                    
                    // Still need to append and change response parameters if they get the wrong answer
                    self.responseTargetArray.append(node.name!)
                    targetResponse = true
                    cueFlashed = false
                    // Either way the timer needs to be invalidated
                    reactionTime?.invalidate()
                }
                
                
            
            } else if node.name == "blueLeft" {
                print(responseCount)
                print(responseKey[responseCount])
                if responseKey[responseCount] == "leftBlue" {
                    // Increment score
                    score += 100
                    // The action to stop it and move it to player
                    leftBlueTarget.removeAllActions()
                    let moveToPlayer = SKAction.move(to: player.position, duration: 1)
                    let sequence = SKAction.sequence([moveToPlayer, .removeFromParent()])
                    leftBlueTarget.run(sequence)
                    player.run(SKAction.sequence([SKAction.scale(to: 1.3, duration: 0.1),
                                                  SKAction.wait(forDuration: 0.1),
                                                  SKAction.scale(to: 1, duration: 0.1)
           ]))
                    run(SKAction.playSoundFileNamed("upgrade1.wav", waitForCompletion: false))
                    // Record Reaction time
                    print(rt)
                    
                    self.responseTargetArray.append(node.name!)
                    targetResponse = true
                    cueFlashed = false
                    print(node.name!)
                    
                    reactionTime?.invalidate()
                } else if responseKey[responseCount] != "leftBlue" {
                    // what happens if the response does not match
                    // The ship explodes with sound
                    if intersects(leftYellowTarget) {
                        if let particles = SKEmitterNode(fileNamed: "Explosion") {
                            particles.position = leftYellowTarget.position
                            particles.zPosition = 2
                            leftYellowTarget.alpha = 0
                            addChild(particles)
                        }
                    } else if intersects(rightBlueTarget) {
                        if let particles = SKEmitterNode(fileNamed: "Explosion") {
                            particles.position = rightBlueTarget.position
                            particles.zPosition = 2
                            rightBlueTarget.alpha = 0
                            addChild(particles)
                        }
                    } else if intersects(rightYellowTarget) {
                        if let particles = SKEmitterNode(fileNamed: "Explosion") {
                            particles.position = rightYellowTarget.position
                            particles.zPosition = 2
                            rightYellowTarget.alpha = 0
                            addChild(particles)
                        }
                    }
                    run(SKAction.playSoundFileNamed("explosion1.wav", waitForCompletion: false))
                    // Vibrate the device
                    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
                    
                    // Still need to append and change response parameters if they get the wrong answer
                    self.responseTargetArray.append(node.name!)
                    targetResponse = true
                    cueFlashed = false
                    // Either way the timer needs to be invalidated
                    reactionTime?.invalidate()
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
        if cueFlashed {
            
        }
    }
    
    @objc func sessionCountDown() {
        if countDown < 0 {
        countDown += 0.1
        } else {
            return
        }
        
    }
    
    @objc func reactToTarget() {
        if targetResponse == false {
            rt += 0.1
        } else if targetResponse == true {
            responseTimeArray.append(rt)
            
            print(rt)
            rt = 0.0
            targetResponse = false
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

