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
                        GeometryReader { geo in
                            Image("MCWLogo_1200")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200, height: 200)
                        }
                        .frame(width: 200, height: 200, alignment: .leading)
                        
                    }
                    .frame(width:200, height: 200, alignment: .leading)
                    Text("Welcome back, let's train!")
                        .font(.title)
                }
                .padding()
                .frame(width: 700, height: 200, alignment: .center)
                .background(Color.white)
                .cornerRadius(20)
                
//                HStack {
//                    VStack {
//                        Image("robot")
//                        Text("You're from the future!")
//                    }
//
//                    VStack {
//                        Image("person")
//                        Text("You're an adventurer!")
//                    }
//
//                    VStack {
//                        Image("zombie")
//                        Text("Battle the magical undead!")
//                    }
//                }
//                .padding()
//                .frame(width: 700, height: 300, alignment: .center)
//                .background(Color.secondary)
//                .cornerRadius(20)
//
                HStack {
                    VStack {
                        Image("robot")
                        Text("It's space time!")
                    }
                    
                    Button(action: {
                        viewModel.playGame()
                        
                        // After duration of trial toggle again to get out?
                        DispatchQueue.main.asyncAfter(deadline: .now() + 245) {
                            viewModel.playGame()
                        }
                    }, label: {
                        Text("Let's Play!")
                            .foregroundColor(Color.black)
                    })
                }
                .padding()
                .frame(width: 700, height: 300, alignment: .center)
                .background(Color(red: 246/255, green: 160/255, blue: 12/255))
                .cornerRadius(20)
                
                HStack {
                    Text("It's time to take the ANT for the week!")
                    
                    Button(action: {
                        // The action to trigger the ANT
                    }, label: {
                        Text("Take me to the ANT")
                            .buttonStyle(MyButtonStyle(color: .blue))
                            .foregroundColor(Color.white)
                    })
                }
                .padding()
                .frame(width: 700, height: 200, alignment: .center)
                .background(Color(red: 19/255, green: 95/255, blue: 83/255))
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
                .background(Color(red: 11/255, green: 51/255, blue: 125/255))
                .cornerRadius(20)
                
                HStack {
                    VStack {
                        Text("Some awards you've already acheived!")
                            .foregroundColor(.white)
                            .font(.title)
                    }
                    
                }
                .padding()
                .frame(width: 700, height: 100, alignment: .center)
                .background(Color(red: 2/255, green: 18/255, blue: 76/255))
                .cornerRadius(20)
                
                HStack {
                    VStack {
                        Text("Awards you're currently working on!")
                            .font(.title)
                    }
                    
                }
                .padding()
                .frame(width: 700, height: 100, alignment: .center)
                .background(Color(red: 245/255, green: 184/255, blue: 15/255))
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
