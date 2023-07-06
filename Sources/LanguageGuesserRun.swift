//
//  LanguageGuesserRun.swift
//  LanguageGuesser
//
//  Created by david-swift on 05.07.2023.
//

import Countries
import Foundation
import GraphQLKit

/// The language guessing game.
struct LanguageGuesserRun {

    /// The number of questions
    var numberOfQuestions: Int

    /// Execute the language guesser game.
    func run() {
        var languages: [String] = []
        Guesser(
            numberOfQuestions: numberOfQuestions,
            objectName: "language"
        ) {
            var name = "German"
            var native = "Deutsch"
            try? await GraphQL(url: "https://countries.trevorblades.com/graphql").query {
                if languages.isEmpty {
                    LanguagesQuery(fields: .init { code in
                        languages.append(code)
                    })
                }
                LanguageQuery(code: languages.randomElement() ?? "de", fields: .init(
                    code: { code in
                        languages = languages.filter { $0 != code }
                    },
                    name: { name = $0 },
                    native: { native = $0 }
                ))
            }
            return .init(native: native, english: name, emoji: "")
        }.run()
    }

}
