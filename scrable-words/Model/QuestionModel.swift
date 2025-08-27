//
//  QuestionModel.swift
//  scrable-words
//
//  Created by Lin Htet Ko Macbook Pro on 26/8/2568 BE.
//

import Foundation


struct Question {
    let image: String
    var scrambledWords: [Letter]
    let answer: String
}

extension Question {
    
    static func generateQuestions() -> [Question] {
        return [
            Question(image: "orange", scrambledWords: [
                Letter(id: 0, letter: "G"),
                Letter(id: 1, letter: "N"),
                Letter(id: 2, letter: "O"),
                Letter(id: 3, letter: "A"),
                Letter(id: 4, letter: "R"),
                Letter(id: 5, letter: "E")
            ], answer: "ORANGE"),
            Question(image: "banana", scrambledWords: [
                Letter(id: 0, letter: "N"),
                Letter(id: 1, letter: "N"),
                Letter(id: 2, letter: "A"),
                Letter(id: 3, letter: "B"),
                Letter(id: 4, letter: "A"),
                Letter(id: 5, letter: "A")
            ], answer: "BANANA"),
            Question(image: "apple", scrambledWords: [
                Letter(id: 0, letter: "L"),
                Letter(id: 1, letter: "P"),
                Letter(id: 2, letter: "A"),
                Letter(id: 3, letter: "P"),
                Letter(id: 4, letter: "E")
            ], answer: "APPLE"),
        ]
    }
}
