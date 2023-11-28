//
//  StringExtension.swift
//  MiniChallenge4
//
//  Created by Pedro henrique Dias hemmel de oliveira souza on 21/11/23.
//

import Foundation

extension String {
    var forSorting: String {
        let simple = folding(options: [.diacriticInsensitive, .widthInsensitive, .caseInsensitive], locale: nil)
        let nonAlphaNumeric = CharacterSet.alphanumerics.inverted
        let words = simple.components(separatedBy: nonAlphaNumeric)
        return words.count > 1 ? words.joined(separator: " ") : words.joined(separator: "")
    }
}
