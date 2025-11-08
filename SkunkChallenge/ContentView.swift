//
//  ContentView.swift
//  SkunkChallenge
//
//  Created by Jacobson, Machiah - Student on 11/4/25.
//
import SwiftUI
import AudioToolbox

struct ContentView: View {
    @State private var player1Score = 0
    @State private var player2Score = 0
    @State private var roundScore = 0
    @State private var currentPlayer = 1
    @State private var dice1 = 1
    @State private var dice2 = 1
    @State private var winnerAlert = false
    @State private var winnerName = ""
    
    var body: some View {
        NavigationStack {
            
        
            ZStack {
                Color.blue
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        
                        ScoreCardView(score: player2Score, color: .yellow)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                        Image("skunkLogo")
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .frame(width: 300, height: 300)
                        
                        Text("🤖 CPU")
                            .font(.system(size: 50))
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    
                    Spacer()
                    HStack {
                        NavigationLink(destination: Instructions()) {
                            Text("How to Play?")
                                .frame(width: 200)
                                .background(Color.white)
                                .cornerRadius(20)
                                .foregroundColor(.black)
                                .font(.system(size: 30))
                            
                        }
                        VStack(spacing: 10) {
                            Image("dice")
                                .resizable()
                                .cornerRadius(10)
                                .scaledToFit()
                                .frame(width: 150, height: 150)
                                .padding()
                            
                            Text("\(dice1)         \(dice2)")
                                .font(.system(size: 70))
                                .foregroundColor(.black)
                                .bold(true)
                            
                        }
                        .padding(70)
                        NavigationLink(destination: fourPlayers()) {
                            Text("4 Players")
                                .frame(width: 200)
                                .background(Color.white)
                                .cornerRadius(20)
                                .foregroundColor(.black)
                                .font(.system(size: 30))
                            
                        }
                    }
                    
                    Spacer()
                    
                    HStack {
                        Text("👤 Player 1")
                            .font(.system(size: 50))
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("\(currentPlayer == 1 ? "Player 1" : "CPU")")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                        
                        ScoreCardView(score: player1Score, color: .yellow)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.trailing)
                    }
                    
                    VStack {
                        HStack {
                            Button(action: rollDice) {
                                Text("🎲Roll")
                                    .padding()
                                    .frame(width: 200)
                                    .background(Color.green)
                                    .cornerRadius(20)
                                    .foregroundColor(.white)
                                    .font(.system(size: 50))
                            }
                            
                            Button(action: passTurn) {
                                Text("➡️Pass")
                                    .padding()
                                    .frame(width: 200)
                                    .background(Color.red)
                                    .cornerRadius(20)
                                    .foregroundColor(.white)
                                    .font(.system(size: 50))
                            }
                        }
                        .padding(.bottom, 50)
                        Text("Round Score")
                            .foregroundColor(.white)
                            .font(.title)
                        Text("\(roundScore)")
                            .font(.system(size: 40))
                            .foregroundColor(.white)
                        
                        
                    }
                    .padding()
                    
                }
            }
        }
        .alert(isPresented: $winnerAlert) {
            Alert(title: Text("🏆 Game Over"),
                  message: Text("\(winnerName) Wins!"),
                  dismissButton: .default(Text("Restart"), action: resetGame))
        }
    }
    
    func rollDice() {
        dice1 = Int.random(in: 1...6)
        dice2 = Int.random(in: 1...6)
        
        if dice1 == 1 || dice2 == 1 {
            roundScore = 0
            switchTurn()
            AudioServicesPlaySystemSound(1006)

        } else {
            roundScore += dice1 + dice2
        }
    }
    
    func passTurn() {
        if currentPlayer == 1 {
            player1Score += roundScore
            if player1Score >= 100 {
                winnerName = "Player 1"
                winnerAlert = true
                return
            }
            switchTurn()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                cpuTurn()
            }
        } else {
            player2Score += roundScore
            if player2Score >= 100 {
                winnerName = "CPU"
                winnerAlert = true
                return
            }
            switchTurn()
        }
    }
    
    func cpuTurn() {
        var cpuRolls = 0
        while currentPlayer == 2 && cpuRolls < 3 {
            rollDice()
            if roundScore == 0 { return }
            cpuRolls += 1
        }
        passTurn()
    }
    
    func switchTurn() {
        roundScore = 0
        currentPlayer = (currentPlayer == 1) ? 2 : 1
    }
    
    func resetGame() {
        player1Score = 0
        player2Score = 0
        roundScore = 0
        currentPlayer = 1
        dice1 = 1
        dice2 = 1
    }
}

struct ScoreCardView: View {
    var score: Int
    var color: Color
    
    var body: some View {
        Text("Score: \(score)")
            .padding()
            .background(color)
            .cornerRadius(10)
            .foregroundColor(.black)
            .font(.system(size: 50))
    }
}

#Preview {
    ContentView()
}
