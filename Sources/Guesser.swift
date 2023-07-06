//
//  Guesser.swift
//  LanguageGuesser
//
//  Created by david-swift on 05.07.2023.
//

import Foundation

/// A guessing game.
struct Guesser {

    /// The number of questions.
    var numberOfQuestions: Int
    /// The name of the object the user is trying to guess.
    var objectName: String
    /// Function for getting a random element.
    var randomData: () async -> RandomData

    /// The return type of the random data function.
    struct RandomData {

        /// The native name.
        var native: String
        /// The name in English.
        var english: String
        /// The emoji.
        var emoji: String

    }

    /// Execute the guesser game.
    func run() {
        let group = DispatchGroup()
        group.enter()
        Task {
            var score = 0
            for count in 1...numberOfQuestions {
                let data = await randomData()
                print("Question \(count) of \(numberOfQuestions):")
                print("What \(objectName) is \"\(data.native)\" in the native language in English?")
                if let answer = readLine() {
                    if answer == data.english {
                        print("You're right! \"\(data.native)\" means \"\(data.english)\" in English. \(data.emoji)")
                        score += 1
                    } else {
                        print("""
                            No, "\(data.native)" means "\(data.english)" in English.
                            You guessed "\(answer)". \(data.emoji)
                        """)
                    }
                } else {
                    print("❌ An error occured while parsing your answer.")
                }
                print("\(getEmoji(score: score, max: count)) Score: \(score)/\(count)")
                print("")
            }
            let percentage = getPercentage(score: score, max: numberOfQuestions)
            let emoji = getEmoji(score: score, max: numberOfQuestions)
            print("\(emoji) You scored \(score) out of \(numberOfQuestions) (\(percentage)%).")
            group.leave()
        }
        group.wait()
    }

    /// Get an integer percentage value.
    /// - Parameters:
    ///   - score: The score.
    ///   - max: The maximum value.
    /// - Returns: The percentage.
    private func getPercentage(score: Int, max: Int) -> Int {
        let fullPercent: Float = 100
        return .init(Float(score) / Float(max) * fullPercent)
    }

    /// Get an emoji for the percentage.
    /// - Parameters:
    ///   - score: The score.
    ///   - max: The maximum value.
    /// - Returns: The emoji.
    private func getEmoji(score: Int, max: Int) -> String {
        let percentage = getPercentage(score: score, max: max)
        let best = 100
        let good = 90
        let ratherGood = 75
        let okay = 50
        let ratherBad = 25
        let bad = 10
        if percentage == best {
            return "🏆"
        } else if percentage > good {
            return "🎉"
        } else if percentage > ratherGood {
            return "👍"
        } else if percentage > okay {
            return "😀"
        } else if percentage > ratherBad {
            return "😐"
        } else if percentage > bad {
            return "☹️"
        } else {
            return "💀"
        }
    }

}
