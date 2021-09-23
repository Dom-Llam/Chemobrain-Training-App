//
//  ExtensionSpriteKitScene.swift
//  Chemobrain Training App
//
//  Created by Dominic Bieniewski on 8/23/21.
//

import SpriteKit

extension SpriteKitScene {

    func flashRightCircle(wait forDuration: Double) {
        //To trigger timer logic
        let timerTrigger = SKAction.customAction(withDuration: 0) { _,_ in
            self.onlyOne = true
            
        }
        let wait10 = SKAction.wait(forDuration: 4)
        let wait1 = SKAction.wait(forDuration: 0.25)
        // For switch to .wait
        let trialWait = SKAction.wait(forDuration: forDuration)
        

        let sequence = SKAction.sequence([trialWait, wait10, visible, timerTrigger, wait1, invisible])
        rightCircle.run(sequence)
    }
    
    func flashLeftCircle(wait forDuration: Double) {
        //To trigger timer logic
        let timerTrigger = SKAction.customAction(withDuration: 0) { _,_ in
            self.onlyOne = true
           
        }
        let wait10 = SKAction.wait(forDuration: 4)
        let wait1 = SKAction.wait(forDuration: 0.25)
        // For switch to .wait
        let trialWait = SKAction.wait(forDuration: forDuration)
        
        let sequence = SKAction.sequence([trialWait, wait10, visible, timerTrigger, wait1, invisible])
        leftCircle.run(sequence)
    }
    
    func flashBothCircles(wait forDuration: Double) {
        //To trigger timer logic
        let timerTrigger = SKAction.customAction(withDuration: 0) { [self] _,_ in
            // For the RT boolean in update
            self.onlyOne = true


//            // For the response logic
//            self.cueFlashed = true
//
//            // For finding the cue-to-target interval
//            intervalTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(reactToInterval), userInfo: nil, repeats: true)
        }
        
        let wait10 = SKAction.wait(forDuration: 4)
        let wait1 = SKAction.wait(forDuration: 0.25)
        // For switch to .wait
        let trialWait = SKAction.wait(forDuration: forDuration)
        

        let sequence = SKAction.sequence([trialWait, wait10, timerTrigger, visible, wait1, invisible])
        leftCircle.run(sequence)
        rightCircle.run(sequence)
    }

    func spawnRightBlueTarget(wait forDuration: Double) {
  
        let movement = SKAction.move(to: CGPoint(x: 275, y: 0), duration: 1.5)
        let wait1 = SKAction.wait(forDuration: 1)
        let wait5 = SKAction.wait(forDuration: 5)
        
        // For switch to .wait
        let trialWait = SKAction.wait(forDuration: forDuration)
        
        let rotateAction = SKAction.rotate(byAngle: .pi, duration: 4)
        let repeatRotation = SKAction.repeatForever(rotateAction)
        let sequence = SKAction.sequence([trialWait, resetRightTarget, targetVisible, wait1, movement, wait5, invisible, resetRightTarget/*, movement2, .removeFromParent()*/])
        
        rightBlueTarget.run(repeatRotation)
        rightBlueTarget.run(sequence)
    }
    
    func spawnRightYellowTarget(wait forDuration: Double) {
        
        let movement = SKAction.move(to: CGPoint(x: 275, y: 0), duration: 1.5)
        let wait1 = SKAction.wait(forDuration: 1)
        let wait5 = SKAction.wait(forDuration: 5)
        
        // For switch to .wait
        let trialWait = SKAction.wait(forDuration: forDuration)
        
        let rotateAction = SKAction.rotate(byAngle: .pi, duration: 4)
        let repeatRotation = SKAction.repeatForever(rotateAction)
        let sequence = SKAction.sequence([trialWait, resetRightTarget, targetVisible, wait1, movement, wait5, invisible, resetRightTarget/*, movement2, .removeFromParent()*/])
        
        rightYellowTarget.run(repeatRotation)
        rightYellowTarget.run(sequence)
    }
    
    func spawnLeftYellowTarget(wait forDuration: Double) {

        let movement = SKAction.move(to: CGPoint(x: -275, y: 0), duration: 1.5)
        let wait1 = SKAction.wait(forDuration: 1)
        let wait5 = SKAction.wait(forDuration: 5)
        
        // For switch to .wait
        let trialWait = SKAction.wait(forDuration: forDuration)
        
        let rotateAction = SKAction.rotate(byAngle: .pi, duration: 4)
        let repeatRotation = SKAction.repeatForever(rotateAction)
        let sequence = SKAction.sequence([trialWait, resetLeftTarget, targetVisible, wait1, movement, wait5, invisible, resetLeftTarget/*, movement2, .removeFromParent()*/])
        
        leftYellowTarget.run(repeatRotation)
        leftYellowTarget.run(sequence)
    }
    
    func spawnLeftBlueTarget(wait forDuration: Double) {

        let movement = SKAction.move(to: CGPoint(x: -275, y: 0), duration: 1.5)
        let wait1 = SKAction.wait(forDuration: 1)
        let wait5 = SKAction.wait(forDuration: 5)
        
        // For switch to .wait
        let trialWait = SKAction.wait(forDuration: forDuration)
        
        let rotateAction = SKAction.rotate(byAngle: .pi, duration: 4)
        let repeatRotation = SKAction.repeatForever(rotateAction)
        let sequence = SKAction.sequence([trialWait, resetLeftTarget, targetVisible, wait1, movement, wait5, invisible, resetLeftTarget/*, movement2, .removeFromParent()*/])
        
        leftBlueTarget.run(repeatRotation)
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
    
    func spawnYellowCoinWave(wait forDuration: Double, numberOfCoins: Int, numberOfWaves: Int/*waveSpeed: Int*/) {
        
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
            coin.size = CGSize(width: 60, height: 60)
            coin.name = "coin"
            coin.zPosition = 0
            
            coin.physicsBody = SKPhysicsBody(rectangleOf: coin.size)
            //            coin.physicsBody?.isDynamic = false
            coin.physicsBody?.categoryBitMask = CollisionType.coin.rawValue
            coin.physicsBody?.collisionBitMask = CollisionType.player.rawValue
            coin.physicsBody?.contactTestBitMask = CollisionType.player.rawValue | CollisionType.target.rawValue
            self.addChild(coin)
            
            let movement = SKAction.move(to: CGPoint(x: coin.position.x, y: -800), duration: 5/*waveSpeed*/)
            let sequence = SKAction.sequence([movement, .removeFromParent()])
            coin.run(sequence)
            
        }
        
        let wait1  = SKAction.wait(forDuration: 0.25)
        let wait3   = SKAction.wait(forDuration:  1.5)
        let spawn   = SKAction.run { spawnCoin() }
        
        // For switch to .wait
        let trialWait = SKAction.wait(forDuration: forDuration)
        
        
        var actionArray: Array<SKAction> = []
        actionArray.append(trialWait)
        // To run coin spawns forever
        //      let forever = SKAction.repeatForever(action)
        
        // To make a for loop that makes a certain number of coins based on a JSON parameter
        for _ in 1...numberOfWaves {
            for _ in 1...numberOfCoins {
                actionArray.append(spawn)
                actionArray.append(wait1)
            }
            actionArray.append(wait3)
        }
        let action = SKAction.sequence(actionArray)
        self.run(action)
    }
    
    func spawnBlueCoinWave(wait forDuration: Double, numberOfCoins: Int, numberOfWaves: Int/*waveSpeed: Int*/) {
        
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
            coin.size = CGSize(width: 60, height: 60)
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
        
        // For switch to .wait
        let trialWait = SKAction.wait(forDuration: forDuration)
        
        
        var actionArray: Array<SKAction> = []
        actionArray.append(trialWait)
        // To run coin spawns forever
        //      let forever = SKAction.repeatForever(action)
        
        // To make a for loop that makes a certain number of coins based on a JSON parameter
        for _ in 1...numberOfWaves {
            for _ in 1...numberOfCoins {
                actionArray.append(spawn)
                actionArray.append(wait1)
            }
            actionArray.append(wait3)
        }
        let action = SKAction.sequence(actionArray)
        self.run(action)
    }
}
