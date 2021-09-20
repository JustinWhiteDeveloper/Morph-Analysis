//
//  Extensions.swift
//  
//
//  Created by Justin White on 20/09/21.
//

import Foundation

extension String {
    var pathExtension: String {
        (self as NSString).pathExtension
    }
    
    var lastPathComponent: String {
        (self as NSString).lastPathComponent
    }
    
    private static let validJapaneseCharacterRegex = "[\u{3040}-\u{3094}\u{3400}-\u{4dbf}\u{4e00}-\u{9fff}\u{f900}-\u{faff}]"

    var containsValidJapaneseCharacters: Bool {
        return self.range(of: String.validJapaneseCharacterRegex, options: String.CompareOptions.regularExpression) != nil
    }
}
