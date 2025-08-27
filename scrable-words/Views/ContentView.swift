//
//  ContentView.swift
//  scrable-words
//
//  Created by Lin Htet Ko Macbook Pro on 20/8/2568 BE.
//

import SwiftUI

struct GametView: View {
    
    @State private var questions = Question.generateQuestions()
    @State private var guessedLetters: [Letter] = []
    @State private var showSuccess = false
    @State private var showFailure = false
    @State private var score = 0
    @State private var currentQuestionIndex = 0
    @State private var showScoreSummary = false
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.background
                VStack {
                    VStack {
                        Spacer()
                        let imgWidth = proxy.size.width * 0.4
                        let imgHeight = proxy.size.width * 0.4
                        Image(questions[currentQuestionIndex].image)
                            .resizable()
                            .frame(width: imgWidth, height: imgHeight)
                        Spacer()
                        HStack {
                            ForEach(guessedLetters) { letter in
                                VStack {
                                    LetterView(letter: letter)
                                    Rectangle()
                                        .frame(width: 30, height: 2)
                                        .foregroundStyle(.white)
                                }.onTapGesture {
                                    if let index = guessedLetters.firstIndex(of: letter) {
                                        guessedLetters.remove(at: index)
                                        questions[currentQuestionIndex].scrambledWords[letter.id].letter = letter.letter
                                    }
                                }
                            }
                        }.padding(.bottom, 30)
                    }.frame(width: proxy.size.width * 0.9, height: proxy.size.width * 0.9)
                        .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.border, lineWidth: 1)
                    }
                    ScoreView(score: score)
                    HStack {
                        ForEach(Array(questions[currentQuestionIndex].scrambledWords.enumerated()), id: \.element) { index, letter in
                            LetterView(letter: letter)
                                .onTapGesture {
                                    if !letter.letter.isEmpty{
                                        guessedLetters.append(letter)
                                        questions[currentQuestionIndex].scrambledWords[index].letter = ""
                                        let wordsCount = questions[currentQuestionIndex].scrambledWords.count
                                        if guessedLetters.count == wordsCount {
                                            let guessedAnswer = guessedLetters.map { $0.letter }.joined()
                                            let correctAnswer = questions[currentQuestionIndex].answer
                                            
                                            if guessedAnswer == correctAnswer {
                                                showSuccess = true
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                                                    showSuccess = false
                                                    score += 1
                                                    if currentQuestionIndex < questions.count - 1 {
                                                        currentQuestionIndex += 1
                                                    } else {
                                                        showScoreSummary = true
                                                        questions = Question.generateQuestions()
                                                        currentQuestionIndex = 0
                                                    }
                                                    
                                                })
                                            } else {
                                                showFailure = true
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                                                    showFailure = false
                                                    if currentQuestionIndex < questions.count - 1 {
                                                        currentQuestionIndex += 1
                                                    } else {
                                                        showScoreSummary = true
                                                        questions = Question.generateQuestions()
                                                        currentQuestionIndex = 0
                                                    }
                                                })
                                            }
                                            guessedLetters.removeAll()
                                        }
                                    }
                                }
                        }
                    }
                }
                if showFailure {
                    FailureDialog()
                }
                if showSuccess {
                    SuccessDialog()
                }
            }.sheet(isPresented: $showScoreSummary) {
                showScoreSummary = false
            } content: {
                ScoreSummaryView(correct: score, total: questions.count)
            }

        }.ignoresSafeArea()
    }
}

#Preview {
    GametView()
}

struct LetterView: View {
    let letter: Letter
    var body: some View {
        Text(letter.letter)
            .frame(width: 30, height: 30)
            .foregroundStyle(.white)
            .background(.white.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}

struct SuccessDialog: View {
    var body: some View {
        ZStack {
            Color.black
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .opacity(0.4)
            Image("tick")
        }
    }
}

struct FailureDialog: View {
    var body: some View {
        ZStack {
            Color.black
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .opacity(0.4)
            Image("cross")
        }
    }
}

struct ScoreView: View {
    let score: Int
    var body: some View {
        Text("Score \(score)")
            .font(.system(size: 15))
            .foregroundStyle(.white)
            .padding(.top)
    }
}
