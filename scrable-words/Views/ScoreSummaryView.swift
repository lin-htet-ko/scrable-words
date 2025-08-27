//
//  ScoreSummaryView.swift
//  scrable-words
//
//  Created by Lin Htet Ko Macbook Pro on 27/8/2568 BE.
//

import SwiftUI

struct ScoreSummaryView: View {
    let correct: Int
    let total: Int
    
    var body: some View {
        ZStack {
            Color.black
            VStack {
                Image("tick")
                Text("Score \(correct)/\(total)")
                    .padding(.top)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(.white)
            }
        }.ignoresSafeArea()
    }
}

#Preview {
    ScoreSummaryView(correct: 1, total: 3)
}
