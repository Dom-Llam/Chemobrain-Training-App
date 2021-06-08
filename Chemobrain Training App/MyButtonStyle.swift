//
//  MyButtonStyle.swift
//  Chemobrain Training App
//
//  Created by Dominic Bieniewski on 6/8/21.
//

import SwiftUI

struct ExampleView: View {
    var body: some View {
        VStack {
            Button("Tap me") {
                print("Button pressed")
            }.buttonStyle(MyButtonStyle(color: .blue))
        }
    }
}

struct MyButtonStyle: ButtonStyle {
    var color: Color = . green
    
    public func makeBody(configuration: MyButtonStyle.Configuration) -> some View {
        MyButton(configuration: configuration, color: color)
    }
    
    struct MyButton: View {
        let configuration: MyButtonStyle.Configuration
        let color: Color
        
        var body: some View {
            return configuration.label
                .foregroundColor(.white)
                .padding(15)
                .background(RoundedRectangle(cornerRadius: 5).fill(color))
                .compositingGroup()
                .shadow(color: .black, radius: 3)
                .opacity(configuration.isPressed ? 0.5 : 1.0)
        }
    }
}

struct MyButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView()
    }
}
