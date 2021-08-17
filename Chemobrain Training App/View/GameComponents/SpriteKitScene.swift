//
//  SpriteKitScene.swift
//  Chemobrain Training App
//
//  Created by Dominic Bieniewski on 7/26/21.
//

import SpriteKit
import SwiftUI


// An Enum to track the identification of collisions/physic bodies
enum CollisionType: UInt32 {
    case player = 1
    case coin = 2
    case obstruction = 4
    case distractorLaser = 8
}

class SpriteKitScene: SKScene, SKPhysicsContactDelegate {
    
    
    
    @EnvironmentObject var viewModel: AppViewModel

    
    // Setting up the timer and score
    var timer: Timer?
    let timerLabel = SKLabelNode(fontNamed: "Baskerville-Bold")
    let scoreLabel = SKLabelNode(fontNamed: "Baskerville-Bold")
 
    
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
    
    // Setting up images for the scene itself
    let fixedSky = SKSpriteNode(imageNamed: "fixedSky")
    let tile = SKSpriteNode(imageNamed: "tile")
    let player = SKSpriteNode(imageNamed: "player")
    let portal = SKSpriteNode(imageNamed: "gas0")
    let leftArrow = SKSpriteNode(imageNamed: "tile_directionWest")
    let rightArrow = SKSpriteNode(imageNamed: "tile_directionEast")

    let music = SKAudioNode(fileNamed: "the-hero.mp3")
    
    // Setting up properties to control the scene
    let center: CGFloat = 0
    var moveCount = 0
    
    
    var levelNumber = 0
    var waveNumber = 0
    
    let positions = Array(stride(from: -50, through: 50, by: 50))
    
    override func didMove(to view: SKView) {
        
        
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
        
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(sessionCountDown), userInfo: nil, repeats: true)
        
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
        let portalAnim = SKAction.animate(with: portalArray, timePerFrame: 0.2)
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
        rightArrow.name = "right"
        rightArrow.position = CGPoint(x: 325, y: -400)
        rightArrow.size = CGSize(width: 100, height: 100)
        rightArrow.zPosition = 2
        addChild(rightArrow)
        
        leftArrow.name = "left"
        leftArrow.position = CGPoint(x: -325, y: -400)
        leftArrow.size = CGSize(width: 100, height: 100)
        leftArrow.zPosition = 2
        addChild(leftArrow)
        
        // Initiating the player
        player.name = "player"
        player.position.y = frame.minY + 150
        player.position.x = 0
        player.zPosition = 1
        player.size = CGSize(width: 100, height: 100)
        player.zRotation = .pi / 1
        //Adding physics body to allow collisions with coins and obstacles and distractor laser
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.texture!.size())
        player.physicsBody?.categoryBitMask = CollisionType.player.rawValue
        player.physicsBody?.collisionBitMask = CollisionType.coin.rawValue | CollisionType.obstruction.rawValue | CollisionType.distractorLaser.rawValue
        player.physicsBody?.contactTestBitMask = CollisionType.coin.rawValue | CollisionType.obstruction.rawValue | CollisionType.distractorLaser.rawValue
        player.physicsBody?.isDynamic = false
        addChild(player)
        
        //Place sky
        fixedSky.name = "sky"
        fixedSky.size = CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.height)!)
        fixedSky.zPosition = -2

        addChild(fixedSky)
        
        
        // It might be the case that all of the coins are being rendered in the same exact space and so appear as if only one if being genereated at a time, which may be why you generate waves offscreen - in their offset positions - before you move them onto the screen. But that won't work for me so maybe it will have to be something ran in the background thread liek the stack overflow answer. OR alternatively , make the coins visibility property be off until they hit y: 300 where the portal is and then make them visible again.
        
        spawnThingEveryFiveSecondsThenDeleteAfterThree()

        // To check physics
        checkPhysics()
        
        
    }
    
    func spawnThingEveryFiveSecondsThenDeleteAfterThree() {

      func spawnCoin()   {
        let randomLane = Int.random(in: 1...3)
        var lanePosition = 0

        switch randomLane {
        case 1:
            lanePosition = 0
        case 2:
            lanePosition = -150
        case 3:
            lanePosition = 150
        default:
            lanePosition = 0
        }
        
        print("\(randomLane)")
        
        let coin = SKSpriteNode(imageNamed: "redResources")
        coin.position = CGPoint(x: lanePosition, y: 300)
        coin.size = CGSize(width: 50, height: 50)
        coin.name = "coin"
        
        coin.physicsBody = SKPhysicsBody(rectangleOf: coin.size)
//            coin.physicsBody?.isDynamic = false
        coin.physicsBody?.categoryBitMask = CollisionType.coin.rawValue
        coin.physicsBody?.collisionBitMask = CollisionType.player.rawValue
        coin.physicsBody?.contactTestBitMask = CollisionType.player.rawValue
        self.addChild(coin)
        
        let movement = SKAction.move(to: CGPoint(x: coin.position.x, y: -800), duration: 4)
        let sequence = SKAction.sequence([movement, .removeFromParent()])
        coin.run(sequence)
        
      }
        
      func despawnShootyThing() { /* input your code here */ }

      let wait1  = SKAction.wait(forDuration: 0.25)
      let wait3   = SKAction.wait(forDuration:  3)
      let spawn   = SKAction.run { spawnCoin() }
//          let despawn = SKAction.run { despawnShootyThing() }

      let action = SKAction.sequence([wait1, spawn, wait1, spawn, wait1, spawn, wait1, spawn, wait1, spawn, wait3, wait1, spawn, wait1, spawn, wait1, spawn, wait1, spawn, wait1, spawn])

      // If you don't want this action to run forever, then remove this action!
      let forever = SKAction.repeatForever(action)

      self.run(forever)
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
//            viewModel.score += 1
            score += 1
            print("coin collided with player. First node =  \(firstNode.name ?? "") SecondNode = \(secondNode.name ?? "")")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //To capture the first touch on screen - more to come
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)

        if location.x < center {
            guard moveCount != -1 else { return }
            moveCount -= 1
            let moveLeft = SKAction.moveBy(x: -163, y: 0, duration: 0.5)
            player.run(moveLeft)
        } else {
            
            guard moveCount != 1 else { return }
            let moveRight = SKAction.moveBy(x: +163, y: 0, duration: 0.5)
            player.run(moveRight)
            moveCount += 1
            
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        //This is called before each frame is rendered
    //    moveCoins()
    }
    
    @objc func sessionCountDown() {
        if countDown > 0 {
        countDown -= 0.1
        } else {
            return
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
    
    @objc func createWave3() {
        
        let coinRandom = Int.random(in: 5..<15)
        let randomLane = Int.random(in: 1...3)
        
            for _ in 0...15 {
                // Not sure where to put the queue async so that the coins generate after one second delays.
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let coin = SKSpriteNode(imageNamed: "redResources")
                coin.position = CGPoint(x: 0, y: 300)
                coin.size = CGSize(width: 50, height: 50)
                coin.name = "coin"
                
                coin.physicsBody = SKPhysicsBody(rectangleOf: coin.size)
                coin.physicsBody?.isDynamic = false
                coin.physicsBody?.categoryBitMask = CollisionType.coin.rawValue
                coin.physicsBody?.collisionBitMask = CollisionType.player.rawValue
                coin.physicsBody?.contactTestBitMask = CollisionType.player.rawValue
                self.addChild(coin)
                
                let movement = SKAction.move(to: CGPoint(x: coin.position.x, y: -750), duration: 3)
                let sequence = SKAction.sequence([movement, .removeFromParent()])
                coin.run(sequence)
                //                switch randomLane {
                //                case 1:
                //                    <#code#>
                //                case 2:
                //                    <#code#>
                //                case 3:
                //                    <#code#>
                //                default:
                //                    print("Something went wrong")
                //                }
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
