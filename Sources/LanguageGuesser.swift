//
//  LanguageGuesser.swift
//  LanguageGuesser
//
//  Created by david-swift on 04.07.2023.
//

import ArgumentParser

/// A countries and languages guessing game.
@main
struct LanguageGuesser: ParsableCommand {

    /// The number of questions.
    @Option(help: "The number of questions in the next round.")
    var numberOfQuestions = 10
    /// Whether the countries guesser or the language guesser game is played.
    @Flag(help: "Ask for countries instead of languages.")
    var countries = false

    /// Execute the language or countries guesser game.
    mutating func run() throws {
        if countries {
            CountriesGuesser(numberOfQuestions: numberOfQuestions).run()
        } else {
            LanguageGuesserRun(numberOfQuestions: numberOfQuestions).run()
        }
    }

}
