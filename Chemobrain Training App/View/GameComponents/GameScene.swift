//
//  GameScene.swift
//  Chemobrain Training App
//
//  Created by Dominic Bieniewski on 6/24/21.
//

import SwiftUI
import SpriteKit



struct GameScene: View {
    // For environment object to exit game
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var viewManager = AppViewModel.shared
    
    // To track page observable object
    @EnvironmentObject var viewModel: AppViewModel
    var timer = Timer()
    
    //For SKscene being added to swiftui view
    var scene: SKScene {
        let scene = SpriteKitScene(/*viewModel: viewModel*/)
        scene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        scene.scaleMode = .fill
        return scene
        
        
    }
 
var body: some View {
    
    
    
    ZStack {
        SpriteView(scene: scene)
        // Another attempt to exit game
//        if viewManager.exitView {
//            Button {
//                presentationMode.wrappedValue.dismiss()
//
//                viewModel.playGame()
//
//                viewManager.exitView = false
//
//            } label: {
//                Image(systemName: "arrow.uturn.left")
//            }
//        }

            VStack(alignment: .leading) {
//                Text("Score: \(viewModel.score)")
//                    .font((.system(size: 32, weight: .heavy, design: .rounded)))
//                    .padding(.trailing, 100)
//                    .padding(.top, 42)
//                    .foregroundColor(.white)
                Spacer()
                
                //Another attempt at making lanes
                    HStack {
                        Path { path in
                                path.move(to: CGPoint(x: 190, y: 850))
                                path.addQuadCurve(to: CGPoint(x: 405, y: 0), control: CGPoint(x: 150, y: 50))
                            }
                        .stroke(Color.white, lineWidth: 0.5)
                            .frame(width: 100, height: 850)
                        Path { path in
                                path.move(to: CGPoint(x: 200, y: 850))
                                path.addQuadCurve(to: CGPoint(x: 290, y: 0), control: CGPoint(x: 175, y: 50))
                            }
                        .stroke(Color.white, lineWidth: 0.5)
                            .frame(width: 100, height: 850)
                        Path { path in
                                path.move(to: CGPoint(x: 290, y: 850))
                                path.addQuadCurve(to: CGPoint(x: 190, y: 0), control: CGPoint(x: 325, y: 50))
                            }
                        .stroke(Color.white, lineWidth: 0.5)
                            .frame(width: 100, height: 850)
                        Path { path in
                                path.move(to: CGPoint(x: 300, y: 850))
                                path.addQuadCurve(to: CGPoint(x: 90, y: 0), control: CGPoint(x: 350, y: 25))
                            }
                        .stroke(Color.white, lineWidth: 0.5)
                            .frame(width: 100, height: 850)


                    Spacer()
                    }
                
                
            }
            .ignoresSafeArea()
            .frame(maxWidth: .infinity, alignment: .trailing)
            
        
    }
    .ignoresSafeArea()
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

struct GameScene_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GameScene()
            GameScene()
        }
    }
}
