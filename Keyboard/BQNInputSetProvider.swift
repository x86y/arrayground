//
//  DemoInputSetProvider.swift
//  KeyboardUnicode
//
//  Created by Daniel Saidi on 2022-02-04.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import KeyboardKit

/**
 This demo-specific input set provider can be used to create
 a custom, Unicode-based input set.

 ``KeyboardViewController`` registers it to show how you can
 register and use a custom input set provider.

 Note that for some Unicode keyboards, it makes little sense
 to have a numeric and a symbolic keyboard. If so, you could
 create a custom layout that removes all these switcher keys.
 */
class BQNSP: InputSetProvider {
    let baseProvider = EnglishInputSetProvider()

    var alphabeticInputSet: AlphabeticInputSet {
        AlphabeticInputSet(rows: [
            // .init(lowercased: "‿[{+-×÷}]", uppercased: "‿[{+-×÷}]"),
            .init(lowercased: "⌽𝕨∊↑∧⊔⊏⊐π←", uppercased: "⌽𝕎⍷↑∧⍋⊔⊑⊐π←"),
            .init(lowercased: "⍉𝕤↕𝕗𝕘⊸∘○⟜", uppercased: "⍉𝕊↕𝔽𝔾«∘⌾»"),
            .init(
                phoneLowercased: "⥊𝕩↓∨⌊≡∾",
                phoneUppercased: "⋈𝕏↓⍒⌈≢≤",
                padLowercased: "⥊𝕩↓∨⌊≡∾≤≍",
                padUppercased: "⋈𝕏↓⍒⌈≢≍≥≥"
            ),
        ])
    }

    var numericInputSet: NumericInputSet {
        NumericInputSet(rows: [
            .init(chars: "1234567890"),
            .init(phone: "˘¨⁼⌜´)&@”", pad: "1"),
            .init(phone: ".,?!’", pad: "%-+=/;:!?"),
        ])
    }

    var symbolicInputSet: SymbolicInputSet {
        baseProvider.symbolicInputSet
    }
}
