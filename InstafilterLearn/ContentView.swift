//
//  ContentView.swift
//  InstafilterLearn
//
//  Created by Rishav Gupta on 23/06/23.
//

import SwiftUI

struct ContentView: View {
    
    // State here is a struct and all the string, int or double are inside the structs as properties. Ideally we cannot modify our properties in our views as they are structs, thus we needed @State to actually change the properties of our views but State is also a struct.
    // State has `public var wrappedValue: Value { get nonmutating set }` a non mutating set, which is when we set the value of this state wrapper, it wont actually change the state of the stuct itself. Behind the scenes it gets set up with SwiftUI. SwiftUI stores that separately so that it can be modified freely.
    @State private var blurAmount = 0.0 {
        didSet {
            // When the blur amount changes, run the didSet observer.
            // But State actually wraps its content into a new struct.
            // So when the State struct that contains blurAmount changes, print out the new blurAmount.
            // State wraps its value using a non mutating setting, which means neither blur amount nor State struct wrapping it is changing, out binding is directly changing the internally stored value. Which means didSet is never being triggered.
            // Changing it using a button goes through a non mutating setter, thus didSet is triggered.
            // But using a slider, we are poking it around and bypassing it and adjusting it directly.
//            print("New value is \(blurAmount)")
        }
    }
    
    
    @State private var showingConfirmation = false
    @State private var backgroundColor = Color.white
    
    var body: some View {
        VStack {
            Text("Hello World!")
                .blur(radius: blurAmount)
                .frame(width: 300, height: 300)
                .background(backgroundColor)
                .onTapGesture {
                    showingConfirmation = true
                }
            
            Slider(value: $blurAmount, in: 0...20)
            
            Button("Random Blur") {
                blurAmount = Double.random(in: 0...20)
            }
        }
        .onChange(of: blurAmount) { newValue in
//            print("New value is \(newValue)")
        }
        .confirmationDialog("Change Background", isPresented: $showingConfirmation) {
            Button("Red") { backgroundColor = .red }
            Button("Green") { backgroundColor = .green }
            Button("Blue") { backgroundColor = .blue }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Select a new color")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
