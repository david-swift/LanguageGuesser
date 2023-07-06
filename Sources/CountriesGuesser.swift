//
//  CountriesGuesser.swift
//  LanguageGuesser
//
//  Created by david-swift on 05.07.2023.
//

import Countries
import Foundation
import GraphQLKit

/// The countries guessing game.
struct CountriesGuesser {

    /// The number of questions.
    var numberOfQuestions: Int

    /// Execute the countries guesser.
    func run() {
        var countries: [String] = []
        Guesser(
            numberOfQuestions: numberOfQuestions,
            objectName: "country"
        ) {
            var name = "Switzerland"
            var native = "Schweiz"
            var emoji = "🇨🇭"
            if countries.isEmpty {
                try? await GraphQL(url: .graphQLURL).query {
                    CountriesQuery(fields: .init { code in
                        countries.append(code)
                    })
                }
            }
            try? await GraphQL(url: .graphQLURL).query {
                CountryQuery(code: countries.randomElement() ?? "CH", fields: .init(
                    code: { code in
                        countries = countries.filter { $0 != code }
                    },
                    name: { name = $0 },
                    native: { native = $0 },
                    emoji: { emoji = $0 }
                ))
            }
            return .init(native: native, english: name, emoji: emoji)
        }.run()
    }

}
