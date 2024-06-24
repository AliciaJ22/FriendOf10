//
//  ShopPageView.swift
//  FriendOF10(Test)
//
//  Created by Alicia Jude on 4/6/2024.
//

import SwiftUI

struct QuizPageView: View {
    
    @ObservedObject var sharedData = SharedData.shared
    @State private var selectedAnswer: Int = 0
    @State private var correctAnswer: Int = 0
    @State private var question: String = ""
    @State private var pointScore: Int = 0
    @State private var QuestionLeft: Int = 5
    @State private var Number: Int = 5
    @State private var images: [String] = Array(repeating: "Grey", count: 5)
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        NavigationStack{
            ZStack{
                //TITLE
                VStack{
                    Image("title.png")
                        .resizable()
                        .scaledToFit()
                        .frame(width:390, height:70)
                }
                .offset(y: -300)
                //Shows if user got answer correct, turns red or green if user got answer correct or incorrect
                HStack {
                    ForEach(0..<Number, id: \.self) { index in
                        Image(images[index])
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding(5)
                    }
                }
                .frame(width: 380, height: 70)
                .offset(y:-230)
                
                if QuestionLeft > 0 {
                    ZStack {
                        ZStack{
                            Image("AskQuestion")
                                .resizable()
                                .frame(width: 350, height: 150)
                            
                            
                            Text(question)
                                .font(.system(size: 50, weight: .bold, design: .default))
                                .fontWeight(.black)
                                .padding()
                                .offset(x: -115)
                        }
                        .offset(y: -120)
                        
                        VStack {
                            Picker("Select x", selection: $selectedAnswer) {
                                ForEach(0...10, id: \.self) { number in
                                    Text("\(number)").tag(number)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: 100, height: 150)
                            .clipped()
                            .padding()
                        }
                        .offset(y: 50)
                        
                        
                        VStack {
                            Button(action: checkAnswer) {
                                Image("Enter")
                                    .resizable()
                                    .frame(width: 250, height: 120)
                            }
                            .padding()
                        }
                        .offset(y: 200)
                        
                        
                        Text("Points: \(pointScore)")
                            .font(.system(size: 50, weight: .bold, design: .default))
                            .padding()
                            .foregroundColor(.black)
                            .offset(y: 300)
                    }
                    
                    .onAppear(perform: generateQuestion)
                    .padding()
                } else {
                    //Changed button from a navigation stack to a presentationMode so instead of adding another stack it removes a stack and goes back into the homepage
                    ZStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                            sharedData.PointTotal += pointScore
                        }) {
                            Image("Go")
                                .resizable()
                                .frame(width: 200, height: 100)
                        }
                    }
                    .offset(y:300)
                    
                    
                    //Shows End button & pointScore
                    Image("QuizEnd")
                        .resizable()
                        .frame(width: 430,height: 400)
                    Text("\(pointScore)")
                        .font(.system(size: 50, weight: .bold, design: .default))
                        .offset(y: 40)
                }
            }
        }
    }
    //Randomises Numbers from 1-10 to add to the question
    func generateQuestion() {
        if QuestionLeft > 0 {
            let a = Int.random(in: 0...10)
            let b = 10 - a
            question = "\(a)"
            correctAnswer = b
            selectedAnswer = 0
        }
    }
    //Checks the answers if it is correct or not
    func checkAnswer() {
        if selectedAnswer == correctAnswer {
            //When correct add 2 & Change circle to green
            pointScore += 2
            images[5 - QuestionLeft] = "Green"
        } else {
            //else change to red
            images[5 - QuestionLeft] = "Red"
        }
        QuestionLeft -= 1
        generateQuestion()
    }
    
    
    
}

    
#Preview {
    QuizPageView()
}


