//
//  Game.swift
//  Bullseye
//
//  Created by Frédéric Helfer on 05/10/22.
//

import Foundation

struct LeaderboardEntry {
  let score: Int
  let date: Date
}

struct Game {
  var target = Int.random(in: 1...100)
  var score = 0
  var round = 1
  var leaderboardEntries: [LeaderboardEntry] = []
  
  init(loadTestData: Bool = false) {
    if loadTestData {
      leaderboardEntries.append(LeaderboardEntry(score: 100, date: Date()))
      leaderboardEntries.append(LeaderboardEntry(score: 300, date: Date()))
      leaderboardEntries.append(LeaderboardEntry(score: 10, date: Date()))
      leaderboardEntries.append(LeaderboardEntry(score: 2000, date: Date()))
      leaderboardEntries.append(LeaderboardEntry(score: 13, date: Date()))
    }
  }

  func points(sliderValue: Int) -> Int {
    let difference = abs(target - sliderValue)
    let bonus: Int
    if difference == 0 {
      bonus = 100
    } else if difference <= 2 {
      bonus = 50
    } else {
      bonus = 0
    }
    return 100 - difference + bonus
  }

  mutating func startNewRound(points: Int) {
    score += points
    round += 1
    target = Int.random(in: 1...100)
    addToLeaderboard(point: points)
  }
  
  mutating func addToLeaderboard(point: Int) {
    leaderboardEntries.append(LeaderboardEntry(score: point, date: Date()))
    leaderboardEntries.sort { $0.score > $1.score }
  }

  mutating func restart() {
    score = 0
    round = 1
    target = Int.random(in: 1...100)
  }
  

}
