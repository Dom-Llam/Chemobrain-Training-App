//
//  ExtensionSpriteKitScene.swift
//  Chemobrain Training App
//
//  Created by Dominic Bieniewski on 8/23/21.
//

import SpriteKit

extension SpriteKitScene {

    // URLrequest to fetch JSON file from the Medical College server
    func urlFetchJSON() {
       let url = URL(string: "https://www.eng.mu.edu/snaplab/test-trial.json")!


        let task = URLSession.shared.dataTask(with: url) { [self](data, response, error) in
            guard let data = data else { return }
//            print(String(data: data, encoding: .utf8)!)
            let decoder = JSONDecoder()
            guard let loaded = try? decoder.decode([TrialType].self, from: data) else {
                fatalError("failed to decode")
            }
            trialTypes = loaded
            }

        task.resume()
    }
    
    // Func to generate right cue flash
    func flashRightCircle(wait forDuration: Double) {
        //To trigger timer logic
        let timerTrigger = SKAction.customAction(withDuration: 0) { _,_ in
            self.onlyOne = true
            self.onlyTwo = true

            self.targetResponse = false
        }
        let wait10 = SKAction.wait(forDuration: 4)
        let wait1 = SKAction.wait(forDuration: 0.25)
        // For switch to .wait
        let trialWait = SKAction.wait(forDuration: forDuration)
        

        let sequence = SKAction.sequence([trialWait, wait10, visible, timerTrigger, wait1, invisible])
        rightCircle.run(sequence)
    }
    
    // Func to generate left cue flash
    func flashLeftCircle(wait forDuration: Double) {
        //To trigger timer logic
        let timerTrigger = SKAction.customAction(withDuration: 0) { _,_ in
            self.onlyOne = true
            self.onlyTwo = true

            self.targetResponse = false
        }
        let wait10 = SKAction.wait(forDuration: 4)
        let wait1 = SKAction.wait(forDuration: 0.25)
        // For switch to .wait
        let trialWait = SKAction.wait(forDuration: forDuration)
        
        let sequence = SKAction.sequence([trialWait, wait10, visible, timerTrigger, wait1, invisible])
        leftCircle.run(sequence)
    }
    
    // Func to generate dual cue condition
    func flashBothCircles(wait forDuration: Double) {
        //To trigger timer logic
        let timerTrigger = SKAction.customAction(withDuration: 0) { [self] _,_ in
            // For the RT boolean in update
            self.onlyOne = true
            self.onlyTwo = true
            self.targetResponse = false
        }
        
        let wait10 = SKAction.wait(forDuration: 4)
        let wait1 = SKAction.wait(forDuration: 0.25)
        // For switch to .wait
        let trialWait = SKAction.wait(forDuration: forDuration)
        

        let sequence = SKAction.sequence([trialWait, wait10, timerTrigger, visible, wait1, invisible])
        leftCircle.run(sequence)
        rightCircle.run(sequence)
    }
    
    // For the noCue condition /// Not currently used
    func flashNoCircles(wait forDuration: Double) {
        //To trigger timer logic
        let timerTrigger = SKAction.customAction(withDuration: 0) { [self] _,_ in
            // For the RT boolean in update
            self.onlyOne = true
            self.targetResponse = false
        }
        
        let wait10 = SKAction.wait(forDuration: 4)
        let wait1 = SKAction.wait(forDuration: 0.25)
        // For switch to .wait
        let trialWait = SKAction.wait(forDuration: forDuration)
        

        let sequence = SKAction.sequence([trialWait, wait10, timerTrigger, visible, wait1, invisible])
        
        noCircle.run(sequence)
    }
    
    
    func spawnRightBlueTarget(wait forDuration: Double) {
  
        let movement = SKAction.move(to: CGPoint(x: 275, y: 0), duration: 0.75)
        let wait1 = SKAction.wait(forDuration: 1)
        let wait5 = SKAction.wait(forDuration: 8)
        
        // For switch to .wait
        let trialWait = SKAction.wait(forDuration: forDuration)
        
        let rotateAction = SKAction.rotate(byAngle: .pi, duration: 4)
        let repeatRotation = SKAction.repeatForever(rotateAction)
        let sequence = SKAction.sequence([trialWait, resetRightTarget, targetVisible, wait1, movement, wait5, invisible, resetRightTarget/*, movement2, .removeFromParent()*/])
        
        rightBlueTarget.run(repeatRotation)
        rightBlueTarget.run(sequence)
    }
    
    func spawnRightYellowTarget(wait forDuration: Double) {
        
        let movement = SKAction.move(to: CGPoint(x: 275, y: 0), duration: 0.75)
        let wait1 = SKAction.wait(forDuration: 1)
        let wait5 = SKAction.wait(forDuration: 8)
        
        // For switch to .wait
        let trialWait = SKAction.wait(forDuration: forDuration)
        
        let rotateAction = SKAction.rotate(byAngle: .pi, duration: 4)
        let repeatRotation = SKAction.repeatForever(rotateAction)
        let sequence = SKAction.sequence([trialWait, resetRightTarget, targetVisible, wait1, movement, wait5, invisible, resetRightTarget/*, movement2, .removeFromParent()*/])
        
        rightYellowTarget.run(repeatRotation)
        rightYellowTarget.run(sequence)
    }
    
    func spawnLeftYellowTarget(wait forDuration: Double) {

        let movement = SKAction.move(to: CGPoint(x: -275, y: 0), duration: 0.75)
        let wait1 = SKAction.wait(forDuration: 1)
        let wait5 = SKAction.wait(forDuration: 8)
        
        // For switch to .wait
        let trialWait = SKAction.wait(forDuration: forDuration)
        
        let rotateAction = SKAction.rotate(byAngle: .pi, duration: 4)
        let repeatRotation = SKAction.repeatForever(rotateAction)
        let sequence = SKAction.sequence([trialWait, resetLeftTarget, targetVisible, wait1, movement, wait5, invisible, resetLeftTarget/*, movement2, .removeFromParent()*/])
        
        leftYellowTarget.run(repeatRotation)
        leftYellowTarget.run(sequence)
    }
    
    func spawnLeftBlueTarget(wait forDuration: Double) {

        let movement = SKAction.move(to: CGPoint(x: -275, y: 0), duration: 0.75)
        let wait1 = SKAction.wait(forDuration: 1)
        let wait5 = SKAction.wait(forDuration: 8)
        
        // For switch to .wait
        let trialWait = SKAction.wait(forDuration: forDuration)
        
        let rotateAction = SKAction.rotate(byAngle: .pi, duration: 4)
        let repeatRotation = SKAction.repeatForever(rotateAction)
        let sequence = SKAction.sequence([trialWait, resetLeftTarget, targetVisible, wait1, movement, wait5, invisible, resetLeftTarget/*, movement2, .removeFromParent()*/])
        
        leftBlueTarget.run(repeatRotation)
        leftBlueTarget.run(sequence)
    }
    
    func spawnYellowCoinWave(wait forDuration: Double, numberOfCoins: Int, numberOfWaves: Int, waveSpacer: Double/*waveSpeed: Int*/) {
        
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
        let waveSpacer   = SKAction.wait(forDuration:  waveSpacer)
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
            actionArray.append(waveSpacer)
        }
        let action = SKAction.sequence(actionArray)
        self.run(action)
    }
    
    func spawnBlueCoinWave(wait forDuration: Double, numberOfCoins: Int, numberOfWaves: Int, waveSpacer: Double/*waveSpeed: Int*/) {
        
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
        let waveSpacer   = SKAction.wait(forDuration:  waveSpacer)
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
            actionArray.append(waveSpacer)
        }
        let action = SKAction.sequence(actionArray)
        self.run(action)
    }
}
