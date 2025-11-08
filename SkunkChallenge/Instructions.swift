//
//  Instructions.swift
//  SkunkChallenge
//
//  Created by Jacobson, Machiah - Student on 11/5/25.
//

import SwiftUI

struct Instructions: View {
    var body: some View {
        
        ZStack {
            Image("note")
                .resizable()
                .scaledToFit()
                .edgesIgnoringSafeArea(.all)
            Text("Instructions")
                .font(.system(size: 100))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding(50)
                .padding(.bottom, 1000)
            Text("Players try to accumulate 100 points. In each round, players roll two dice and add the sum to their score for that round, but they must decide when to pass thair turn, and how many points are sefice for that round. If a one is rolled a skunk, you lose all of your points for that round.")
                .font(.system(size: 40))
                .frame(width: 400, height: 700)
                .offset(x: 100, y: -130)
        }
    }
}

#Preview {
    Instructions()
}
