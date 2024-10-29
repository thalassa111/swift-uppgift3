//
//  ContentView.swift
//  swift-uppgift3
//
//  Created by Dennis on 2024-10-29.
//

import SwiftUI

struct ContentView: View {
    @State private var setupText = ""
    @State private var deliveryText = ""
    @State private var setupOpacity: Double = 0.0
    @State private var deliveryOpacity: Double = 0.0
    @State private var isButtonEnabled: Bool = true
    
    var body: some View {
        VStack {
            Button(action: {
                isButtonEnabled = false
                Task{
                    setupText = ""
                    deliveryText = ""
                    setupOpacity = 0.0
                    deliveryOpacity = 0.0
                    
                    let (setup, delivery) = await getJoke()
                    setupText = setup
                    withAnimation(.easeIn(duration: 1.0)) {
                        setupOpacity = 1.0
                    }
                    
                    try? await Task.sleep(nanoseconds: 3 * 1_000_000_000)
                    deliveryText = delivery
                    
                    withAnimation(.easeIn(duration: 1.0)) {
                        deliveryOpacity = 1.0
                    }
                    try? await Task.sleep(nanoseconds: 4 * 1_000_000_000)
                    isButtonEnabled = true
                }
            }, label: {
                Text(isButtonEnabled ? "Press me!" : "Wait a little!")
                    .padding()
                    .background(isButtonEnabled ? Color.blue : Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            })
            .disabled(!isButtonEnabled)
        }
        .padding()
        
        Text(setupText)
            .padding()
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .foregroundColor(.black)
            .opacity(setupOpacity)
        
        Text(deliveryText)
            .padding()
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .foregroundColor(.black)
            .opacity(deliveryOpacity)
    }
}

func getJoke() async -> (String, String){
    let jokeAPI = "https://v2.jokeapi.dev/joke/Any"
    let jokeURL = URL(string: jokeAPI)
    do{
        let (jokeData, _) = try await URLSession.shared.data(from: jokeURL!)
        let joke = try JSONDecoder().decode(Joke.self, from: jokeData)
        return (joke.setup, joke.delivery)
    } catch{
        return ("error  fetching joke", "please try again")
    }
}

#Preview {
    ContentView()
}
