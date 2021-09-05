//
//  ExtensionSpriteKitScene.swift
//  Chemobrain Training App
//
//  Created by Dominic Bieniewski on 8/23/21.
//

import SpriteKit

extension SpriteKitScene {

    func cueToTargetInterval() -> Double {
        
        
        
        var targetOnScreen: Bool = false
        var cueToTargetArray: Array<Double> = []
        
        func reactToInterval() {
            if targetOnScreen == false {
                interval += 0.1
            } else if targetOnScreen == true {
                cueToTargetArray.append(interval)
                
                print(interval)
                interval = 0.0
                targetOnScreen = false
            }
        }
        
        if cueFlashed == true {
            intervalTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { intervalTimer in
                if targetOnScreen == false {
                    self.interval += 0.1
                } else if targetOnScreen == true {
                    cueToTargetArray.append(self.interval)
                    
                    print(self.interval)
                    self.interval = 0.0
                    targetOnScreen = false
                }
            })
            
            
        }
        
        
        
        if intersects(leftYellowTarget) {
            targetOnScreen = true
        } else if intersects(leftBlueTarget) {
            targetOnScreen = true
        } else if intersects(rightYellowTarget) {
            targetOnScreen = true
        } else if intersects(rightBlueTarget) {
            targetOnScreen = true
        }
        
        return interval
        
        
    }

    func flashRight() {
        
        // Invalidate timer at begining of flash call so the new timer will be fresh
        reactionTime?.invalidate()
       
        let flashRight = SKSpriteNode(imageNamed: "redLine")
        flashRight.position = CGPoint(x: 403, y: 0)
        flashRight.zPosition = 2
        flashRight.size = CGSize(width: frame.height, height: flashRight.size.height)
        flashRight.zRotation = .pi / 2
        flashRight.alpha = 0
        self.addChild(flashRight)
        
        let wait10 = SKAction.wait(forDuration: 4)
        let wait1 = SKAction.wait(forDuration: 0.25)
        
        flashRight.run(wait10)
        flashRight.alpha = 0.5
        
        cueFlashed = true
        // Here is where flash appears on screen - cue timer
        reactionTime = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(reactToTarget), userInfo: nil, repeats: true)
        
        let sequence = SKAction.sequence([wait1, .removeFromParent()])
        flashRight.run(sequence)
    }
    
    func flashRightCircle() {
        let circle = SKShapeNode(circleOfRadius: 60)
        circle.position = CGPoint(x: 403, y: 100)
        circle.name = "rightRedCircle"
        circle.strokeColor = SKColor.red
        circle.glowWidth = 10.0
        circle.fillColor = SKColor.red
        circle.physicsBody?.isDynamic = false
        circle.zPosition = 1
        circle.alpha = 0
        self.addChild(circle)
        
        let wait10 = SKAction.wait(forDuration: 4)
        let wait1 = SKAction.wait(forDuration: 0.25)
        
        circle.run(wait10)
        circle.alpha = 0.5
        
        cueFlashed = true
        // Here is where flash appears on screen - cue timer
        reactionTime = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(reactToTarget), userInfo: nil, repeats: true)
        
        let sequence = SKAction.sequence([wait1, .removeFromParent()])
        circle.run(sequence)
    }
    
    func flashLeftCircle() {
        let circle = SKShapeNode(circleOfRadius: 60)
        circle.position = CGPoint(x: -403, y: 100)
        circle.name = "leftRedCircle"
        circle.strokeColor = SKColor.red
        circle.glowWidth = 10.0
        circle.fillColor = SKColor.red
        circle.physicsBody?.isDynamic = false
        circle.zPosition = 1
        circle.alpha = 0
        self.addChild(circle)
        
        let wait10 = SKAction.wait(forDuration: 4)
        let wait1 = SKAction.wait(forDuration: 0.25)
        
        circle.run(wait10)
        circle.alpha = 0.5
        
        cueFlashed = true
        // Here is where flash appears on screen - cue timer
        reactionTime = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(reactToTarget), userInfo: nil, repeats: true)
        
        let sequence = SKAction.sequence([wait1, .removeFromParent()])
        circle.run(sequence)
    }
    
    func flashBothCircles() {
        let leftCircle = SKShapeNode(circleOfRadius: 60)
        leftCircle.position = CGPoint(x: -403, y: 100)
        leftCircle.name = "leftRedCircle"
        leftCircle.strokeColor = SKColor.red
        leftCircle.glowWidth = 10.0
        leftCircle.fillColor = SKColor.red
        leftCircle.physicsBody?.isDynamic = false
        leftCircle.zPosition = 1
        leftCircle.alpha = 0
        self.addChild(leftCircle)
        
        let rightCircle = SKShapeNode(circleOfRadius: 60)
        rightCircle.position = CGPoint(x: 403, y: 100)
        rightCircle.name = "rightRedCircle"
        rightCircle.strokeColor = SKColor.red
        rightCircle.glowWidth = 10.0
        rightCircle.fillColor = SKColor.red
        rightCircle.physicsBody?.isDynamic = false
        rightCircle.zPosition = 1
        rightCircle.alpha = 0
        self.addChild(rightCircle)
        
        let wait10 = SKAction.wait(forDuration: 4)
        let wait1 = SKAction.wait(forDuration: 0.25)
        
        rightCircle.run(wait10)
        leftCircle.run(wait10)
        
        rightCircle.alpha = 0.5
        leftCircle.alpha = 0.5
        
        cueFlashed = true
        // Here is where flash appears on screen - cue timer
        reactionTime = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(reactToTarget), userInfo: nil, repeats: true)
        
        let sequence = SKAction.sequence([wait1, .removeFromParent()])
        leftCircle.run(sequence)
        rightCircle.run(sequence)
    }
    
    func flashLeft() {
        
        // Invalidate timer at begining of flash call so the new timer will be fresh
        reactionTime?.invalidate()
        
        let flashLeft = SKSpriteNode(imageNamed: "redLine")
        flashLeft.position = CGPoint(x: -403, y: 0)
        flashLeft.zPosition = 2
        flashLeft.size = CGSize(width: frame.height, height: flashLeft.size.height)
        flashLeft.zRotation = .pi / 2
        flashLeft.alpha = 0
        self.addChild(flashLeft)
        
        let wait10 = SKAction.wait(forDuration: 4)
        let wait1 = SKAction.wait(forDuration: 0.25)
        
        flashLeft.run(wait10)
        flashLeft.alpha = 0.5
        
        cueFlashed = true
        // Here is where flash appears on screen - cue timer
        reactionTime = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(reactToTarget), userInfo: nil, repeats: true)
        
        let sequence = SKAction.sequence([wait1, .removeFromParent()])
        flashLeft.run(sequence)
    }
    
    func wholeScreenFlash() {
        
        // Invalidate timer at begining of flash call so the new timer will be fresh
        reactionTime?.invalidate()
        
        let wholeScreenFlash = SKSpriteNode(imageNamed: "wholeScreenFlash")
        wholeScreenFlash.position = CGPoint(x: 0, y: 0)
        wholeScreenFlash.size = CGSize(width: frame.width, height: frame.height)
        wholeScreenFlash.zPosition = 2
        wholeScreenFlash.alpha = 0
        self.addChild(wholeScreenFlash)
        
        
        let wait10 = SKAction.wait(forDuration: 23)
        let wait1 = SKAction.wait(forDuration: 0.25)
        
        wholeScreenFlash.run(wait10)
        wholeScreenFlash.alpha = 0.7
        
        cueFlashed = true
        // Here is where flash appears on screen - cue timer
        reactionTime = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(reactToTarget), userInfo: nil, repeats: true)
        
        let sequence = SKAction.sequence([wait1, .removeFromParent()])
        wholeScreenFlash.run(sequence)
    }
    
    func spawnRightBlueTarget() {
        
        //boiler plate for target object
        rightBlueTarget.position = CGPoint(x: 500, y: 200)
        rightBlueTarget.size = CGSize(width: 150, height: 45)
        rightBlueTarget.zPosition = 1
        rightBlueTarget.alpha = 1
        rightBlueTarget.name = "rightTarget"
        
        // To add physics and bitmasks
        rightBlueTarget.physicsBody = SKPhysicsBody(texture: rightBlueTarget.texture!, size: CGSize(width: 50, height: 50))
        rightBlueTarget.physicsBody?.categoryBitMask = CollisionType.target.rawValue
//        rightBlueTarget.physicsBody?.collisionBitMask = CollisionType.player.rawValue | CollisionType.coin.rawValue
        rightBlueTarget.physicsBody?.contactTestBitMask = CollisionType.player.rawValue | CollisionType.coin.rawValue
        rightBlueTarget.physicsBody?.isDynamic = false
        self.addChild(rightBlueTarget)
        
        let movement = SKAction.move(to: CGPoint(x: 275, y: 0), duration: 1.5)
        let movement2 = SKAction.move(to: CGPoint(x: 500, y: -700), duration: 0.5)
        let wait5 = SKAction.wait(forDuration: 1)
        let wait10 = SKAction.wait(forDuration: 6)
        
        let rotateAction = SKAction.rotate(byAngle: .pi, duration: 0.5)
        let repeatRotation = SKAction.repeatForever(rotateAction)
        rightBlueTarget.run(repeatRotation)
        let sequence = SKAction.sequence([wait5, movement, wait10, .removeFromParent()/*, movement2, .removeFromParent()*/])
        rightBlueTarget.run(sequence)
    }
    
    func spawnRightYellowTarget() {
        
        //boiler plate for target object
        rightYellowTarget.position = CGPoint(x: 500, y: 200)
        rightYellowTarget.size = CGSize(width: 150, height: 45)
        rightYellowTarget.zPosition = 1
        rightYellowTarget.alpha = 1
        rightYellowTarget.name = "rightTarget"
        
        // To add physics and bitmasks
        rightYellowTarget.physicsBody = SKPhysicsBody(texture: rightBlueTarget.texture!, size: CGSize(width: 50, height: 50))
        rightYellowTarget.physicsBody?.categoryBitMask = CollisionType.target.rawValue
//        rightYellowTarget.physicsBody?.collisionBitMask = CollisionType.player.rawValue | CollisionType.coin.rawValue
        rightYellowTarget.physicsBody?.contactTestBitMask = CollisionType.player.rawValue | CollisionType.coin.rawValue
        rightYellowTarget.physicsBody?.isDynamic = false
        self.addChild(rightYellowTarget)
        
        let movement = SKAction.move(to: CGPoint(x: 260, y: 0), duration: 1.5)
        let movement2 = SKAction.move(to: CGPoint(x: 500, y: -700), duration: 0.5)
        let wait5 = SKAction.wait(forDuration: 1)
        let wait10 = SKAction.wait(forDuration: 6)
        
        let rotateAction = SKAction.rotate(byAngle: .pi, duration: 0.5)
        let repeatRotation = SKAction.repeatForever(rotateAction)
        rightYellowTarget.run(repeatRotation)
        let sequence = SKAction.sequence([wait5, movement, wait10, .removeFromParent()/*, movement2, .removeFromParent()*/])
        rightYellowTarget.run(sequence)
    }
    
    func spawnLeftYellowTarget() {
        
        //boiler plate for target object
        leftYellowTarget.position = CGPoint(x: -500, y: 200)
        leftYellowTarget.size = CGSize(width: 150, height: 45)
        leftYellowTarget.zPosition = 1
        leftYellowTarget.alpha = 1
        leftYellowTarget.name = "leftTarget"
        
        // To add physics and bitmasks
        leftYellowTarget.physicsBody = SKPhysicsBody(texture: rightBlueTarget.texture!, size: CGSize(width: 50, height: 50))
        leftYellowTarget.physicsBody?.categoryBitMask = CollisionType.target.rawValue
 //       leftYellowTarget.physicsBody?.collisionBitMask = CollisionType.player.rawValue | CollisionType.coin.rawValue
        leftYellowTarget.physicsBody?.contactTestBitMask = CollisionType.player.rawValue | CollisionType.coin.rawValue
        leftYellowTarget.physicsBody?.isDynamic = false
        self.addChild(leftYellowTarget)
        
        let movement = SKAction.move(to: CGPoint(x: -260, y: 0), duration: 1.5)
        let movement2 = SKAction.move(to: CGPoint(x: -500, y: -700), duration: 0.5)
        let wait5 = SKAction.wait(forDuration: 1)
        let wait10 = SKAction.wait(forDuration: 6)

        let rotateAction = SKAction.rotate(byAngle: .pi, duration: 0.5)
        let repeatRotation = SKAction.repeatForever(rotateAction)
        leftYellowTarget.run(repeatRotation)
        let sequence = SKAction.sequence([wait5, movement, wait10, .removeFromParent()])
        leftYellowTarget.run(sequence)
    }
    
    func spawnLeftBlueTarget() {
        
        //boiler plate for target object
        leftBlueTarget.position = CGPoint(x: -500, y: 200)
        leftBlueTarget.size = CGSize(width: 150, height: 45)
        leftBlueTarget.zPosition = 1
        leftBlueTarget.alpha = 1
        leftBlueTarget.name = "leftTarget"
        
        // To add physics and bitmasks
        leftBlueTarget.physicsBody = SKPhysicsBody(texture: rightBlueTarget.texture!, size: CGSize(width: 50, height: 50))
        leftBlueTarget.physicsBody?.categoryBitMask = CollisionType.target.rawValue
//        leftBlueTarget.physicsBody?.collisionBitMask = CollisionType.player.rawValue | CollisionType.coin.rawValue
        leftBlueTarget.physicsBody?.contactTestBitMask = CollisionType.player.rawValue | CollisionType.coin.rawValue
        leftBlueTarget.physicsBody?.isDynamic = false
        self.addChild(leftBlueTarget)
        
        let movement = SKAction.move(to: CGPoint(x: -260, y: 0), duration: 1.5)
        let movement2 = SKAction.move(to: CGPoint(x: -500, y: -700), duration: 0.5)
        let wait5 = SKAction.wait(forDuration: 1)
        let wait10 = SKAction.wait(forDuration: 6)

        let rotateAction = SKAction.rotate(byAngle: .pi, duration: 0.5)
        let repeatRotation = SKAction.repeatForever(rotateAction)
        leftBlueTarget.run(repeatRotation)
        let sequence = SKAction.sequence([wait5, movement, wait10, .removeFromParent()])
        leftBlueTarget.run(sequence)
    }
    
    func spawnRedCoinWave() {
        
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
            
            //        print("\(randomLane)")
            
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
            
            let movement = SKAction.move(to: CGPoint(x: coin.position.x, y: -800), duration: 7)
            let sequence = SKAction.sequence([movement, .removeFromParent()])
            coin.run(sequence)
            
        }
        
        let wait1  = SKAction.wait(forDuration: 0.25)
        let wait3   = SKAction.wait(forDuration:  2)
        let spawn   = SKAction.run { spawnCoin() }
        
        let action = SKAction.sequence([wait1, spawn, wait1, spawn, wait1, spawn, wait1, spawn, wait1, spawn, wait1, spawn, wait1, spawn, wait3, wait1, spawn, wait1, spawn, wait1, spawn, wait1, spawn, wait1, spawn, wait1, spawn, wait1, spawn])
        
        // To run coin spawns forever
        //      let forever = SKAction.repeatForever(action)
        
        self.run(action)
    }
    
    func spawnYellowCoinWave() {
        
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
            
            //        print("\(randomLane)")
            
            let coin = SKSpriteNode(imageNamed: "shipYellow_manned")
            coin.position = CGPoint(x: lanePosition, y: 300)
            coin.size = CGSize(width: 50, height: 50)
            coin.name = "coin"
            coin.zPosition = 0
            
            coin.physicsBody = SKPhysicsBody(rectangleOf: coin.size)
            //            coin.physicsBody?.isDynamic = false
            coin.physicsBody?.categoryBitMask = CollisionType.coin.rawValue
            coin.physicsBody?.collisionBitMask = CollisionType.player.rawValue
            coin.physicsBody?.contactTestBitMask = CollisionType.player.rawValue | CollisionType.target.rawValue
            self.addChild(coin)
            
            let movement = SKAction.move(to: CGPoint(x: coin.position.x, y: -800), duration: 5)
            let sequence = SKAction.sequence([movement, .removeFromParent()])
            coin.run(sequence)
            
        }
        
        let wait1  = SKAction.wait(forDuration: 0.25)
        let wait3   = SKAction.wait(forDuration:  1.5)
        let spawn   = SKAction.run { spawnCoin() }
        
        let action = SKAction.sequence([wait1, spawn, wait1, spawn, wait1, spawn, wait1, spawn, wait1, spawn, wait1, spawn, wait1, spawn, wait1, spawn, wait1, spawn, wait1, spawn, wait3, wait1, spawn, wait1, spawn, wait1, spawn, wait1, spawn, wait1, spawn, wait1, spawn, wait1, spawn, wait1, spawn, wait1, spawn, wait1, spawn])
        
        // To run coin spawns forever
        //      let forever = SKAction.repeatForever(action)
        
        self.run(action)
    }
    
    func spawnBlueCoinWave() {
        
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
            
            //        print("\(randomLane)")
            
            let coin = SKSpriteNode(imageNamed: "shipBlue_manned")
            coin.position = CGPoint(x: lanePosition, y: 300)
            coin.size = CGSize(width: 50, height: 50)
            coin.name = "coin"
            coin.zPosition = 0
            
            coin.physicsBody = SKPhysicsBody(rectangleOf: coin.size)
            //            coin.physicsBody?.isDynamic = false
            coin.physicsBody?.categoryBitMask = CollisionType.coin.rawValue
            coin.physicsBody?.collisionBitMask = CollisionType.player.rawValue
            coin.physicsBody?.contactTestBitMask = CollisionType.player.rawValue | CollisionType.target.rawValue
            self.addChild(coin)
            
            let movement = SKAction.move(to: CGPoint(x: coin.position.x, y: -800), duration: 5)
            let sequence = SKAction.sequence([movement, .removeFromParent()])
            coin.run(sequence)
            
        }
        
        let wait1  = SKAction.wait(forDuration: 0.25)
        let wait3   = SKAction.wait(forDuration:  1.5)
        let spawn   = SKAction.run { spawnCoin() }
        
        let action = SKAction.sequence([wait1, spawn, wait1, spawn, wait1, spawn, wait1, spawn, wait1, spawn, wait1, spawn, wait1, spawn, wait1, spawn, wait1, spawn, wait1, spawn, wait3, wait1, spawn, wait1, spawn, wait1, spawn, wait1, spawn, wait1, spawn, wait1, spawn, wait1, spawn, wait1, spawn, wait1, spawn, wait1, spawn])
        
        // To run coin spawns forever
        //      let forever = SKAction.repeatForever(action)
        
        self.run(action)
    }
}
