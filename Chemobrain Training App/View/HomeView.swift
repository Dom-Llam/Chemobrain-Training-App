//
//  HomeView.swift
//  Chemobrain Training App
//
//  Created by Dominic Bieniewski on 6/16/21.
//

import SwiftUI

struct HomeView: View {
    
    // To track page observable object
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        
        ScrollView {
            
            VStack {
                
                GeometryReader { geo in
                    Image("SNAPLabBanner")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geo.size.width)
                }
                .frame(height: 200)

                HStack {
                    VStack {
                        Text("Welcome back, user!")
                    }
                    
                }
                .padding()
                .frame(width: 700, height: 100, alignment: .center)
                .background(Color.yellow)
                .cornerRadius(20)
                
                HStack {
                    VStack {
                        Image("robot")
                        Text("You're from the future!")
                    }
                    
                    VStack {
                        Image("person")
                        Text("You're an adventurer!")
                    }
                    
                    VStack {
                        Image("zombie")
                        Text("Battle the magical undead!")
                    }
                }
                .padding()
                .frame(width: 700, height: 300, alignment: .center)
                .background(Color.secondary)
                .cornerRadius(20)
                
                HStack {
                    VStack {
                        Image("robot")
                        Text("You're from the future!")
                    }
                    
                    Button(action: {
                        viewModel.playGame()
                    }, label: {
                        Text("Let's Play!")
                            .foregroundColor(Color.blue)
                    })
                }
                .padding()
                .frame(width: 700, height: 300, alignment: .center)
                .background(Color.secondary)
                .cornerRadius(20)
                
                HStack {
                    Text("We did it!")
                    
                    Button(action: {
                        viewModel.signOut()
                    }, label: {
                        Text("SignOut")
                            .buttonStyle(MyButtonStyle(color: .blue))
                            .foregroundColor(Color.white)
                    })
                }
                .padding()
                .frame(width: 700, height: 200, alignment: .center)
                .background(Color.secondary)
                .cornerRadius(20)
                
                HStack {
                    VStack {
                        Text("Some awards you've already acheived!")
                    }
                    
                }
                .padding()
                .frame(width: 700, height: 100, alignment: .center)
                .background(Color.purple)
                .cornerRadius(20)
                
                HStack {
                    VStack {
                        Text("Awards you're currently working on!")
                    }
                    
                }
                .padding()
                .frame(width: 700, height: 100, alignment: .center)
                .background(Color.orange)
                .cornerRadius(20)
            }
        }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
