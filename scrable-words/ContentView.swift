//
//  ContentView.swift
//  scrable-words
//
//  Created by Lin Htet Ko Macbook Pro on 20/8/2568 BE.
//

import SwiftUI

struct ContentView: View {
    
    private let letters = "ORANGE".split(separator: "")
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.background
                VStack {
                    VStack {
                        Spacer()
                        Image("orange")
                            .resizable()
                            .frame(width: proxy.size.width * 0.4, height: proxy.size.width * 0.4)
                        Spacer()
                        VStack {
                            LetterView(character: "0")
                            Rectangle()
                                .frame(width: 30, height: 2)
                                .foregroundStyle(.white)
                        }.padding(.bottom, 30)
                    }.frame(width: proxy.size.width * 0.9, height: proxy.size.width * 0.9)
                        .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.border, lineWidth: 1)
                    }
                    Text("Score 0")
                        .font(.system(size: 15))
                        .foregroundStyle(.white)
                        .padding(.top)
                    HStack {
                        ForEach(letters, id: \.self) { letter in
                            LetterView(character: String(letter))
                        }
                    }
                }
            }
        }.ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}

struct LetterView: View {
    let character: String
    var body: some View {
        Text(character)
            .frame(width: 30, height: 30)
            .foregroundStyle(.white)
            .background(.white.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}
