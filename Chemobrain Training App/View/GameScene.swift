//
//  GameScene.swift
//  Chemobrain Training App
//
//  Created by Dominic Bieniewski on 6/24/21.
//

import SwiftUI
import SpriteKit

class Game: SKScene {
    override func didMove(to view: SKView) {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        let box = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 50))
        box.position = location
        box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        addChild(box)
    }
}

// just temporary button build /hackingwithswift
struct BlueButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color(red: 0, green: 0, blue: 0.5))
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}

struct GameScene: View {
    
    // To track time for each game session
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @State var seconds: Float = 0.0
    
    // To track page observable object
    @EnvironmentObject var viewModel: AppViewModel
    
    //For SKscene being added to swiftui view
    var scene: SKScene {
        let scene = Game()
        scene.size = CGSize(width: 700, height: 800)
        scene.scaleMode = .fill
        return scene
    }
 
    var body: some View {
        
        VStack {
            SpriteView(scene: scene)
                .frame(width: 700, height: 800)
            
            Text("Time in session: \(seconds)").onReceive(timer) { input in
                self.seconds += 0.01
            }
            
            Button(action: {
                viewModel.playGame()
                
            }, label: {
                Text("Let's Play!")
                    .foregroundColor(Color.blue)
            })
            .buttonStyle(BlueButton())
        }
        .cornerRadius(10)
    }
}

struct GameScene_Previews: PreviewProvider {
    static var previews: some View {
        GameScene()
    }
}
