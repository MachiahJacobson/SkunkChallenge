//
//  fourPlayers.swift
//  SkunkChallenge
//
//  Created by Jacobson, Machiah - Student on 11/5/25.
//

import SwiftUI

struct fourPlayers: View {
    @State private var scores = [0, 0, 0, 0]
    @State private var roundScore = 0
    @State private var currentPlayer = 0
    @State private var dice1 = 1
    @State private var dice2 = 1
    @State private var winnerAlert = false
    @State private var winnerName = ""
    
    var body: some View {
        ZStack {
            Color.purple
                .ignoresSafeArea()
            
            VStack {
                Text("Skunk 4 Player Mode")
                    .font(.system(size: 60, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top)
                
                Spacer()
                
                HStack {
                    ForEach(0..<4) { i in
                        VStack {
                            Text("👤 P\(i+1)")
                                .font(.title)
                                .foregroundColor(currentPlayer == i ? .green : .white)
                            Text("\(scores[i])")
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(.yellow)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .padding()
                
                Spacer()
                
                VStack(spacing: 10) {
                    Image("dice")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                    
                    Text("\(dice1)         \(dice2)")
                        .font(.system(size: 60))
                        .bold()
                        .foregroundColor(.white)
                }
                .padding()
                
                Spacer()
                
                HStack(spacing: 40) {
                    Button(action: rollDice) {
                        Text("🎲 Roll")
                            .frame(width: 150, height: 70)
                            .background(Color.green)
                            .cornerRadius(15)
                            .foregroundColor(.white)
                            .font(.system(size: 40))
                    }
                    
                    Button(action: passTurn) {
                        Text("➡️ Pass")
                            .frame(width: 150, height: 70)
                            .background(Color.red)
                            .cornerRadius(15)
                            .foregroundColor(.white)
                            .font(.system(size: 40))
                    }
                }
                
                VStack {
                    Text("Round Score: \(roundScore)")
                        .foregroundColor(.white)
                        .font(.title)
                        .padding(.top)
                }
                
                Spacer()
            }
        }
        .alert(isPresented: $winnerAlert) {
            Alert(
                title: Text("🏆 Game Over"),
                message: Text("\(winnerName) Wins!"),
                dismissButton: .default(Text("Restart"), action: resetGame)
            )
        }
    }
    func rollDice() {
        dice1 = Int.random(in: 1...6)
        dice2 = Int.random(in: 1...6)
        
        if dice1 == 1 || dice2 == 1 {
            roundScore = 0
            switchTurn()
        } else {
            roundScore += dice1 + dice2
        }
    }
    
    func passTurn() {
        scores[currentPlayer] += roundScore
        if scores[currentPlayer] >= 100 {
            winnerName = "Player \(currentPlayer + 1)"
            winnerAlert = true
            return
        }
        switchTurn()
    }
    
    func switchTurn() {
        roundScore = 0
        currentPlayer = (currentPlayer + 1) % 4
    }
    
    func resetGame() {
        scores = [0, 0, 0, 0]
        roundScore = 0
        currentPlayer = 0
        dice1 = 1
        dice2 = 1
    }
}
#Preview {
    fourPlayers()
}
