//
//  FakeAutocompleteProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-05.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation
import KeyboardKit

let JSONString = """
[[
  "⊢y",
  "Same: y",
  "dex righttack sameright default"
],[  "x⊢y",
  "Right: y",
  "dex righttack sameright"
],[  "x⊢y",
  "Church Boolean false (x if false, else y)",
  "falsy falsey 0"
],[  "⊣y",
  "Same: y",
  "lev lefttack"
],[  "x⊣y",
  "Left: x",
  "lev lefttack sameleft defer ignore where"
],[  "x⊣y",
  "Church Boolean true (x if true, else y)",
  "truthy 1"
],[  "+n",
  "Mirror complex n across x-axis",
  "greek cross conjugate negateimaginary mirroring reflecting reflection"
],[  "+y",
  "Conjugate ('Identity' if y not complex)",
  "greek cross plus conj() conjugating"
],[  "m+n",
  "Add n to m",
  "greek cross plus addition"
],[  "-n",
  "Negate: 0-n",
  "minus hyphen invert additiveinverse opposite dash negation signchange − negating"
],[  "m-n",
  "Subtract n from m",
  "minus dash hyphen subtraction difference −"
],[  "×n",
  "Sign (Direction, for complex n)",
  "cross sgn() sign() trend"
],[  "a×n",
  "Select elements satisfying condition a, others to 0",
  "zero cells items"
],[  "m×n",
  "Multiply m and n",
  "cross times multiplication ∙ ⋅ · product"
],[  "m1×n1",
  "Ring modulation of signal m1 by n1",
  ""
],[  "∨y",
  "Sort Descending",
  "sort() down decreasing sorting reordering ordering"
],[  "a∨b",
  "Logical OR",
  "gate disjunction vel alternation Caron hacek invertedcircumflex checkmark hachek Apq"
],[  "m∨n",
  "Probabilistic OR",
  "Caron hacek invertedcircumflex checkmark hachek fuzzy probability chance disjunction vel alternation Apq"
],[  "∧y",
  "Sort Ascending",
  "sort() up increasing sorting reordering ordering"
],[  "a∧b",
  "Logical AND",
  "gate conjunction caret wedge hat circumflex Kpq ^"
],[  "m∧n",
  "Probabilistic AND",
  "caret wedge hat circumflex ^ fuzzy probability chance conjunction Kpq"
],[  "⌈n",
  "Round up to integer",
  "upstile roundup ceiling seiling up() ceil()"
],[  "m⌈n",
  "Maximum of m and n",
  "upstile greater larger max() bigger"
],[  "⌊n",
  "Round down to integer",
  "downstile rounddown down() floor()"
],[  "m⌊n",
  "Minimum of m and n",
  "downstile lesser smaller min()"
],[  "⌽y",
  "Reverse leading axis of y",
  "circlebar rowel upsetting flipping upending upsidedown reversing dimension start beginning"
],[  "⌽y2",
  "Reflect horizontally",
  "mirroring reflecting reflection up-down updown down-up downup"
],[  "i⌽y",
  "Rotate rows along leading axis of y",
  "circlebar rotating cyclically dimension lists start beginning"
],[  "÷n",
  "Reciprocal: 1÷n",
  "multiplicativeinverse opposite obelus inverting reciprocating per"
],[  "m÷n",
  "Divide m by n",
  "division over ⁄ divide per"
],[  "|n",
  "Magnitude (absolute value)",
  "verticalbar pipe stile stroke verticalline modulo modulus amplitude"
],[  "m|n",
  "Residue after dividing n by m",
  "verticalbar pipe stile stroke verticalline modulo modulus divisionremainder mod() divide ≢ divmod() residual"
],[  "»y",
  "Nudge: shift a fill cell into the front of y, displacing a cell from the end",
  "chevron french quote rightshift push"
],[  "x»y",
  "Shift before: shift major cells from x into the front of y, displacing cells from the end",
  "chevron french quote rightshift"
],[  "«y",
  "Nudge back: shift a fill cell into the end of y, displacing a cell from the front",
  "chevron french quote leftshift"
],[  "x«y",
  "Shift after: shift major cells from x into the end of y, displacing cells from the front",
  "chevron french quote leftshift"
],[  "=y",
  "Rank (number of dimensions) of y",
  "howmanyaxes numberofaxes axiscount ⥊⥊ axes"
],[  "a=b",
  "Logical XNOR",
  "gate materialbiconditional biimplication eqv nxor bothorneither exclusivenor materialequivalence ⇔ δ ẟ Kroneckerdelta iff logicalequivalence Epq doubleimplying both-or-neither"
],[  "x=y",
  "Equal To",
  "sameas ==="
],[  "≠x2",
  "Number of rows in table x2",
  "count tally table"
],[  "≠y",
  "Length (along first axis)",
  "equalslash unequal count tally length() cells len() major cells elements dimension start beginning"
],[  "a≠b",
  "Logical XOR",
  "gate exclusivedisjunction eor exor ⊕ ⊻ ⇎ Jpq"
],[  "x≠y",
  "Not Equal To",
  "ne unequal differentfrom != <> /="
],[  "<y",
  "Enclose: Unit containing y",
  "angle boxing scalarise scalarize enclosing"
],[  "a<b",
  "Logical converse nonimplication",
  "gate ⇍ Mpq cnimply"
],[  "m<n",
  "Less Than",
  "lt before precedes ≺ smaller lesser"
],[  ">y",
  "Merge: Remove nesting (adding trailing axes)",
  "pike uparrow axis dimensions delete drop ending without"
],[  ">y1",
  "List of row lists to table",
  "pike uparrow mix table from lists into"
],[  "a>b",
  "Logical nonimplication",
  "gate abjunction ⇏ not butnot Lpq nimply"
],[  "m>n",
  "Greater Than",
  "gt after follows ≻ larger succeeds"
],[  "a≤b",
  "Logical implication",
  "gate materialconditional materialconsequence implies implying materialimplication therefore ∴ ⇒ Cpq"
],[  "m≤n",
  "Less Than Or Equal To",
  "before precedes ≦ smaller lesser same as"
],[  "a≥b",
  "Logical converse implication",
  "gate because ∵ ⇐ if converseconditional Bpq reverseimplying cimply"
],[  "m≥n",
  "Greater Than Or Equal To",
  "ge after follows ≧ larger same as succeeds"
],[  "≡y",
  "Depth: Maximum level of nesting in y (negative if uneven)",
  "equalunderbar"
],[  "x≡y",
  "Match: 1 if x is identical to y, else 0",
  "testif equalunderbar identical? === equivalentto sameas"
],[  "≢y",
  "Shape: Length of each axis of y",
  "equalunderbarslash unequalunderbar dimensions rho ⍴ ρ ϱ rank axes"
],[  "x≢y",
  "Not Match: ¬x≡y",
  "notmatch natch equalunderbarslash unequalunderbar notidentical differentfrom"
],[  "↓y",
  "Suffixes of an array",
  "spike downarrow final string text"
],[  "i0↓y",
  "Drop first i0 major cells from y",
  "spike downarrow delete remove without"
],[  "i1↓y",
  "Drop i1 positions along leading axes of y",
  "spike downarrow remove trim cut major cells elements dimensions delete start beginning without"
],[  "↑y",
  "Prefixes of an array",
  "pike uparrow initial string text"
],[  "i0↑y",
  "Take first i0 major cells or y",
  "pike uparrow table grab first last chop"
],[  "i0↑y1",
  "Pad y1 on the right to width i0",
  "extend right-align rightalign text"
],[  "i1↑y",
  "Take i1 positions along leading axes of y",
  "pike uparrow first last beginning trailing head tail major cells elements dimensions 1st start ending"
],[  "i1↑y0",
  "Pad y0 to shape i1",
  "extend text"
],[  "⥊y",
  "Ravel: Reshape into a list",
  "zig zag comma flattening flatten() raze razing list array"
],[  "i0⥊y0",
  "Length-i0 list of copies of y0",
  "repeat repetition repeats repeating copy"
],[  "i1⥊y",
  "Reshape y to have shape i1",
  "zig zag rho mold form dimension array ⍴ ρ ϱ mould dim() axis cyclically repeat repetition repeats repeating take taking elements of"
],[  "i1⥊y0",
  "Shape-i1 array of copies of y0",
  "repeat repetition repeats repeating copy"
],[  "⋆n",
  "e raised to the power n",
  "star asterisk exponential etothepowerof naturalexponential exp() 2.718281828459045235360287471352662 antiln antilog ln^-1() ln⁻¹() log^-1() log⁻¹() lnₑ^-1() lnₑ⁻¹() logₑ^-1() logₑ⁻¹()"
],[  "m⋆n",
  "m raised to the power n",
  "star asterisk raisedtothepowerof exponentiation pow() ** raising"
],[  "√n",
  "Square Root",
  "squareroot sqrt ²√ ^0.5 ^.5"
],[  "m√n",
  "m'th Root of n",
  "nthroot ⁿ√ ³√ ∛ ∜"
],[  "¬n",
  "Probabilistic inverse (NOT)",
  "fuzzy probability chance logicalnot logicalnegation logicalcomplement ~ ¬ negate inverting"
],[  "¬y",
  "Logical inverse (NOT): 1-y",
  "gate tilde logicalnot logicalnegation logicalcomplement ~ ¬ negate inverting"
],[  "i¬j",
  "Number of integers between i and j, inclusive",
  "plus span distance fence-post range"
],[  "x¬y",
  "Span: 1+x-y",
  "not plus span distance fence-post range"
],[  "x y˙z",
  "Constant: ignore arguments and return y",
  "single dot replace"
],[  "x˙y",
  "Constant: ignore z and return x",
  "single dot replace"
],[  "F˜y",
  "Self: same as y F y",
  "commute superscript tilde frown duplicate selfie dup"
],[  "x F˜y",
  "Commute: same as y F x",
  "switch superscript tilde swap frown flip"
],[  "x F˜y",
  "Church Boolean Logical Inverse",
  "¬ not logicalnot logicalnegation logicalcomplement ¬ negate inverting"
],[  "F∘G y",
  "Atop: F on the result of G on y, that is, F G y",
  "small little tiny jot composewith bind ring functioncomposition against after"
],[  "x F∘G y",
  "Atop: F on the result of x G y, that is, F x G y",
  "small little tiny jot composewith functioncomposition upon after"
],[  "F⊸G x",
  "Before hook: (F x) G x",
  "functioncomposition fXgX backcompose back-compose reverse-compose reversecompose into"
],[  "x F⊸G y",
  "Before: (F x) G y",
  "composewith functioncomposition fXgY backcompose back-compose reverse-compose reversecompose into"
],[  "x⊸G y",
  "Bind: G between x and y, that is, XgY",
  "small little tiny jot composewith bind ring"
],[  "F⟜G y",
  "After hook: x F G x",
  "composewith bind ring functioncomposition against"
],[  "F⟜y z",
  "Bind: F between z and y, that is, z F y",
  "small little tiny jot composewith bind ring"
],[  "x F⟜G y",
  "After: x⊸F on the result of G on y, that is, x F G y",
  "small little tiny jot composewith bind ring functioncomposition hook against"
],[  "F¨y",
  "Each: F on elements of y",
  "foreach diaeresis mapping cells elements"
],[  "x F¨y",
  "Each: F between elements of x and y",
  "foreach diaeresis mapping cells elements"
],[  "G⌜y",
  "Table: G on each element of y; same as G¨y",
  "corner jotdot outerproduct table cartesianproduct allcombinationsof matrix cell element pair up"
],[  "x G⌜ y",
  "Table: G between each element of x and every element of y",
  "corner jotdot outerproduct cartesianproduct allcombinationsof matrix cell element pair up"
],[  "F○G y",
  "Over: F on the result of G on y, that is, F G y",
  "circle hoof composewith functioncomposition"
],[  "x F○G y",
  "Over: apply G to each argument and F to the results",
  "circle ontop composewith functioncomposition (gX)F(gY) (gX)fgY (fX)G(fY) (fX)gfY comparing"
],[  "/b1",
  "Indices of all 1s in b",
  "wheretrues slash solidus locationsoftrues positions ones trues truths"
],[  "/j1",
  "Indices: j/↕≠j",
  "slash solidus locationsoftrues positions ones trues truths"
],[  "a1/y",
  "Filter major cells of y according to mask a1",
  "compressing selecting items vertically rowsofmatrix columnwise column-wise dimension 1st start beginning down bitmask bit-mask"
],[  "i1/y",
  "Copy major cells of y i1 times",
  "compressing slash solidus first copying repeatingeachrows dimension 1st start beginning vertically columnwise column-wise down"
],[  "F´y1",
  "Fold: F between all elements of y1",
  "accute accent slash inserting over reducing folding cells elements"
],[  "x F´ y1",
  "Fold: F between all elements of y1 and initial value x",
  "accute accent slash inserting over reducing folding cells elements"
],[  "F⎉j0 y",
  "Rank: apply F to j0-cells to form cells of the result",
  "sub-array dimensions axes ending"
],[  "x F⎉j1 y",
  "Rank: F on corresponding cells of x and y",
  "sub-array dimensions axes ending"
],[  "F⌾G y",
  "Under: apply G, then F, then undo G",
  "double circle dual commutator"
],[  "x F⌾G y",
  "Under: apply F○G, then undo G",
  "double circle dual commutator"
],[  "F⊘G y",
  "Valences: F y since F is used for one argument",
  "circle slash number adicity ambivalent"
],[  "x F⊘G y",
  "Valences: x G y since F is used for two arguments",
  "circle slash number adicity ambivalent"
],[  "F˝y",
  "Insert: F between all major cells of y",
  "slash reducefirst foldfirst insertfirst inserting folding solidusbar columnwise reducing major cells elements dimension 1st column-wise vertically down"
],[  "x F˝ y",
  "Insert: F between all major cells of y and initial value x",
  "slash reducefirst foldfirst insertfirst inserting folding solidusbar columnwise reducing major cells elements dimension 1st column-wise vertically down"
],[  "∾y",
  "Join elements of y along axes corresponding to y's axes",
  "combine merge joinvertically cells elements dimensions"
],[  "∾y1",
  "Join list of lists into one list",
  "nextto juxtapose merge flatten row-wise rowwise"
],[  "∾y2",
  "Join a parts of a block matrix to form a simple matrix",
  "combine merge raze separated chunked segmented sub-matrices submatrices sub-tables subtables partitioned block-matrix table blockmatrix"
],[  "x∾y",
  "Join two arrays along a leading axis",
  "commabar concatenate over ontop atop vertically stack dimension column-wise columnwise start beginning connect join"
],[  "x2∾y1",
  "Append elements of list to respective columns of table",
  "vertically ontop atop extend with over merge join concatenate table list"
],[  "⋈y",
  "Enlist: return the 1-element list ⟨y⟩",
  "single"
],[  "x⋈y",
  "Pair: return the 2-element list ⟨x,y⟩",
  "comma combine juxtapose strand two"
],[  "≍y",
  "Solo: add a length-1 axis to the beginning of y",
  "itemize additional dimensions axes axis items elements cells extend shape add beginning first 1st rowmatrixfromvector"
],[  "≍y1",
  "Turn y1 into a one-row table",
  "1-row table list 1st initialise initialize"
],[  "x≍y",
  "Couple: join arrays of identical shape along new length-2 axis",
  "laminate comma combine juxtapose dimension"
],[  "x1≍y1",
  "Two-row table from two lists",
  "table lists rows"
],[  "⊏y",
  "First cell of y",
  "topmostrow subarray dimension leading cell item 1st start beginning"
],[  "i1⊏y",
  "Select major cells i1 from y",
  "rightshoeunderbar saneindexing ⊇ items elements getting picking selecting permutation permuting"
],[  "x1⊏y",
  "Select cells from y based on numeric arrays in x",
  "rightshoeunderbar saneindexing ⊇ items elements getting picking selecting permutation permuting"
],[  "↕j0",
  "Natural numbers less than j0",
  "iota unsigned integers ints countto sequence numbers range ɩ ι positions locations 0… 0..."
],[  "↕j1",
  "Indices of all elements of array of shape j1",
  "up-down arrow iota sequence ɩ ι positions locations cells elements naturals numbers"
],[  "i↕y",
  "Windows: slices of y with shape i, arranged in a flat array",
  "up-down arrow sub-array subarray sub-sequence subsequence segmented partitioned"
],[  "i0↕y1",
  "All slices of y1 of length i0",
  "sub-string substring sub-sequence subsequence sub-vectors segmented sub-lists partitioned sublists"
],[  "∊y",
  "Unique mask: boolean list indicating major cells to be kept if y was deduplicated (⍷y)",
  "unique Boolean indication indicate ⍧ items elements masking indicating Nub-sieve"
],[  "x∊y",
  "Member of: 1 for cells of x matching major cells of y and 0 elsewhere",
  "testif epsilon isin membership containedin has ϵ ε ∈ memberof elementof cell searching"
],[  "⊐y",
  "Classify: translate major cells to natural number keys ((⍷y)⊐y)",
  "self unique index integers replace with convertion to self-identifying generate ids identities serial-numbers enumeration labels"
],[  "x⊐y",
  "Index of: index of the first major cell of x matching each cell of y",
  "iota indexin indexof ɩ ι finding locating locate positionof 1st items elements location searching"
],[  "x1⊐y",
  "Indices of keys y in key list x1",
  "find locate positionof locating location list"
],[  "F⁼y",
  "Undo: find z such that y ≡ F z",
  "F⁻¹(x) F′(x) fʹ(x) inverse opposite revert"
],[  "x F⁼ y",
  "Undo: find z such that y ≡ x F z",
  "F⁻¹(x,y) F′(x,y) fʹ(x,y) inverse opposite revert"
],[  "F⍟G y",
  "Repeat: apply F G y times to y, in succession",
  "application poweroperator circlestar starcircle inverse repeated repeating inversion inverting iterating looping"
],[  "F⍟j0 y",
  "Repeat: apply F j0 times to y",
  "application poweroperator circlestar starcircle inverse repeated repeating inversion inverting iterating looping"
],[  "x F⍟G y",
  "Repeat: apply x∘F to y, G y times",
  "application inverse repeated repeating inversion inverting iterating looping"
],[  "x F⍟j0 y",
  "Repeat: apply x⊸F j0 times to y",
  "poweroperator circlestar starcircle inverse inversion application repeated repeating inverting iterating looping"
],[  "⍋j1",
  "Invert permutation",
  "upgrade deltastile upgrade pine concordetakingoff"
],[  "⍋y",
  "Grade up: indices to reorder y into ascending order",
  "upgrade gradeup deltastile pine concordetakingoff increasing"
],[  "x⍋y",
  "Bins up: indices of cells of y in intervals with ascending cut-offs x",
  "deltastile intervalindex iotaunderbar bins groups ranges bucketsassifying classification major cells elements"
],[  "⍒y",
  "Grade down: indices to reorder y into descending order",
  "downgrade gradedown delstile spine concordelanding decreasing"
],[  "x⍒y",
  "Bins down: indices of cells of y in intervals with descending cut-offs x",
  "delstile intervalindex iotaunderbar bins groups ranges bucketsassifying classification major cells elements"
],[  "F`y",
  "Scan: F between elements of y progressing along the first axis",
  "slopebar backslashbar reversesolidusbar scanfirst cumulativereducefirst columnwise scanning major cells elements dimension 1st column-wise vertically lists"
],[  "x F` y",
  "Scan: F between elements of y with initial cell x",
  "slopebar backslashbar reversesolidusbar scanfirst cumulativereducefirst columnwise scanning major cells elements dimension 1st column-wise vertically lists"
],[  "⍉y",
  "Transpose: move first axis of y to end",
  "circlebackslash cant rotateaxes ^T ⸆ ᵀ reordering ordering rotating dimensions"
],[  "⍉y2",
  "Reflect diagonally",
  "mirroring reflecting reflection mirror across tip"
],[  "i0⍉y",
  "Rotate only the first i0+1 axes of y as if transposing",
  "diagonal reorderaxes reordering dimensions"
],[  "i1⍉y",
  "Reorder the axes of y to send axes to positions i1",
  "circlebackslash diagonal reorderaxes reordering dimensions shuffle slice shuffling slicing"
],[  "⊑y",
  "First element of y",
  "disclose rightshoe unbox open contentof y[0] x[0] element cell 1st"
],[  "b0⊑y1",
  "Pick one of two values from y1 according to b0",
  "Choosing choose"
],[  "i1⊑y",
  "Select element at index i1 from y",
  "rightshoe pickfrom selectfrom getting picking indexing selecting"
],[  "x⊑y",
  "Select scattered elements from y, where each list nested within x select an element",
  "rightshoe pickfrom selectfrom getting picking indexing selecting scatterpoint"
],[  "⊒y",
  "Occurrence count: number of times each major cell's value has appeared previously",
  "indexin indexof matchingpositionof find locatecorresponding PDI remove tally selfcount"
],[  "x⊒y",
  "Progressive Index of: ⊐ that can't use the same index twice",
  "indexin indexof matchingpositionof find locatecorresponding PDI remove"
],[  "⍷y",
  "Deduplicate: distinct major cells of y",
  "cup downshoe distinctitems uniqueelements nub eraseremoveduplicates repetitions items elements"
],[  "x⍷y",
  "Find: boolean indication of top left corner of occurrences of entire array x within y",
  "findin epsilonunderbar search locate subarray sub-array sub-vector subvector subsequence sub-sequence sub-string substring sub-list sublist locating location binary base-2 base2"
],[  "⊔i1",
  "Group Indices of i1 by placing them in the given positions",
  "square cup bucket"
],[  "⊔x1",
  "Group compound indices ↕≠¨x1 according to x1",
  "square cup bucket"
],[  "i1⊔y",
  "Group major cells of y into the positions i1",
  "square cup bucket sort"
],[  "x1⊔y",
  "Group array y based on x1",
  "square cup bucket sort"
],[  "F⚇j0 y",
  "Depth: apply F to depth-j0 nested elements of y",
  "circledots recursion repeated each"
],[  "x F⚇j1 y",
  "Depth: F on corresponding elements of x and y at the given depths",
  "circledots recursion repeated each"
],[  "!y",
  "Assert: throw an error (with message y) unless y is 1",
  "raise exception fail signal panic abort test require"
],[  "x!y",
  "Assert with message: if y isn't 1, throw an error with message x",
  "raise exception fail signal panic abort test require"
],[  "F⎊G y",
  "Catch: Run F, but run G on the same arguments instead if it fails",
  "recover stop exception signalled"
],[  "x F⎊G y",
  "Catch: Run F, but run G on the same arguments instead if it fails",
  "recover stop exception signalled"
],[  "F•_timed y",
  "Time taken to evaluate F y",
  "timings performance speed measure elapsed tuning tune"
],[  "m0 F•_timed y",
  "Average time per call to evaluate F y, m0 times in succession",
  "timings performance speed measure elapsed tuning tune mean"
],[  "x •Import d1",
  "Load BQN script from path d1, with •args x",
  "include library run execute"
],[  "x1 •BQN d1",
  "Evaluate string d1 as BQN code, with •state x1",
  "eval() run call"
],[  "•MakeRand m0",
  "Random number generator (behaves like •rand) initialized with seed m0",
  "RNG rnd pseudorandominteger pseudo-randomfloat srandomness source randomlink deterministic reproducible reproduce seeded predictable"
],[  "•MonoTime y",
  "Monotonically-increasing time counter in seconds, for relative measurement",
  ""
],[  "•Import d1",
  "Load BQN script from path d1, recalling saved result if already loaded",
  "include library run execute"
],[  "•BQN d1",
  "Evaluate source string d1 as BQN code",
  "eval() run call"
],[  "•Decompose g",
  "Split compound function g into parts",
  ""
],[  "•Delay n0",
  "Wait n0 seconds",
  "await sleep pause idle"
],[  "•Exit y",
  "Exit the running BQN process, with return code y",
  "quit terminate level stop close"
],[  "•Fmt y",
  "Format value y for printing",
  "itoa tostringify() totext() tostring()"
],[  "•Glyph g",
  "Glyph character of primitive g",
  "squiggle builtin"
],[  "•Out d1",
  "Print string d1, and trailing newline, to stdout",
  "echo puts"
],[  "•ReBQN y",
  "Create BQN-like evaluation function using options namespace y",
  "repl extend extension replace new"
],[  "•Repr y",
  "Source code representation of BQN value y, if possible",
  "uneval itoa totext() numbers numerics converting into marshal serialize pickle"
],[  "•Show y",
  "Format and print BQN value y",
  "echo log debug display"
],[  "•Type y",
  "Type of y: 0 array, 1 number, 2 character, 3 function, 4 1-modifier, 5 2-modifier, 6 namespace",
  "kind"
],[  "•UnixTime y",
  "Current Unix time in seconds",
  "now timestamp datetime"
],[  "•args",
  "Arguments passed to the current script by command line or BQN caller",
  "startup shell args argv cmdline cli"
],[  "•state",
  "The list ⟨•path, •name, •args⟩ of execution state",
  "bqn"
],[  "•name",
  "Name of the file where this system value appears",
  "this here script location"
],[  "•path",
  "Path of the file where this system value appears",
  "this here script location"
],[  "•primitives",
  "List of primitives as glyph‿value pairs",
  "builtins"
],[  "•wdpath",
  "The shell's current working directory path",
  "pwd folder location where"
],[  "m •math.Atan2 n",
  "2-argument arctangent, angle of vector m‿n relative to 1‿0",
  "argument phase"
],[  "m •math.Comb n",
  "Binomial function m choose n",
  "exclamation bang shriek binomial combinatorics countcombinations unordered selecting picking outof nCk C(n,k)"
],[  "m •math.GCD n",
  "Greatest Common Divisor of m and n",
  "gcd() gcf() factor hcf() highest gcm() measure hcd Caron hacek invertedcircumflex checkmark hachek"
],[  "m •math.Hypot n",
  "Highest-precision hypotenuse length m+⌾(×˜)n",
  "correct accurate perfect rounding"
],[  "m •math.LCM n",
  "Least Common Multiple of m and n",
  "least smallest lcm() denominator lcd() caret wedge hat circumflex ^"
],[  "m0 •rand.Deal n0",
  "A simple random sample of m0 elements of ↕n0",
  "srs draw without replacement removing"
],[  "m0 •rand.Subset n0",
  "A sorted random sample of m0 elements from ↕n0",
  "srs simple draw without replacement removing reservoir"
],[  "m1 •file.Owner d1",
  "Set owner user ID and group ID number of file d1",
  "dir directory directories folders ls list information vector chown"
],[  "m1 •file.Permissions d1",
  "Set permissions of file d1",
  "dir directory directories folders ls list information vector chmod"
],[  "m1 •rand.Range n0",
  "Shape m1 array of elements selected uniformly at random from ↕n0",
  "randominteger roll draw with replacement"
],[  "c1 •file.At d1",
  "Absolute path of file with path d1 relative to c1",
  "resolve canonicalize reduce extend"
],[  "c1 •file.Bytes d1",
  "Write raw bytes to file d1 (overwrites existing contents)",
  "store put dump cat save to overwrite UTF-8"
],[  "c1 •file.Chars d1",
  "Write string c1 to file d1 (overwrites existing contents)",
  "store put dump cat save to overwrite"
],[  "c1 •file.Copy d1",
  "Copy file d1 to c1",
  "copying"
],[  "c1 •file.Rename d1",
  "Rename file d1 to c1",
  "moving renaming"
],[  "x1 •file.Lines d1",
  "Write lines x1 to file d1 (overwrites existing contents)",
  "store put dump cat save to overwrite vtv charvec charactervector textvector string"
],[  "•file.Modified d1",
  "Time of last modification to file d1",
  "filepath dir directory directories folders ls list information vector when modified"
],[  "•file.Name d1",
  "File name from path d1",
  "parts"
],[  "•file.Accessed d1",
  "Time of last access to file d1",
  "filepath dir directory directories folders ls list information vector when previously accessed"
],[  "•file.At d1",
  "Absolute path of file d1",
  "resolve canonicalize reduce relative"
],[  "•file.Basename d1",
  "File name from path d1, with dot and extension removed",
  "parts"
],[  "•file.Bytes d1",
  "Return contents of file d1 as raw bytes",
  "get read fetch load UTF-8"
],[  "•file.Chars d1",
  "Return contents of file d1 as a string",
  "get read fetch load"
],[  "•file.CreateDir d1",
  "Create a directory with path d1",
  "mkdir md newfolder make"
],[  "•file.Created d1",
  "Time file d1 was created",
  "filepath dir directory directories folders ls list information vector when created"
],[  "•file.Exists d1",
  "1 if file d1 exists and 0 otherwise",
  "check is there dir directory directories folders ls list information vector"
],[  "•file.Extension d1",
  "File extension, including leading dot, from path d1",
  "parts"
],[  "•file.List d1",
  "Return the list of filenames contained in directory d1",
  "dir directory directories folders ls list information vector"
],[  "•file.Lines d1",
  "Return lines of file d1 as a list of strings",
  "get read fetch load vtv charvec charactervector textvector string"
],[  "•file.Owner d1",
  "Owner user ID and group ID number of file d1",
  "dir directory directories folders ls list information vector userid user-id windows sid"
],[  "•file.Parent d1",
  "Path of containing directory of path d1",
  "parts"
],[  "•file.Parts d1",
  "List of parent, base name, and extension given path d1",
  "split divide"
],[  "•file.Permissions d1",
  "Permissions of file d1, as a 3-element list",
  "dir directory directories folders ls list information vector"
],[  "•file.Remove d1",
  "Delete file d1",
  "dcf delete expunge remove drop without removing erasing eliminate eliminating deleting"
],[  "•file.RemoveDir d1",
  "Recursively delete directory d1 and all contents",
  "dir directory directories folders dcf delete expunge remove drop without removing erasing eliminate eliminating deleting"
],[  "•file.Size d1",
  "Total size in bytes of file d1",
  "dir directory directories folders ls list information vector"
],[  "•file.Type d1",
  "A character from fdlpsbc indicating POSIX type of file d1",
  "filepath dir directory directories folders ls list information vector symbolic first-in-first-out character"
],[  "•file.path",
  "Equivalent to •path",
  "this here script location"
],[  "•math.Asin n",
  "Arcsine of n",
  "inverse arsin() asin() arcussinus sin⁻¹() sin^-1()"
],[  "•math.Asinh n",
  "Hyperbolic arcsine of n",
  "inverse arcsine asinh() arcsinh() arsinh() area sinh⁻¹() sinh^-1()"
],[  "•math.Acos n",
  "Arccosine of n",
  "inverse arccos() acos() arcuscosinus cos⁻¹() cos^-1()"
],[  "•math.Acosh n",
  "Hyperbolic arccosine of n",
  "inverse arccosine acosh() arccosh() arcosh() area cosh⁻¹() cosh^-1()"
],[  "•math.Atan n",
  "Arctangent of n",
  "inverse arctan() atan() arcustangens tan⁻¹() tan^-1()"
],[  "•math.Atanh n",
  "Hyperbolic arctangent of n",
  "inverse arctangent atanh() arctanh() artanh() area tanh⁻¹() tanh^-1()"
],[  "•math.Cbrt n",
  "Highest-precision cube root 3√n",
  "correct accurate perfect rounding"
],[  "•math.Cos n",
  "Cosine of angle n (radians)",
  "cos() cosinus"
],[  "•math.Cosh n",
  "Hyperbolic cosine of n",
  "cosh()"
],[  "•math.Erf n",
  "Error function of n (normalized integral of Gaussian)",
  "statistics erf() normal distribution sigmoid cdf cumulative"
],[  "•math.ErfC n",
  "Highest-precision complementary error function 1-•math.Erf n",
  "statistics erf() normal distribution sigmoid cdf cumulative"
],[  "•math.Expm1 n",
  "Highest-precision (⋆n)-1",
  "correct accurate perfect rounding"
],[  "•math.Fact n",
  "n factorial, or Gamma function of n+1",
  "pling exclamation bang shriek countpermutations combinatorics fact() gamma() Γ"
],[  "•math.Log10 n",
  "Highest-precision base-10 logarithm 10⋆⁼n",
  "correct accurate perfect rounding decimal"
],[  "•math.Log1p n",
  "Highest-precision ⋆⁼1+n",
  "correct accurate perfect rounding"
],[  "•math.Log2 n",
  "Highest-precision base-2 logarithm 2⋆⁼n",
  "correct accurate perfect rounding binary"
],[  "•math.LogFact n",
  "Highest-precision logarthm of factorial ⋆⁼•math.Fact n",
  "correct accurate perfect rounding"
],[  "•math.Sin n",
  "Sine of angle n (radians)",
  "sin() sinus"
],[  "•math.Sinh n",
  "Hyperbolic sine of n",
  "sinh()"
],[  "•math.Tan n",
  "Tangent of angle n (radians)",
  "tan() tangens"
],[  "•math.Tanh n",
  "Hyperbolic tangent of n",
  "tanh()"
],[  "•rand.Deal n0",
  "A random shuffle of ↕n0",
  "shuffling reorder"
],[  "•rand.Range 0",
  "A random real number in the interval from 0 to 1",
  "roll"
],[  "•rand.Range n0",
  "A number selected uniformly at random from ↕n0",
  "randominteger roll"
],[  "•rand.Subset n0",
  "A random sorted subset of ↕n0",
  "simple random sample srs length"
],[  "1˘y2",
  "List having as many ones as y2 has rows",
  "1s trues truths list"
],[  "0¨y",
  "Zeros with same shape as y",
  "zeroes naughts 0s falses falsehoods"
],[  "x0¨y",
  "Fill array y with data value x0",
  ""
],[  "+˜n",
  "Double: 2×n",
  "twice"
],[  "×˜n",
  "Square: n⋆2",
  "² ^2"
],[  "=˜y",
  "Ones, same shape and structure",
  "1s trues truths"
],[  "≠˜y",
  "Zeros, same shape and structure",
  "zeroes naughts 0s falses falsehoods"
],[  "x F∘⊢ y",
  "Ignore left argument (call F monadically on y)",
  "to from dummy onrightargument"
],[  "x F∘⊣ y",
  "Ignore right argument (call F monadically on x)",
  "to from dummy onleftargument"
],[  "1⊸+n",
  "Increment: n+1",
  "increase next"
],[  "¯1⊸-j",
  "2's-complement bit-wise NOT",
  "bitwise binary gate logicalnot logicalnegation logicalcomplement negate inverting inversion 2s two's twos"
],[  "0⊸×n",
  "Zero array of shape, size, and structure of n",
  "zeroes zeros fill mold mould 0s falses falsehoods"
],[  "100⊸×n",
  "Percentage corresponding to rate n",
  "conversion converting change changing"
],[  "3⊸×n",
  "Triple: 3×n",
  "thrice"
],[  "0⊸⌈n",
  "Ensure that n is non-negative (negatives become zero)",
  "clamp limit restrict"
],[  "0⊸⌊n",
  "Ensure that n is non-positive (positives become zero)",
  "clamp limit restrict"
],[  "1⊸⌽y",
  "Rightmost neighbouring elements (cyclically)",
  "neighbours neighbors lefthand bitshift cells items"
],[  "¯1⊸⌽y",
  "Leftmost neighbouring elements (cyclically)",
  "neighboring neighbours neighbors lefthand bitshift cells items"
],[  "1⊸|n",
  "Fractional part of number",
  "decimals"
],[  "1000⊸|ia",
  "Last part of packed numeric code ABBB",
  "unpack converting change changing"
],[  "2⊸|j",
  "Parity of j (is j odd?)",
  "testif"
],[  "256⊸|j",
  "Convert from signed short integers to unsigned short integers",
  "datarepresentation converting change changing"
],[  "0⊸=n",
  "Zero?",
  "testif"
],[  "0⊸≠n",
  "Non-zero?",
  "testif nonzero?"
],[  "0⊸<n",
  "Strictly positive?",
  "testif"
],[  "0⊸>n",
  "Strictly negative?",
  "testif"
],[  "0⊸≤n",
  "Non-negative?",
  "testif nonnegative?"
],[  "0⊸≥n",
  "Non-positive?",
  "testif nonpositive?"
],[  "0⊸↓y",
  "Ensure minimum rank 1 (reshaping unit into one-element list)",
  "unscalarise unscalarize 1-element 1element minimumrank1 makenonscalarise nonscalarize list ravel-if-scalar"
],[  "1⊸↓y",
  "Behead: Remove first major cell",
  "drop chop leading element item 1st delete start beginning without"
],[  "¯1⊸↓y",
  "Curtail: Remove last major cell",
  "drop chop trailing element item delete ending without"
],[  "1⊸↑y2",
  "First row as a row matrix (row list)",
  "topmostrow leading 1st table list start beginning"
],[  "¯1⊸↑y2",
  "Last row as a row matrix (row list)",
  "bottommostrow trailing table list ending"
],[  "10⊸⋆n",
  "Common anti-logarithm",
  "log⁻¹() log^1() lg⁻¹() lg10^1() log10⁻¹() log10^1() lg10⁻¹() lg10^1() log₁₀⁻¹() log₁₀^1() lg₁₀⁻¹() lg₁₀^1() antilogarithm"
],[  "3⊸√n",
  "Cube Root",
  "squareroot cbrt ³√ ∛ ^0.333 ^.333 ^(1/3)"
],[  "-⟜1 n",
  "Decrement",
  "decrease previous"
],[  "÷⟜100 n",
  "Rate corresponding to percentage n",
  "conversion converting change changing"
],[  "÷⟜2 n",
  "Halve: n÷2",
  "halfof"
],[  "÷⟜F n",
  "Normalise, scaling so that the norm F is equal to 1",
  "normalise arbitrary custom F=1 vector list"
],[  "⋆⟜3 n",
  "Cube",
  "³ ^3"
],[  "x F⊸G⟜H y",
  "Split-Compose: apply G between (F x) and (H y), that is (F x) G (H y)",
  "composewith splitover (fX)G(hY) (fX)ghY"
],[  "∨˘y",
  "Sort major cells descending",
  "elements items sort() down decreasing sorting reordering ordering"
],[  "∧˘y",
  "Sort major cells ascending",
  "elements items sort() up increasing sorting reordering ordering"
],[  "⌽˘y2",
  "Reflect vertically",
  "mirroring reflecting reflection right-left rightleft leftright left-right"
],[  "»˘y2",
  "Leftmost neighbouring elements (padding at edge)",
  "neighboring neighbours neighbors lefthand bitshift cells items"
],[  "«˘y2",
  "Rightmost neighbouring elements (padding at edge)",
  "neighbours neighbors neighboring lefthand bitshift cells items"
],[  "<˘y2",
  "Table to list of rows",
  "spike downarrow split lists from array into nested nesting rank depth unflatten"
],[  "i0↓˘y2",
  "Drop i0 columns from y2",
  "table delete remove without"
],[  "i0↑˘y2",
  "Adjust y2 to width i0 (positive i0 to pad/chop on right, negative i0 to pad/chop on left)",
  "fill limit"
],[  "⥊˘y",
  "Convert to rank 2 array by flattening each cell to a row",
  "commabar ravelcells flattencells razecells Merge demoterank lessenrank reduce reducing"
],[  "i0⥊˘y1",
  "Table with i0 columns, each consisting of y1",
  "fill table"
],[  "⥊¨y",
  "Ensure that all elements are lists",
  "items elements cells lists uniformity make force to be"
],[  "i1+⌜j1",
  "Addition table for i1 down and j1 across",
  "additiontable cartesianaddition plustable matrix"
],[  "i1×⌜j1",
  "Multiplication table for i1 down and j1 across",
  "multiplicationtable cartesianproduct timestable matrix"
],[  "0⊸/y",
  "Empty array along first axis",
  "dimension 1st"
],[  "F⊸/y",
  "Filter to only those elements of y that satisfy cell-wise criterion F",
  "filtering where cells items"
],[  "+´n1",
  "Sum of n1",
  "summation enlargedsigma bigsigma capitalsigma ∑ Σ sum() horizontally rowwise"
],[  "×´n1",
  "Product of n1",
  "enlargedpi bigpi capitalpi ∏ Π horizontally rowwise"
],[  "×´n1",
  "Area of rectangle with sides n1",
  "edge lengths"
],[  "×´n1",
  "Volume of box with sides n1",
  "block edge lengths"
],[  "∨´b1",
  "Are any true?",
  "anyone? forany thereexists ∃ horizontally rowwise testif forany?"
],[  "∧´b1",
  "Are all true?",
  "forall? ∀ binary base-2 base2 testif"
],[  "⌈´n1",
  "Maximum of n1",
  "supremum biggest largest highest greatest"
],[  "⌊´n1",
  "Minimum of n1",
  "infirmum smallest lowest least"
],[  "÷´n1",
  "Alternating product of n1",
  ""
],[  "≠´b1",
  "Boolean Parity (Even)",
  ""
],[  "∧⎉1 y",
  "Sort each row in ascending order",
  "up increasing sorting reordering ordering"
],[  "⌽⎉1 y",
  "Reverse last axis of y",
  "circlestile reversing dimension"
],[  "<⎉1 y",
  "Nest sub-arrays from last axis",
  "spike downarrow subarrays dimension"
],[  "a1 /⎉1 y",
  "Filter columns of y according to mask a1",
  "compressing slash solidus selecting cells items horizontally across bitmask bit-mask"
],[  "i1 /⎉1 y",
  "Replicate along last axis of y",
  "compressing slash solidus copying repeatingeachcolumns dimension horizontally replicating rowwise row-wise across"
],[  "F⌾⥊y",
  "Handle array y temporarily as a list",
  "columnheadings columnnumbers ⍢, flattened ravelled raveled list"
],[  "⊢˝y",
  "Last cell of y",
  "topmostrow subarray dimension 1st"
],[  "+˝n",
  "Sum of n (column-wise)",
  "summation enlargedsigma bigsigma capitalsigma ∑ Σ vertically columnwise"
],[  "-˝n",
  "Column-wise alternating sum: ((n_0-n_1)+n_2)-n_3+…",
  "alternatingsum series vertically columnwise"
],[  "×˝n",
  "Product of n (column-wise)",
  "enlargedpi bigpi capitalpi ∏ Π vertically columnwise"
],[  "x2∾˘y0",
  "Append unit to each row of table",
  "extend with next merge join concatenate rows table connect"
],[  "x2∾˘y1",
  "Append elements of list to respective rows of table",
  "extend with next merge join concatenate table list connect"
],[  "x∾¨y",
  "Join corresponding elements",
  "juxtapose tuples cells elements zip pair"
],[  "x ∾⎉1 y",
  "Join along last axis",
  "concatenate juxtapose horizontally dimension row-wise rowwise by connect join"
],[  "x1 ∾⎉1 y2",
  "Prefix list to each row of table",
  "prepend rows list table rows"
],[  "x2 ∾⎉1 y1",
  "Postfix list to each row of table",
  "append rows list table rows"
],[  "∾˝y",
  "Combine first two axes of y",
  "Merge demoterank lessenrank reduce flatten reducing table"
],[  "x⋈⌜y",
  "Cartesian product: all pairs from x and y",
  "catalog pairings tuples table matrix"
],[  "≍˘y",
  "Increment rank by inserting a new dimension after the first",
  "additional dimensions axes axis items elements cells extend shape add beginning first 1st"
],[  "≍˘y1",
  "Reshape list y1 into a one-column table",
  "1-column table list"
],[  "x1≍˘y1",
  "Two-column table from two lists (repeat units)",
  "table lists columns"
],[  "≍⎉0 y",
  "Increment rank by inserting a new dimension after the trailing one",
  "additional dimensions axes axis items elements cells extend shape add ending last columnmatrixfromvector"
],[  "≍⎉1 y",
  "Increment rank by inserting a new dimension before the last one",
  "additional dimensions axes axis items elements cells extend shape add ending last"
],[  "F´x‿y",
  "Apply dyadic function as a monadic function on a two-element argument",
  "calling runing converting change changing switching valence arity into dyad-to-monad dyadic-to-monadic binary-to-unary"
],[  "m1 F⎉0‿1 n2",
  "Apply F between list m1 and each column of n2",
  "rank suffixagreement columns distribute columwise column-wise list dimensions axes vertically columnwise"
],[  "F◶1‿G y",
  "Sequential OR test (F∨G with shortcutting)",
  "lazyevaluation sequentialtestif adjacentguard || shortcutting short-circuit minimal evaluation McCarthy"
],[  "F◶G‿0 y",
  "Sequential AND test (F∧G with shortcutting)",
  "lazyevaluation sequentialtestif adjacentguard && shortcutting short-circuit minimal evaluation McCarthy"
],[  "i1⊏˜j1",
  "Generate consolidated left argument for successive transposes i1⍉j1⍉y",
  ""
],[  "¯1⊸⊏y",
  "Tail: Last major cell",
  "y[-1] x[-1] y[¯1] x[¯1] trailing element item ending"
],[  "x ∊⎉1 y",
  "Which elements of x belong to corresponding row of y (≠x ↔ ≠y)",
  "testif memberof isin membership containedin has cells items"
],[  "⊐˜y",
  "Index of first instance of each major cell",
  "items elements indicesof location 1st"
],[  "⊐⟜1 n",
  "Index of first 1 in n",
  "indexof one locate find positionof location 1st"
],[  "x ⊐⎉1 y",
  "Indices of elements of x in corresponding rows of x",
  "indexin indexof find locate positionof rowwise row-wise locating cells items location horizontally"
],[  "⋆⁼n",
  "Natural logarithm of n",
  "naturallogarithm circlestar starcircle splat ln() lnₑ() logₑ()"
],[  "m⋆⁼n",
  "Base-m logarithm of n",
  "logarithms logs circlestar starcircle splat log() log₁₀()"
],[  "/⁼j1",
  "Convert set of indices j1 to a mask",
  "indicate masking indicating bitmask bit-mask converting change changing"
],[  "+`n",
  "Cumulative sum",
  "runningtotal"
],[  "∨`b",
  "Turn on all 1s after first 1 (indicate all elements except leading 0s)",
  "indicating flipping turning change changing inverting negating bitmask bit-mask zeros zeroes trues truths ones falses falsehoods 1st start beginning mask not"
],[  "∧`b",
  "Turn off all 1s after first 0 (indicate all elements until the first 0)",
  "indicating flipping turning change changing inverting negating bitmask bit-mask ones zero false trues truths falsehood 1st mask"
],[  "⌈`n",
  "Progressive maxima (column-wise)",
  "running cumulative scan columnwise vertically"
],[  "⌊`n",
  "Progressive minima (column-wise)",
  "running cumulative scan columnwise vertically"
],[  "≠`b",
  "Convert reflected Gray code to binary",
  "flip change changing inverting negating bitmask bit-mask base-2 base2 mask Conversion converting change changing"
],[  "≠`b",
  "Parity: Connect odd and even ones",
  "flip change changing inverting negating bitmask bit-mask 1s running trues truths mask"
],[  "<`b",
  "Indicate 1s preceded by an even number of 1s in their group",
  "indicating flipping turning change changing inverting negating bitmask bit-mask zeros zeroes falses ones trues truths falsehoods 1st mask"
],[  "⍉⎉2 y",
  "Transpose every submatrix of y",
  "cant ^T ⸆ ᵀ sub-matrix sub-table subtable planes"
],[  "F⌾⍉y",
  "Apply action F defined on rows to columns instead",
  ""
],[  "¯1⊸⊑y1",
  "Pick last element of list y1",
  "element cell list"
],[  "expr⊣name←y",
  "Combining two lines into one",
  "lev lefttack where"
],[  "+∘-n",
  "Negate real part (“real conjugate”)",
  ""
],[  "-∘+n",
  "Mirror complex n across y-axis",
  "negatereal mirroring reflecting reflection"
],[  "m×∘-n",
  "Sign of difference (¯1:m is smaller, 0:m=n, 1:m is bigger)",
  "signum cmp() <=> >-< spaceship space-ship three-way compare comparing comparison"
],[  "m⌊∘÷n",
  "Integer Division",
  "intdiv() ≢ // divmod()"
],[  "m|∘-n",
  "Absolute distance between x and y",
  "magnitudeof cartesian"
],[  "a¬∘∨b",
  "Logical NOR",
  "peirce'sarrow quine'sdagger ampheck neithernor jointdenial Xpq ⊽ neither-nor gate †"
],[  "a¬∘∧b",
  "Logical NAND",
  "shefferstroke notand andtilde carettilde alternativedenial Dpq ⊼ gate"
],[  "m¬∘∧n",
  "Probabilistic NAND",
  "fuzzy probability chance shefferstroke notand alternativedenial Dpq ⊼"
],[  "»⊸<b",
  "Boolean first ones in each group of ones",
  "beginningsofruns trues truths 1st binary base-2 base2 runs sequences blocks"
],[  "a0-⊸↓y",
  "Conditional drop of last element of y",
  "trailing cell item delete remove ending without"
],[  "i0-⊸↑y1",
  "Pad y1 on the left to width i0",
  "extend left-align leftalign text"
],[  "x≠⊸⥊y",
  "Array with shape of x and content of y",
  "reshape mould mold form fill"
],[  "¬⊸-n",
  "Convert 0 to 1 and 1 to -1 with a linear transformation",
  "affine unit interval boolean sign reverse negative"
],[  "a¬⊸∨b",
  "Probabilistic implication",
  "fuzzy probability chance materialconditional materialconsequence implies implying materialimplication therefore ∴ ⇒ Cpq"
],[  "m¬⊸∧n",
  "Probabilistic converse nonimplication",
  "fuzzy probability chance ⇍ Mpq"
],[  "a¬⊸⋆n",
  "Conditional change of elements of n to one according to a",
  "1 cells items changing converting conversion"
],[  "×⟜|n",
  "Square without changing sign",
  "remove change converting conversion"
],[  "x«⟜»y",
  "Replace last major cell of y with x0 (slow)",
  "substitute merge amend replace update item element"
],[  ">⟜«b",
  "Boolean last ones in each group of ones",
  "endsofruns 1s trues truths binary base-2 base2"
],[  "i1⥊⟜<y",
  "Array of shape i1 filled with copies of y",
  "copy repeat repetitions duplicate reshape"
],[  "-⟜¬n",
  "Convert range [0,1] to [-1,1] with a linear transformation",
  "affine unit interval boolean sign"
],[  "a∨⟜¬b",
  "Probabilistic converse implication",
  "fuzzy probability chance because ∵ ⇐ if converseconditional Bpq reverseimplying"
],[  "m∧⟜¬n",
  "Probabilistic nonimplication",
  "fuzzy probability chance abjunction ⇏ not butnot Lpq"
],[  "1⊸↑˘ y2",
  "First column as a column matrix (column list)",
  "leftmostcolumn leading 1st table list start beginning"
],[  "¯1⊸↑˘ y2",
  "Last column as a column matrix (column list)",
  "rightmostcolumn trailing table list ending"
],[  "⊢⌜˜y1",
  "Square matrix with y1 as rows",
  "tomatrixof table"
],[  "⊣⌜˜y1",
  "Square matrix with y1 as columns",
  "tomatrixof table"
],[  "x≡○∧y",
  "Are x and y permutations of each other?",
  "testif permutation? permutationof?"
],[  "m∧○¬n",
  "Probabilistic NOR",
  "fuzzy probability chance peirce'sarrow quine'sdagger ampheck neithernor jointdenial Xpq ⊽"
],[  "≠∘/b",
  "Number of trues",
  "+/, +⌿, sum all howmanytrue count tally 1s ones truths"
],[  "F´∘⥊y",
  "Fold F over all elements without respect to shape",
  "reduce insert over rowwise reducing folding row-wise horizontally remove"
],[  "⌽⌾⥊y2",
  "Rotate 180°",
  "turning rotating rotation half-turn halfturn"
],[  "+˝⎉1 n",
  "Sum of n (row-wise)",
  "summation enlargedsigma bigsigma capitalsigma ∑ Σ sum() horizontally rowwise"
],[  "×˝⎉1 n",
  "Product of n (row-wise)",
  "enlargedpi bigpi capitalpi ∏ Π horizontally rowwise"
],[  "1⊸∾˘y2",
  "Preface a column of 1s",
  "ones trues truths"
],[  "∾⟜1˘y2",
  "Append a column of 1s",
  "ones trues truths"
],[  "i0/⟜≍y1",
  "Table with i0 rows, each consisting of y1",
  "fill table"
],[  "∾∘≍y",
  "Join array of arrays vertically",
  "aboveandbelow stack merge flatten column-wise columnwise"
],[  "∾∘≍y1",
  "Join elements of y1 along the second axis",
  "combine merge joinhorizontally cells elements dimensions"
],[  "⌽‿i0⥊y1",
  "Reshape y1 to i0-column table (filled row-wise)",
  "table horizontally rowwise columns"
],[  "i0‿⌽⥊y1",
  "Reshape y1 to i0-row table (filled row-wise)",
  "table horizontally rowwise rows"
],[  "0‿0⊸↓y",
  "Increase rank of y to at least 2 by adding length-1 leading axes",
  "number of dimensions 2D axes matrify matricise matricize make"
],[  "i0⊏∘⌽y",
  "Select major cell of y at cyclic offset i0 (default i0:¯1)",
  "element item"
],[  "i0⊏⟜∨y",
  "i0'th-largest major cell of y",
  "greatestof maximum biggest lexicographically item element"
],[  "i0⊏⟜∧y",
  "i0'th-smallest major cell of y",
  "leastof minimum lexicographically item element"
],[  "↕∘=y",
  "All axes of array y",
  "dimensions"
],[  "↕∘≠y",
  "Indices of Major Cells of y",
  "enumerate number count items elements"
],[  "↕∘≠y2",
  "All row indices of table y2",
  "enumerate rows table"
],[  "↕∘≢y",
  "All indices of y, as a matching-shape array",
  "indicesof"
],[  "⥊∘↕y1",
  "All tuples of corresponding elements of ↕¨y1 (for small y1)",
  "indices major cells items"
],[  "↕⊸÷j0",
  "Start points when [0,1) is split into j0 intervals",
  "unit normalized steps linear divide"
],[  "m0×⟜↕j0",
  "Arithmetic progression vector: j0 steps of m0",
  "sequence"
],[  "↕⊸∾j0",
  "Integers from 0 to j0 inclusive",
  "unsigned natural whole numbers additional extra"
],[  "m0↕∘⋈n0",
  "Catalogue of all pairs from ↕m0 and ↕n0",
  "pairings tuples table matrix"
],[  "x¬∘∊y",
  "Boolean elements in x that are not in y",
  "isnotin membership notcontainedin hasn't doesnothave elementof ∉ cells elements binary base-2 base2"
],[  "∊∘/j1",
  "Change lengths j1 of sublists to starting indicators",
  "partitions change converting conversion segments"
],[  "x/∘∊y",
  "Indices of all cells in x that appear in same-rank array y",
  "locate find membersof positionsof locating cells items location"
],[  "m0∊⟜↕n0",
  "Is m0 in range 0…n0-1?",
  "inrange? valid? testif"
],[  "∨⊸⊐y",
  "Descending cardinals numbers (ranking, ties equal)",
  "falling do"
],[  "∧⊸⊐y",
  "Ascending cardinals numbers (ranking, ties equal)",
  "rising up"
],[  "x⌽⊸⊐y",
  "Last indices in x of major cells y, counted from the rear",
  "indexin indexof find locate positionof locating items elements location"
],[  "x⍋⌾⋈y",
  "Is x lexically less than or equal to y?",
  "testif tao totalarrayordering notafter precedesorequivalentto ≼ ⊁ lexicographically"
],[  "x⍋⊸⊏y",
  "Sorting y according to x",
  "ordering"
],[  "x⍋∘⊐y",
  "Grade up of y according to key x",
  "custom sort order ascending"
],[  "⍋∘⍋y",
  "Permutation that sorts like y",
  "ranking list"
],[  "⍋∘⍋y",
  "Ascending cardinal numbers (ranking, all different)",
  "rising up"
],[  "x⍒⌾⋈y",
  "Is x lexically greater than or equal to y?",
  "testif tao totalarrayordering notbeforefollowsorequivalentto ≽ ⊀ lexicographically"
],[  "a1⍒⊸⊏y",
  "Moving cells of y indicated by a1 to the start of y",
  "conditional promote promotion items elements beginning leading"
],[  "x⍒∘⊐y",
  "Grade down of y according to key x",
  "custom sort order descending"
],[  "⍋∘⍒y",
  "Descending cardinal numbers (ranking, all different)",
  "falling down"
],[  "⌈`⎉1 n",
  "Progressive maxima (row-wise)",
  "running cumulative scan rowwise horizontally"
],[  "⌊`⎉1 n",
  "Progressive minima (row-wise)",
  "running cumulative scan rowwise horizontally"
],[  "F`⌾⌽y",
  "Scan from end with F",
  "cumulativereduce rowwise backscan backwards suffix scanning row-wise horizontally trailing ending"
],[  "+`⁼n",
  "Difference of adjacent pairs with seed value",
  "differences deltas changes steps"
],[  "≠`⁼b",
  "Convert binary to reflected Gray code",
  "base-2 base2 Conversion converting change changing"
],[  "⍉∘+n2",
  "Conjugate Transpose",
  "self-adjoint selfadjoin Yᴴ y^H y† y^† Aᴴ a^H a† a^†"
],[  "⌽∘⍉y2",
  "Rotate 90° clockwise",
  "turning rotating rotation -90° ¯90° quarter-turn quarterturn"
],[  "⍉∘⌽y2",
  "Rotate 90° counter-clockwise",
  "turning rotating rotation -90° ¯90° quarter-turn quarterturn counterclockwise"
],[  "⍉∘>y1",
  "Convert inverted table to table (character data as lists of lists)",
  "matrix tables transforming transformation change changing into un-inverting un-inversion un-vertion unverting unversion unvertion"
],[  "⍉⊸≡y2",
  "Is y2 a symmetric matrix?",
  "testif"
],[  "0‿0⊸⍉y2",
  "Main diagonal of matrix",
  "table"
],[  "i0⊑∘⌽y1",
  "Pick element of list y1 at cyclic offset i0 (default ¯1)",
  "element cell list ⎕ioindependent ⎕ioindependence ⎕io-insensitive ⎕ioinsensitive Choosing choose ⎕io=0"
],[  "⊑∘/b",
  "Index of first satisfied condition in b",
  "1st"
],[  "⊑∘⍋y",
  "Index of smallest cell in y (earliest index for ties)",
  "find locate positionof least minimum lexicographically lexically locating location"
],[  "⊑∘⍒y",
  "Index of largest cell in y (earliest index for ties)",
  "find locate positionof biggest greatestif maximum lexicographically lexically locating location"
],[  "⊒∘⍋y",
  "Index of minimum cell of y",
  "lesser smaller smallest lowest least"
],[  "⊒∘⍒y",
  "Index of maximum cell of y",
  "greater larger bigger greatest biggest largest highest"
],[  "⍷⊸≡y",
  "Are all major cells distinct?",
  "testif alldifferent? allunequal? noduplicates? nodups? items elements alldistinct? allunique?"
],[  "i1/⊸⊔y",
  "Cut y into partitions of length i1 (+´i1 ↔ ≠y)",
  "chop split separate chunks segments"
],[  "@⊸+i",
  "Characters to Unicode code point numbers",
  "utf-8 utf8 utf-16 utf16 utf-32 utf32 ucs-4 ucs4 ucs-2 ucs2 iso10646 ord() num() chr() char() ascii latin-1 windows-1252 ansi mapping UniversalCodedCharacterSet UniversalCharacterSet codepoints code-points converting change changing"
],[  "-⟜@c",
  "Characters from Unicode code point numbers",
  "utf-8 utf8 utf-16 utf16 utf-32 utf32 ucs-4 ucs4 ucs-2 ucs2 iso10646 ord() num() chr() char() ascii latin-1 windows-1252 ansi mapping UniversalCodedCharacterSet UniversalCharacterSet codepoints code-points converting change changing"
],[  "m1(F⎉1)n2",
  "Apply F between list m1 and each row of n2",
  "rank prefixargeement rows distribute rowwise row-wise list dimensions axes horizontally"
],[  "x(F⎉0)y",
  "Run F on units",
  "apply"
],[  "a ¯1⊸⋆⊸× n",
  "Conditional elementwise change of sign",
  "signum conditionalnegation changing converting conversion"
],[  "x2↑˜⟜≠y2",
  "Vertically lengthening table x2 to be compatible (for ∾˘) with y2",
  "compatibility sameheight adjust column-wise columnwise table"
],[  "i0⥊⟜0⊸»y1",
  "Shift y1 right by i0, padding on left",
  "rightshift list"
],[  "i0⥊⟜0⊸«y1",
  "Shift y1 left by i0, padding on right",
  "leftshift list"
],[  "i0⥊⟜0⊸↓y",
  "Increase rank of y to i0",
  "number dimensions axes"
],[  "+/∘⥊b",
  "Number of trues",
  "sumall howmanytrue count tally 1s ones truths"
],[  "+/∘⥊n",
  "Sum all elements in an array",
  "sumall +⌿, grandtotal sumitems cells items"
],[  "a1+⟜1⊸/y",
  "Duplicate y cells where indicated by a1",
  "replicate double items elements"
],[  "a1+´∘×n1",
  "Summation over subsets of n1 specified by a1",
  ""
],[  "m1+´∘×n1",
  "Dot product of vectors m1 and n1",
  " dotproduct vectorproduct ∙ ⋅ · multiplication multiply"
],[  "m1⌈´∘×n1",
  "Maximum of n1 with weights m1",
  "greatestif largest biggest"
],[  "m1⌊´∘×n1",
  "Minimum of n1 with weights m1",
  "smallest least"
],[  "m1+´∘÷n1",
  "Sum of reciprocal series m1÷n1",
  "sequence"
],[  "m1-´∘÷n1",
  "Sum of alternating reciprocal series m1÷n1",
  "sequence"
],[  "+´∘|n",
  "Sum of magnitude of n",
  "absolutesummation sumabs"
],[  "⌈´∘|n",
  "Infinity-norm",
  "L∞-normal L-∞ ℓ∞ ℓ-∞ Linf"
],[  "⌈´∘|n1",
  "Largest magnitude found in n1",
  "rowwise horizontally biggest greatestif maximum absolute value"
],[  "⌊´∘|n1",
  "Smallest magnitude found in n1",
  "rowwise horizontally least minimum absolute value"
],[  "x1+´∘=y1",
  "Count pairwise matches (equal elements) in two lists",
  "cells items lists"
],[  "x1+´∘≠y1",
  "Hamming distance",
  "edit"
],[  "×´∘≢y",
  "Count the number of elements (bound) of an array",
  "tallyall ≢, numberofelements numberofitems howmanyelements howmanyitems whole scalars countall ×⌿≢ ≠, ≢, cells items"
],[  "=´∘≢y2",
  "Is y2 a square matrix?",
  "square? table"
],[  "∨´∘⥊b",
  "Are any true?",
  "testif forany thereexists forsome existentialquantification ∃ ⋁ any?"
],[  "∧´∘⥊b",
  "Are all true?",
  "testif forall ∀ ⋀ givenany tautology universalquantification"
],[  "n1×´∘⋆b1",
  "Products over subsets of n1 specified by b1",
  "sub-sets"
],[  "+⟜÷´n",
  "Evaluate continued fraction with terms n",
  "series sequence"
],[  "+´⌾÷n1",
  "Ohm's Law: resistance of parallel resistors/capacitance of serial capacitors",
  "electronics electrics circuits Ω series inparallel"
],[  "<∘∾˘y2",
  "Turn a table of lists into a list of lists by joining each row",
  "format merge along rows concatenate lines each"
],[  "∘‿2⊸⥊y1",
  "Reshape list y1 into a two-column table",
  "2-column table list"
],[  "¬∘a0◶F‿G y",
  "Ternary: if a0 then apply F to y else apply G to y",
  "conditionaloperator inlineiff ternaryiff ?:"
],[  "x1∨´∘∊y1",
  "Do x1 and y1 have any elements in common?",
  "testif anyshared? anycommon? cells items"
],[  "x1∧´∘∊y1",
  "Is x1 a Subset of y1?",
  "testif subset? containedin ⊆"
],[  "i∊˜⟜↕j0",
  "Boolean list of length j0 with ones in locations i (inverse of ⍸b1)",
  "inversion 1s trues truths list binary base-2 base2"
],[  "⊐˜∘⊐y",
  "Index of first instance of each major cell (safe with tolerant comparison)",
  "items elements indicesof location 1st"
],[  "/⁼∘⊐y",
  "Count of occurrences of each unique major cell",
  "elements items how many repetitions times repeated occurrences statistics items elements"
],[  "x/⁼∘⍋y",
  "Distribution of y into intervals with cut-offs x",
  "bins groups ranges buckets"
],[  "+`∘»j1",
  "Starting positions of sublists having lengths j1",
  "sub-vectors sub-lists sublists"
],[  "x∧`∘=y",
  "Indicate leading elements that are equal",
  "show matching onleft cells items masking indicating start beginning"
],[  "x∧`∘≠y",
  "Indicate leading elements that are unequal",
  "show different onleft cells items masking indicating start beginning"
],[  "≠`⊸∨b",
  "Parity with connectors: Joining pairs of odd and even ones (fill gaps with ones)",
  "1s trues truths"
],[  "+`∘↕j0",
  "First j0 triangular numbers",
  "oeisA000217 oeisA217 1st"
],[  "<˘∘⍉y2",
  "Table to list of column lists (inverted table)",
  "split table lists into columns vertically column-wise columnwise boxed enclosed table matrix transforming transformation change changing into inverting inversion"
],[  "a1/¨⊸⊔y",
  "Partition y along each axis by list of partition length lists a1",
  "chop split cut separate chunk segmented sub-matrices submatrices sub-tables subtables partitioned block-matrix table dimensions blockmatrix"
],[  "a1+`⊸⊔y",
  "Partitioned y at 1s in a1 along first axis",
  "chop split cut separate chunk sub-vectors segmented sub-lists subvectors sublists dimension"
],[  "m(0⌈⌊)n",
  "Force numbers n to range 0≤n≤m",
  "clamp restrictrange between 0–"
],[  "i(1+|)j",
  "Increment cyclic counter j with upper limit i",
  ""
],[  "(1||)n",
  "Magnitude of fractional part of n",
  "absolutedecimals"
],[  "i(0=|)j",
  "Does i divide j?",
  "testif divides divisibility divisor ∣"
],[  "(0==)y",
  "Is y a unit?",
  "testif"
],[  "(1==)y",
  "Is y a list?",
  "testif rank1"
],[  "i(0≠|)j",
  "Does i not divide j?",
  "testif divisibility divisor ∤ dividing"
],[  "(0=≡)y",
  "Is y an atom?",
  "testif simple?"
],[  "(1=≡)y",
  "Is y an array of atoms?",
  "testif simple?"
],[  "(1↓≢)y",
  "Dimensions of major cells",
  "shape items elements axes"
],[  "(¯1↓≢)y",
  "Lengths of leading axes",
  "shape dimensions start beginning"
],[  "(1+↕)j0",
  "Integers from 1 to j0",
  "whole numbers naturals 1st"
],[  "x(1=⍋)y",
  "Is y within the range [ x_0 , x_1 )",
  "testif ≤y< ≤x< tao totalarrayordering interval inrange?"
],[  "x(1≠⍋)y",
  "Is y outside the range [ x_0 , x_1 )",
  "testif >y≥ >x≥ tao totalarrayordering interval outsiderange?"
],[  "(¯1⊑≢)y",
  "Length of last axis",
  "count length() cells len() cells elements dimension ending"
],[  "(¯1⊑≢)y2",
  "Number of columns in y2",
  "trailingshape"
],[  "⟨⟩⊸⥊y",
  "First element of y as a unit",
  "1st cell item"
],[  "⟨⟩⊸⥊y",
  "Enclosed top corner (or first element) of y; fill if y is empty",
  "first top-left topleft northwest north-west NW cell item 1st"
],[  "⟨⟩⊸⍉y",
  "Convert y to array (enclose if atom)",
  "leftshoeunderbar encloseifsimple conditionalenclose boxsimple eis condenclose"
],[  "m ×⎉1‿∞ n",
  "Mid product of m and n",
  "midproduct"
],[  "'0'⊸+d",
  "Translate digit numbers to characters",
  "base-2 base2 binary Boolean decimal converting change changing"
],[  "-⟜'0'd",
  "Translate character digits to numbers",
  "base-2 base2 binary Boolean decimal converting change changing"
],[  "-⟜'a'd",
  "Convert lowercase letters to their positions in the alphabet",
  "nth ordinals Conversion converting change changing"
],[  "m×⊸×⟜|n",
  "Transfer sign from m to n",
  "signum resign"
],[  "x 0¨∘≢⊸↓ y",
  "Increase rank of y to rank of x",
  "conform align number dimensions axes"
],[  "-⟜»∘/i1",
  "Segment lengths given the number of segments that end at each position",
  "chunk trailing converting change changing segments partitions"
],[  "+´∘×˜n1",
  "Sum of squares of n1",
  "∑x² Σx² sum(x^2) Pythagorean trigonometry"
],[  "x2∧˝˘∘=y0",
  "Boolean rows of x2 all equal to unit y0",
  "findall lookup binary base-2 base2 compare equality match"
],[  "x0∨˝˘∘≠y2",
  "Do rows of y2 contain elements differing from x0?",
  "testif hasdifferent cells items"
],[  "x ∧˝∘=⎉1 y1",
  "Compare list y1 with rows of array x",
  "list compare equality match"
],[  "1¨∘⊏⊸∾y",
  "Preface a row of 1s",
  "ones trues truths"
],[  "⌈⌜˜∘↕j0",
  "Maximum table of 0…j0-1",
  "matrix"
],[  "=⌜˜∘↕j0",
  "Identity matrix of order j0",
  "unitmatrix table"
],[  "≠⌜˜∘↕j0",
  "Non-diagonal matrix of order j0",
  "nondiagonal table"
],[  "<⌜˜∘↕j0",
  "Upper triangular matrix without diagonal: j0 by j0",
  "triangle NE northeast north-east table remove strict"
],[  ">⌜˜∘↕j0",
  "Lower triangular matrix without diagonal: j0 by j0",
  "triangle SW southwest south-west table remove strict"
],[  "≤⌜˜∘↕j0",
  "Upper triangular matrix with diagonal: j0 by j0",
  "triangle NE northeast north-east table"
],[  "≥⌜˜∘↕j0",
  "Lower triangular matrix with diagonal: j0 by j0",
  "triangle SW southwest south-west table"
],[  "↕⊸∾⊸÷j0",
  "Endpoints when [0,1] is split into j0 intervals (including 0 and 1: j0+1 total)",
  "unit normalized steps linear divide"
],[  "x1∧´∘∊˜y1",
  "Is x1 a superset of y1?",
  "testif superset? contains ⊇"
],[  "i¬∘∊⟜↕j0",
  "Boolean list of length j0 with zeros in locations i",
  "zeroes 0s falses falsehoods list binary base-2 base2"
],[  "i1∊⟜↕⟜≠y",
  "Starting points for y in indices pointed by i1",
  "segmented partitioned starts beginnings"
],[  "i1+`⊸∊˜b1",
  "Mask to get sublists with indices i1 as indicated by b1",
  "sub-vectors masking indicating bitmask bit-mask"
],[  "+`⍟2∘↕j0",
  "First j0 triangular pyramidal numbers",
  "figurative tetrahedral oeisA000292 oeisA292 1st"
],[  "⌽∘⍉∘⌽y2",
  "Reflect counter-diagonally",
  "mirroring reflecting reflection counterdiagonally mirror"
],[  "0¨∘≢⊸⍉y",
  "Main diagonal of any rank array",
  "maindiagonal nwse nw-se majordiagonal"
],[  "∧˘⌾⍉⎉2 y",
  "Sort each column in ascending order",
  "up increasing sorting reordering ordering"
],[  "i0‿⌽⍉∘⥊y1",
  "Reshape y1 to i0-column table (filled column-wise)",
  "table vertically columnwise columns"
],[  "⊑∘⌽∘⥊y",
  "The last element of y",
  "cell element"
],[  "x⊑∘/∘≠y",
  "Index of first differing element in x and y",
  "indexin indexof find locate positionof unequal different 1st locating cell item difference location"
],[  "x⊑∘/∘∊y",
  "Index of first occurrence in x of any cell of y",
  "cell element find locate 1st position find location"
],[  "a1+`¨⊸⊔y",
  "Partition y along each axis by list of partition indicators a1",
  "chop split cut separate chunk segmented sub-matrices submatrices sub-tables subtables partitioned block-matrix table dimensions blockmatrix"
],[  "m(⊢-|)n",
  "Largest whole multiple of m less than or equal to n (n rounded down to closest smaller multiple of m)",
  "without less nodivisionremainder bar() noresidual intmultiples smaller ≤ integer unit floor"
],[  "(×|⊢)n",
  "Fractional part with sign",
  "decimals"
],[  "(⊢=+)n",
  "Is n real?",
  "testif"
],[  "(⌊=⊢)n",
  "Is n integer?",
  "testif whole number?"
],[  "(⊢≠+)n",
  "Is n complex?",
  "testif"
],[  "(⌽≡⊢)d1",
  "Is d1 a palindrome?",
  "testif"
],[  "(⋆×˜)n",
  "Limit of nominal rate n when continuously compounded",
  "interest"
],[  "(¬2⊸|)j",
  "j is Even",
  ""
],[  "(¬2|/)j1",
  "Alternating sequence of j1_0 ones, j1_1 zeros, j1_2 ones, …",
  "1s 0s zeroes naughts falses falsehoods trues truths"
],[  "(0⌈´⊢)n",
  "Positive maximum, at least zero (even for empty n)",
  "largest biggest"
],[  "i0(↑⋈↓)y",
  "First and last i0 major cells of y",
  "headtail split divide separate dividing first leading remaining"
],[  "m0(+≍-)n0",
  "m0±n0",
  "plusminus"
],[  "m0(-≍+)n0",
  "m0∓n0",
  "minusplus"
],[  "x1(⥊≍˘)y1",
  "Merge equal-length lists x1 and y1 alternately",
  "faro weave dovetail zipper zipping merge interweave interweaving interleave interleaving shuffle shuffling meshing lists zip()"
],[  "x0(⥊≍⎉0)y1",
  "Insert x0 after each element of y1",
  "cell item"
],[  "(1‿¯1×<)n",
  "±n by juxtaposition",
  "plusminus"
],[  "(¯1‿1×<)n",
  "∓n by juxtaposition",
  "minusplus"
],[  "F⌾(¯1⊸⊏)y",
  "Apply function F to last cell of y",
  "onlast item element"
],[  "(1+2×↕)j0",
  "Odd integers from 1 to 2×j0",
  "numbers 1st"
],[  "(↕¯1↑≢)y",
  "Indices for trailing axes of y",
  "shape dimension ending"
],[  "x(∊/⊣)y",
  "Intersection: major cells of x that appear in y",
  "setand items elements"
],[  "x(⌈´⊐)y",
  "Index of last occurrence in x of any major cell of y",
  "element find locate location indexin indexof positionof locating cells items"
],[  "x(⌊´⊐)y",
  "Index of first occurrence in x of any major cell of y",
  "element find locate 1st location indexin indexof positionof locating cells items"
],[  "10⊸(⋆⁼)n",
  "Common logarithm",
  "log() log-10 log10() 10-log₁₀() lg() lg-10 lg10() 10-lg₁₀()"
],[  "x F⍟(↕1+y0) z",
  "Apply F y0 times to z, returning initial value z and all intermediate results",
  "apply application repeated converge repeating looping power intermediaries intermediate all sequence"
],[  "(⍉≡+)n2",
  "Is n2 a Hermitian matrix?",
  "testif Hermitian? self-adjoint? selfadjoint? Yᴴ y† Aᴴ a†"
],[  "(-≡⍉)y2",
  "Is y2 an anti-symmetric matrix?",
  "testif antisymmetric skewsymmetric skew-symmetric"
],[  "(⊑0⥊<)y",
  "Type (convert to fill element)",
  "prototype ⍷ datatypeof 0s zeroes spaces blanks zeros falses falsehoods"
],[  "(⊑0⊸⥊)y",
  "Fill element (converts characters to spaces, numbers to zeros)",
  "fillelement padding 0s zeroes type cell item blanks falses falsehoods"
],[  "(↕¯1⊑≢)y2",
  "All column indices of y2",
  "enumerate columns"
],[  "m(π××)n",
  "Area of cone with height m and radius n (excluding base)",
  "lengths bottom"
],[  "⊐⟜' '⎉1 d",
  "Indices of first blanks in rows of array d",
  "1st spaces row-wise rowwise text horizontally"
],[  "x0+´∘⥊∘=y",
  "Number of occurrences of atom x0 in array y",
  "count tally"
],[  "m1-´∘×⟜⌽n1",
  "Scalar cross product of 2-dimensional vectors m1 and n1",
  " vectorproduct signed area parallelogram"
],[  "c⊑∘∊˜⟜<d1",
  "Is string d1 a member of list of strings c",
  "isin membership containedin has vtv vector"
],[  "(0=≠∘⥊)y",
  "Is y an Empty Array?",
  "testif isempty? isvoid? isnull?"
],[  "(1=≠∘⥊)y",
  "Is y a singleton (array with only one element)?",
  "testif unit? sole? one?"
],[  "(¯128+256|128⊸+)j",
  "Convert from unsigned short integers to signed short integers",
  "datarepresentation converting change changing"
],[  "¯97⊸(|-⊣)i0",
  "SWIFT check digit from i0 bank number",
  "correct validate"
],[  "(1«»⊸≠)y1",
  "Which elements differ from next ones",
  "testif neighbouring neightbors neighboring neighbours neighbors righthand cells items 1s trues truths"
],[  "(1«»⊸≠)y1",
  "Indicate end of each group of consecutive equal elements",
  "runs sequences Boolean major cells items indicate masking indicating trailing binary base-2 base2"
],[  "(1»≠⟜«)y1",
  "Which elements differ from previous ones",
  "testif neighboring neighbours neighbors lefthand cells items 1s trues truths"
],[  "(1»≠⟜«)y1",
  "Indicate start of each group of consecutive equal elements",
  "runs sequences Boolean major cells items indicate masking indicating starting starts beginnings leading binary base-2 base2"
],[  "i1(>⥊⟜<)y",
  "Shape i1∾≢y array with copies of y for cells",
  "copy repeat repetitions duplicate reshape"
],[  "i0↑⟜(⥊⟜1)j0",
  "Prefix List: length i0 with j0 ones on the left, the rest zeroes",
  "1s 0s zeros Is𝕨Js falses falsehoods trues truths"
],[  "(<˘0⊸↓)y",
  "List of major cells for any rank",
  "vectorise vectorize list dimensions higher high-rank any-rank highrank anyrank items elements axes"
],[  "(+´÷≠)n",
  "Arithmetic mean of n",
  "average arithmeticmean() AM() avg() mean()"
],[  "(×´1↓≢)y",
  "Number of elements in major cells",
  "shape items"
],[  "(×´¯1↓≢)y",
  "Number of rows (1-cells) in array y",
  "list"
],[  "(3÷˜×´)n1",
  "Volume of pyramid with height, width, length n1",
  "lengths sides"
],[  "x0¨⌾(b1⊸/)y1",
  "Replace elements of y1 with x0 where b1 is 1",
  "substitute merge amend replace update major cells items indicate masking indicating"
],[  "(⊢-⌊˝)n",
  "Normalise n so that minimum value is 0",
  "normalize zero smallest least cell element"
],[  "(⊢÷+˝)n",
  "Normalise n so that sum is 1",
  "normalize one"
],[  "(⊢=⌈˝)n1",
  "Mask of positions where the global maximum occurs in n1",
  "indicate where equal to maxima maximums location masking indicating"
],[  "(+˝÷≠)n",
  "Column-wise arithmetic mean of n",
  "average arithmeticmean() AM() avg() mean()"
],[  "(≠√×˝)n",
  "Geometric mean",
  "average GM() G() geometricmean"
],[  "a(∾∧⟜<)b",
  "Expand a by replacing 1s with same-rank array b, and 0s with 0×b",
  "nest fractal replace copies"
],[  "(⌊⋈1⊸|)n0",
  "Integral and fractional part of positive number",
  "parts split whole decimals"
],[  "1⊸(↑⋈↓)y",
  "First element (as list) and remaining elements",
  "headtail split divide separate dividing leading"
],[  "(⥊˜0⊸⋈)j0",
  "Initialise a table with j0 columns and no rows",
  "table"
],[  "x(∾˝≍˘)y",
  "Merge cells of equal-length arrays x and y alternately",
  "faro weave dovetail zipper zipping merge interweave interweaving interleave interleaving shuffle shuffling meshing lists zip()"
],[  "(1‿¯1×⌜⊢)n",
  "±n as two major cells of the result",
  "plusminus dimensions axes"
],[  "(¯1‿1×⌜⊢)n",
  "∓n as two major cells of the result",
  "minusplus dimensions axes"
],[  "x1(⥊∾⎉1‿0)y1",
  "Insert x1 before every element of y1",
  "merge cell item"
],[  "(↕÷-⟜1)j0",
  "j0 evenly spaced numbers starting at 0 and ending at 1",
  "unit normalized steps linear divide inclusive"
],[  "(×´1+↕)i0",
  "Factorial",
  "countpermutations exclamation bang shriek combinatorics fact() gamma() Γ"
],[  "(2×↕⊸∾)j0",
  "Even integers from 0 to 2×j0",
  "numbers 1st"
],[  "i0↕⟜(↕≠)y",
  "Moving width-i0 window of indices for array y",
  ""
],[  "(1«∊∘/)j1",
  "Change lengths j1 of sublists to ending indicators",
  "partitions trailing change converting conversion segments"
],[  "i(⌊1+⋆⁼)j",
  "Length to represent j in base i",
  "width representation required digits positions"
],[  "m(⌊⟜-⍟2)n",
  "Force numbers n to range (-m)≤n≤m",
  "clamp restrictrange between ±m"
],[  "x(¬⍋⌾⋈)y",
  "Is x lexically greater than y?",
  "testif tao totalarrayordering after follows ≻ ⋠ ⋩ lexicographically succeeds"
],[  "x(1=⌽⊸⍒)y",
  "Are cells of y within the range ( x_0 , x_1 ]?",
  "testif <y≤ <x≤ tao totalarrayordering interval inrange?"
],[  "x(1≠⌽⊸⍒)y",
  "Are cells of y outside the range ( x_0 , x_1 ]?",
  "testif ≥y> ≥x> tao totalarrayordering interval outsiderange?"
],[  "x(¬⍒⌾⋈)y",
  "Is x lexically less than y?",
  "testif totalarrayordering tao before precedes ≺ ⋡ ⋨ lexicographically"
],[  "(¬∧≠`)b",
  "Places between pairs of ones",
  "1s trues truths"
],[  "(+´∧`)b1",
  "Count of leading ones",
  "1s trues truths at start beginning"
],[  "m2(1⍉˘×⌜)n2",
  "Direct matrix product",
  "table"
],[  "(1=⊒)⊸/y",
  "Distinct major cells that appear at least twice",
  "duplicated duplicates nonunique items elements"
],[  "(1=≠∘⍷)y",
  "Are all major cells of y identical?",
  "testif allsame allmatch? elements items allidentical allequal"
],[  "(1<≠∘⍷)y",
  "Are any major cells distinct?",
  "testif anydifferent? anyunequal? anyunique? items elements"
],[  "(1≥≠∘⍷)y",
  "Are all major cells identical?",
  "testif allsame? allequal? nounique? items elements"
],[  "⍉∘>x1‿y1‿…",
  "n-column table from n lists",
  "transpose columns table lists"
],[  "(⌊0.5+⊢)n",
  "Round to nearest integer, ties towards ∞",
  "precision favoring whole number favoring closestinteger nearestinteger nint()"
],[  "(32+1.8⊸×)n",
  "Celsius to Fahrenheit",
  "°Fahrenheit °Celsius f2c() ftoc() converting change changing"
],[  "(2×π)⊸×n",
  "Circumference of circle with radius n",
  "edge length"
],[  "(180÷π)⊸×n",
  "n Radians in Degrees",
  ""
],[  "(π÷180)⊸×n",
  "n Degrees in Radians",
  ""
],[  "(π×⋆⟜2)n",
  "Area of circle with radius n",
  "length"
],[  "' '⊸≠⊸/d1",
  "Remove blanks in string",
  "deletespaces spaces drop without"
],[  "⊐⟜' '⊸↑d1",
  "First word in d1",
  "initial leading leftmost nonspace non-space 1st start beginning"
],[  "=⌜○↕´∘≢n2",
  "Identity matrix with shape of table n2",
  "diagonal table"
],[  "≠⌜○↕´∘≢n2",
  "Anti-diagonal matrix with shape of table n2",
  "nondiagonal table"
],[  "x⊑∘/∘¬∘∊y",
  "Position of first element in x not in y",
  "cell element 1st"
],[  "⊑∘⍋∘|⊸⊑n1",
  "Element with the smallest magnitude (first in case of ties)",
  "minimum absolute value closest nearest to 0 zero"
],[  "⊑∘⍒∘|⊸⊑n1",
  "Element with largest magnitude (first in case of ties)",
  "maximum absolute value biggest farthest furthest away from 0 zero"
],[  "=⌜˜⟜⍷∘⊐y",
  "Table of which unique matches each major cell of y",
  "nub distinctitems uniqueelemenets matrix items elements"
],[  "m(¯1+⊣√1+⊢)n",
  "Annual rate to modal rate",
  ""
],[  "i0(×⥊⊢↑1˙)j0",
  "Starting points for i0 fields of width j0",
  "segmented partitioned vector starts beginnings list"
],[  "m(⊣+a×-˜)n",
  "Select each element from m where a is 0 and from n where it's 1",
  "conditionalshing merge cells items indicate masking indicating"
],[  "(××⌊∘|)n",
  "Round towards zero",
  "0 truncate whole number integer int() trunc() chop clamp"
],[  "(1÷1+⋆∘-)n",
  "Logistic function, approaching 0 for small n and 1 for large n",
  "standard sigmoid curve limited exponential population growth"
],[  "m(⊣+-⊸|)n",
  "Residue after dividing n by m but replacing 0 with m",
  "modulo modulus divisionremainder 12hourclock divide"
],[  "(1⊸↓-¯1⊸↓)n",
  "Deltas: (n_1-n_0)(n_2-n_1)(n_3-n_2)…",
  "pairwisedifferences changes steps"
],[  "(1⊸↓÷¯1⊸↓)n",
  "Ratio of each number in a list to its predecessor: (n_1÷n_0)(n_2÷n_1)(n_3÷n_2)…",
  "pairwiseratios vector"
],[  "(2⊸⋆+¯1⊸⋆)j0",
  "Jacobsthal-Lucas number",
  "sequence Édouard Edouard Ernst j(n) A014551() A14551()"
],[  "m(≤⟜|×⊢)n",
  "Round to zero values of n within m of zero",
  "precision fuzz 0"
],[  "i0(×⟜≠⥊⊢)y1",
  "Duplicate list y1 i0 times",
  "copying extending recycling recycle list"
],[  "i0(⊢/˜0=|)j1",
  "Elements of j1 divisible by i0",
  "filter divisors cells items"
],[  "(+´÷1⌈≢)n1",
  "Average, returning 0 if empty",
  "arithmeticmean"
],[  "m1(+´|∘-)n1",
  "Manhattan distance between two points in n-space",
  "taxicab L1 L-1 L1-distance ℓ1 ℓ-1 ℓ₁ L¹ d()"
],[  "(¬∨´∘⥊)b",
  "Are none true?",
  "testif theredoesnotexist ∄"
],[  "(¬∧´∘⥊)b",
  "Not all true?",
  "notall somenot all?"
],[  "x F⎉(-⌊○=) y",
  "Apply F with leading axis agreement",
  "conformity conforming axes frames major minor cells"
],[  "x⊣⌾(b1⊸/)˜y",
  "Mask Operator: Merge x and y using b1 (1 for x's element, 0 for y1's element)",
  "faro weave dovetail zipper zipping merging interweave interweaving interleave interleaving shuffle shuffling meshing alternative choose indicate masking indicating elements items major cells bitmask bit-mask"
],[  "(100×⊢÷+˝)n",
  "Column-wise percentage per column",
  "≢ vertically columnwise"
],[  "(∾↑¨∘↓)y1",
  "All possible slices ordered by starting index",
  "sub-strings substrings sub-vectors sub-sequences subsequences segmented sub-lists partitioned sublists"
],[  "i0(∾˝/⟜≍)y",
  "Repeat y as a whole i0 times along the first axis",
  "duplicate copy"
],[  "x1(⥊∾⎉0‿1˜)y1",
  "Insert x1 after every element of y1",
  "merge cell item"
],[  "∾⟜(1¨∘⊏)y",
  "Append a row of 1s",
  "ones trues truths"
],[  "⌽⌾(0‿¯1⊸⊏)y",
  "Swap first and last major cells",
  "exchange swap head tail leading trailing elements items 1st start beginning ending"
],[  "(↕∘≠≡∧)y1",
  "Is y1 permutation?",
  "testif"
],[  "x(¬∘∊/⊣)y",
  "x without major cells that appear in y",
  "butnot except setdifference setsubtraction setminus ∖ removing remove delete drop"
],[  "(∊∘/1⊸+)n1",
  "Boolean gaps of lengths n1 after each one",
  "runs binary base-2 base2"
],[  "(¬∧´∘∊)y",
  "Are any two major cells of y identical to each other?",
  "testif anysame? anyequal? anyduplicates? anyidentical? anydups? items elements"
],[  "(∊∧∊⌾⌽)y",
  "Indicate which cells of y appear exactly once",
  "unique indication indicate items masking indicating"
],[  "(⍋≠⊸⋈¨)y1",
  "Ascending shortlex grade",
  "radix length-lexicographic lengthlexicographic military genealogical"
],[  "(↕∘≠≡⍋)n",
  "Is n non-decreasing?",
  "testif ascending? increasing? rising? up ordered? sorted?"
],[  "x⊏˜⟜(⍋⍋)y",
  "Reorder x to match the ordering of y",
  "meshing sorting reordering ordering"
],[  "(⍒≠⊸⋈¨)y1",
  "Descending shortlex grade",
  "radix length-lexicographic lengthlexicographic military genealogical ordering sorting"
],[  "(↕∘≠≡⍒)n",
  "Is n non-increasing?",
  "testif descending? falling? down ordered? decreasing? sorted?"
],[  "x(∊⍒⊸⊏⊣)y",
  "Move major cells of x that appear in y to the front",
  "promote cells items"
],[  "(»⊸<∨`)b",
  "Turn off all 1s after first 1 (indicate only the first 1)",
  "indicating flipping turning change changing inverting negating bitmask bit-mask zeros zeroes falses ones trues truths falsehoods 1st mask"
],[  "(»⊸≤∧`)b",
  "Turn on all 0s after first 0 (indicate all elements except the first 0)",
  "indicating flipping turning change changing inverting negating bitmask bit-mask zeros zeroes falsehoods 1st mask not"
],[  "b1(i0=+`)⊸/y1",
  "The i0'th sublist of y1 (sublists indicated by b1)",
  ""
],[  "(+˝∧`)⎉1 b",
  "Number of leading ones in each row of b",
  "ones trues truths start beginning"
],[  "k˙⌾(i‿j⊸⊑)y2",
  "Replace element i,j of matrix y2 with k",
  "modify change at index"
],[  "(↕¯1⊑≢)⊸∾y2",
  "Attach column numbers to a table",
  "headings table"
],[  "(⊑⊢⊐⌈´)n1",
  "Index of minimum value in n1 (linear time)",
  "lesser smaller smallest lowest least"
],[  "(⊑⊢⊐⌊´)n1",
  "Index of maximum value in n1 (linear time)",
  "greater larger bigger greatest biggest largest highest"
],[  "x(≠∘⊣>⊒)y",
  "Progressive member of (∊) without replacement",
  "isin membership containedin hascorresponding mathcingmemberof PDE remove"
],[  "m +˝∘×⎉1‿∞ n",
  "Matrix product of m and n (¯1↑m ↔ 1↑≢n)",
  "dotproduct multiplication multiply"
],[  "m -˝∘×⎉1‿∞ n",
  "Alternating matrix product of m and n (¯1↑m ↔ 1↑≢n)",
  ""
],[  "a2 ∨˝∘∧⎉1‿∞ b2",
  "Extend a transitive binary relation",
  "extension base-2 base2"
],[  "m2 ⌊˝∘+⎉1‿∞ n2",
  "Extend a distance table to next leg",
  "extension matrix"
],[  "i2 <¨⊸⊏⎉¯1‿∞ y",
  "Select: each row of i2 selects a cell from y",
  "rightshoeunderbar saneindexing ⊇ items elements index"
],[  "(4×π××˜)n",
  "Area of sphere with radius n",
  "length ball"
],[  "(1.8÷˜¯32⊸+)n",
  "Fahrenheit to Celsius",
  "°Fahrenheit °Celsius c2f() ctof() converting change changing"
],[  "x0(1↓·⥊∾˘)y2",
  "Table to list using x0 as delimiter",
  "vectorise vectorize serialise serialize list table"
],[  "x0(1↓·⥊≍˘)y1",
  "Insert x0 in between each pair of elements of list y1",
  "combine merge list string character joiner joining merging combining"
],[  "' '⊸≠⊸/¨d",
  "Remove blanks in each string",
  "deletespaces spaces drop without"
],[  "≍⟜('¯'¨)d1",
  "Underline a string",
  "underscore"
],[  "10⊸×⊸+˜´∘⌽d1",
  "Natural number from base-10 digits",
  "frombase10 base-10 dec() decimal Conversion converting change changing"
],[  "2⊸×⊸+˜´∘⌽d1",
  "Natural number from binary representation",
  "frombase2 base-2 binary Conversion converting change changing"
],[  "⌈´⊸=∘⊒⊸/y",
  "Modes: Most frequent major cells of data",
  "average items elements"
],[  "(⌊⊢+1≤2|⊢)n",
  "Round to nearest even number, ties towards ∞",
  "precision favoring whole number favoring"
],[  "i(⊣⋆˜1+÷˜)n",
  "Effective rate of interest with nominal rate n for i periods",
  ""
],[  "m(⊢+0⊸=×⊣)n",
  "Replace zeroes in n with corresponding elements of m",
  "substitute merge amend replace update 0s zeros cells items falses falsehoods"
],[  "i0-⊸↑⟜(⥊⟜1)j0",
  "Suffix List: length i0 with j0 ones on the right, the rest zeroes",
  "1s 0s zeros Is𝕩Js falses falsehoods trues truths"
],[  "m1(×÷+´∘×)n1",
  "Bayes' formula",
  "Bayesformula statistical statistics probability probabilities"
],[  "(√+´∘×˜)n1",
  "Length of vector n1",
  "absolute value magnitude distance from origin 0 zero"
],[  "(≠×+´⌾÷)n",
  "Harmonic mean",
  "average subcontrary H() HM() harmonicmean"
],[  "(⊢÷⌈˝∘|)n",
  "Normalize by infinity-norm (maximum absolute value)",
  "L∞-normalise L∞-normalize L∞-normalization L-∞"
],[  "(-´×⟜⌽˝)n2",
  "Determinant of two-row matrix",
  "det() 2-row 2row table"
],[  "x2⊣∾⊏⊸(⊢¨)y0",
  "Append unit to each column of table",
  "vertically ontop atop extend with over merge join concatenate columns table"
],[  "x0(⊣+↕∘¬˜)y0",
  "Consecutive values from x0 to y0 (both numbers, or both characters, with x0≤y0)",
  "inclusive range closed interval seq() sequence …"
],[  "(↕1++˜)⊸-j0",
  "Integers from -j0 to j0",
  "whole numbers natural symmetric negative positive"
],[  "(1↓↕∘≠⊸×)n1",
  "Derivative of polynomial with coefficients n1 in ascending order",
  "firstderivative derivate"
],[  "(↕∘≠⌽˘⊢)y2",
  "Skew y2 to turn diagonals into columns (with wrap-around)",
  "table"
],[  "+⌜˜∘(1+↕)j0",
  "Addition table for numbers up to j0",
  "additiontable cartesianaddition plustable matrix integers"
],[  "×⌜˜∘(1+↕)j0",
  "Multiplication table for numbers up to j0",
  "multiplicationtable cartesianproduct timestable matrix integers"
],[  "/○⥊⟜(↕≢)b2",
  "List of arcs from adjacency matrix b2",
  "connections table directed graph vector"
],[  "(1+´0=↕⊸|)j0",
  "Number of positive divisors of j0",
  "sigma_0(n) tau(n) sigma0 σ₀(n) d(n) ν(n) τ(n) oeisA000005 oeisA5"
],[  "(1=-⌜○↕´)j1",
  "Subdiagonal matrix of size j1",
  "sub-diagonal"
],[  "(¯1=-⌜○↕´)j1",
  "Superdiagonal matrix of size j1",
  "super-diagonal"
],[  "(↕∘≠∾˘⊢)y2",
  "Attach row numbers to a table",
  "labels table"
],[  "(↕∘≠↕¨<)y1",
  "All possible slices grouped in arrays by length",
  "sub-strings substrings sub-vectors sub-sequences subsequences segmented sub-lists partitioned sublists"
],[  "m1(⊢×¬∘∊˜)n",
  "Change elements of n that are found in m1 to zero",
  "arein membersof 0ing cells items"
],[  "x1(∧´∊˜∾∊)y1",
  "Are x1 and y1 equivalent as sets?",
  "equivalence"
],[  "(⌊1+10⋆⁼1⌈|)j",
  "Number of (base-10) digits of each integer in j",
  "positions width representation"
],[  "⊏⟜(/⁼)∘⊐y",
  "Indicate number of cells matching each cell of y",
  "count duplicate repetitions appearances"
],[  "x(⊏˜⍋⊸⊏⊢)j1",
  "Sort indices j1 according to data x",
  "permute"
],[  "i0(⊏⎉1⍋⊸⊏⊢)y",
  "Sort y ascending according to column i0",
  "sort() major cells elements items of array up increasing sorting reordering ordering bycolumn specific"
],[  "x(⍋∘∊˜⊏⊢)y",
  "Move cells x to end of y",
  "major cells elements trailing ending"
],[  "x1(∊˜⍋⊸⊏⊢)y1",
  "Move elements x1 to end of y1",
  "major cells elements trailing ending"
],[  "i1(⌽∘⍒/)⊸⊏y",
  "Reverse (⌽) sublists of y having lengths i1",
  ""
],[  "i0(⊏⎉1⍒⊸⊏⊢)y",
  "Sort y descending according to column i0",
  "sort() major cells elements items of array down decreasing sorting reordering ordering bycolumn specific"
],[  "(+´∧`∘⌽)b1",
  "Count of trailing ones",
  "0s zeroes falses at end"
],[  "x(+´∧`∘=)y",
  "Count number of leading elements that are equal",
  "matching onleft cells items start beginning"
],[  "x(+´∧`∘≠)y",
  "Count number of leading elements that are unequal",
  "different onleft cells items start beginning"
],[  "(∧˝⌈`⊸=)n",
  "Mask of which columns of n are in ascending order?",
  "testif vertical raising? sorted? growing?"
],[  "(∧˝⌊`⊸=)n",
  "Mask of which columns of n are in descending order?",
  "testif vertical falling? sorted? shrinking?"
],[  "(+`+`∘↕)j0",
  "First j0 figurate numbers",
  "1st"
],[  "m2(0‿1‿0‿1⍉+⌜)n2",
  "Sum of common parts of matrices (matrix sum)",
  "tables"
],[  "x F⌾(<˘ax⍉⁼⊢) y",
  "Run F on each list along axis ax of y",
  "onaxis apply dimensions"
],[  "i(⊑⊣+1⊐˜↓)b",
  "Index of first one after index i0 in b1",
  "1st"
],[  "(1+⊒+⊒⌾⌽)y",
  "Indicate number of cells matching each cell of y",
  "count duplicate repetitions appearances"
],[  "(1+⊒+⊒⌾⌽)y",
  "Count of total (not previous) occurrences of each cell of y",
  "tally selfcount items elements"
],[  "x1(+´¨⊐⊸⊔)n1",
  "Sum n1 by buckets x1 (≢n1 ↔ ≢x1)",
  "groups classify bins"
],[  "(π×4÷3÷⋆⟜3)n",
  "Volume of sphere with radius n",
  "length ball"
],[  "(∧˝' '⊸=)d",
  "Mask for blank columns",
  "spaces empty filter indicate masking indicating blanks bitmask bit-mask"
],[  "i0(×⥊1↑˜-∘⊢)j0",
  "Ending points for i0 fields of width j0",
  "vector list trailing segments partitions"
],[  "m(××⌊∘|)∘÷n",
  "Truncated division",
  "integer intdiv() % // divmod() T-division"
],[  "(3÷˜2⊸⋆-¯1⊸⋆)j0",
  "Jacobsthal number",
  "sequence Ernst j(n) A001045() A1045()"
],[  "m(⊢×⊸×+⟜|)n",
  "Increasing absolute value of n by m without change of sign",
  "adjust decrease magnitude preserve signum direction remove changing converting conversion"
],[  "i0(×⊸×⟜≠↑↓)b1",
  "Shift b1 forward or backward i0 positions",
  "leftshift rightshift bits bytes"
],[  "m(∧⟜¬∨¬⊸∧)n",
  "Probabilistic XOR",
  "fuzzy probability chance exclusivedisjunction eor exor ⊕ ⊻ ⇎ Jpq"
],[  "(1»≢˘⟜«)⊸/y",
  "Remove consecutive duplicate major cells",
  "list"
],[  "(1»≢˘⟜«)⊸/y",
  "Remove duplicate cells from ordered array y",
  "table"
],[  "(⌈´-⌊´)∘⥊n",
  "Statistical range, or difference between largest and smallest element, of n",
  "span minmaxmin extremes of"
],[  "m1+´⌾(×˜)∘-n1",
  "Euclidean distance between two points in n-space",
  "L2-distance L-2 ℓ2 ℓ-2 ℓ₂ L² Pythagorean d()"
],[  "(÷1++⌜˜∘↕)j0",
  "Hilbert matrix of order j0",
  "table sorting reordering ordering"
],[  "↕⊸(⊣/˜0=|)j0",
  "Proper divisors of j0",
  "factorisation factorization"
],[  "(¬2|↕∘≠)⊸/y",
  "Remove every second cell of y",
  "filter even odd parity"
],[  "(⊢>⌜⟜↕⌈´)i1",
  "Matrix with i⊑i1 leading ones on row i",
  "1st trues truths first table start beginning"
],[  "(⊢≤⌜⟜↕⌈´)i1",
  "Matrix with i⊑i1 leading zeroes on row i",
  "0s zeros falses falsehoods table start beginning"
],[  "(=⌜○↕´2⊸⥊)j1",
  "Diagonal matrix of size j1 (n or m,n)",
  "mono-diagonal banded"
],[  "i0(+˝˘∘↕÷⊣)n",
  "n-wise rolling average",
  "rollingmean windowedmean windowedaverage"
],[  "(∧´∘⥊∊⟜0‿1)y",
  "Is y an array of booleans?",
  "testif binary base-2 base2"
],[  "(↕∘≠≡⌽∘⍋)n",
  "Is n Strictly Decreasing?",
  "testif descending? falling? down ordered? sorted?"
],[  "(↕∘≠≡⌽∘⍒)n",
  "Is n Strictly Increasing?",
  "testif ascending? rising? up ordered? sorted?"
],[  "a1(⍋+`⊸+)⊸⊏y",
  "Rotate first major cells (1⌽) of sublists of y indicated by starting mask a1",
  "sub-vectors sub-lists sublists items elements 1st"
],[  "a1(⌽∘⍒+`)⊸⊏y",
  "Reverse (⌽) sublists of y indicated by starting mask a1",
  ""
],[  "(∨`∧∨`⌾⌽)b1",
  "Mask that selects values between first and last 1",
  "masking trim ones 1st bitmask bit-mask"
],[  "i0(|⟜↕⟜≠⊔⊢)y",
  "Distribute major cells of y into i0 groups round-robin",
  "unzip elements items deal"
],[  "∧´∘≤⟜(@+127)d",
  "Is string d ASCII-only?",
  "plain exclusively"
],[  "(≠(«-⊢)/)b1",
  "Changing starting indicators b1 of sublists to lengths",
  "partitions change converting conversion segments"
],[  "(≠(«-⊢)/)i1",
  "Segment lengths given the number of segments that start at each position",
  "chunk start leading converting change changing segments partitions"
],[  "i0/⟜(≍⎉(-m0))y",
  "Create a new axis of y before axis m0, and replicate to length i0",
  "copying repeating replicate replication add dimension increase incrementing rank by 1 one insertion inserting extending extension"
],[  "x2(¯1⊑≠)⊸(↑˘)y2",
  "Widen table y2 to be compatible with x2",
  "adjust width table"
],[  "(××¯0.5⌈∘+|)n",
  "Round to nearest integer, ties towards 0",
  "precision favoring integer round()"
],[  "(××0.5⌊∘+|)n",
  "Round to nearest integer, ties away from 0",
  "precision favoring integer round()"
],[  "(|¯11|·+´+`)j1",
  "ISBN check digit generator from ten first digits j1",
  "InternationalStandardBookNumber correct validate 1st"
],[  "x(i0⊑·/≡¨⟜<)y",
  "Position of the i0'th y in x",
  "nthindexin nthindexof nthposition"
],[  "(+˝˘' '⊸≠)d",
  "Word lengths of words in list d",
  "vector"
],[  "(∧˝⎉1' '⊸=)d",
  "Mask for blank rows",
  "spaces empty filter indicate masking indicating blanks bitmask bit-mask"
],[  "(⍋' '⊸=)⊸⊏d1",
  "Moving all blanks to end of text",
  "spaces trailing ending"
],[  "(∨`⎉1' '⊸≠)d",
  "Locate leading blanks",
  "spaces beginning mask indicate indications start bitmask bit-mask"
],[  "(ASSERTION FALURE!∧´∘⥊)b",
  "Signal an error if any condition is not met",
  "throw"
],[  "m(¬∧⟜¬∨¬⊸∧)n",
  "Probabilistic XNOR",
  "fuzzy probability chance materialbiconditional biimplication eqv nxor bothorneither exclusivenor materialequivalence ⇔ δ ẟ Kroneckerdelta iff logicalequivalence Epq doubleimplying"
],[  "x0(1⊸»⊸∨∘≠/⊢)y1",
  "Remove consecutive duplicate x0's from list y1",
  "list"
],[  "(2×1⊸⌽+´⊸×⊢)n1",
  "Surface area of box with side lengths n1",
  "block edge lengths"
],[  "i0(⊢∾-⟜≠/¯1⊸↑)y",
  "Extend y with last cell of y to length i0",
  "filling enlongating item element"
],[  "m1(+´⌈○≠↑¨⋈)n1",
  "Sum of polynomials with ascending coefficients",
  "additionof plus"
],[  "m1(-´⌈○≠↑¨⋈)n1",
  "Difference between polynomials with ascending coefficients",
  "subtractionof minus"
],[  "(≠˝0=400‿100‿4|⌜⊢)j",
  "Is year j a leap year?",
  "testif gregoriancalendar 29thfeb29 29february29th"
],[  "x(⌊⟜≠⊏∾⟜i∘⊢)y",
  "Select major cells at indices x from y, using cell i for indices beyond the end",
  "fallback indexing trailing ending"
],[  "(<⌜˜↕∘≠)⊸×m2",
  "Extract the upper triangular part of the matrix m2 without main diagonal",
  "make strict triangle northeast north east north-east"
],[  "(>⌜˜↕∘≠)⊸×m2",
  "Extract the lower triangular part of the matrix m2 without main diagonal",
  "make strict triangle southwest south west south-west"
],[  "(≤⌜˜↕∘≠)⊸×m2",
  "Extract the upper triangular part of the matrix m2 with main diagonal",
  "make triangle northeast north east north-east"
],[  "(≥⌜˜↕∘≠)⊸×m2",
  "Extract the lower triangular part of the matrix m2 with main diagonal",
  "make triangle southwest south west south-west"
],[  "(<⌜˜↕∘≠)⊸≡b2",
  "Is b2 a full upper triangular matrix without diagonal?",
  "testif triangle NE northeast north-east table triangular? remove strict"
],[  "(>⌜˜↕∘≠)⊸≡b2",
  "Is b2 a full lower triangular matrix without diagonal?",
  "testif triangle SW southwest south-west table triangular? remove strict"
],[  "(≤⌜˜↕∘≠)⊸≡b2",
  "Is b2 a full upper triangular matrix with diagonal?",
  "testif triangle NE northeast north-east table triangular?"
],[  "(≥⌜˜↕∘≠)⊸≡b2",
  "Is b2 a full lower triangular matrix with diagonal?",
  "testif triangle SW southwest south-west table triangular?"
],[  "i0(×´1+-⊸↑⟜↕)j0",
  "Number of ordered selections (permutations) of i0 items from j0 choices",
  "combinatorics permutations"
],[  "x(≠∘⊣-1+⌽⊸⊐)y",
  "Last indices in x of major cells y (¯1 if not found)",
  "indexin indexof finding locating locate positionof items elements location"
],[  "(≠⊸⋈¨⊸⍋⊸⊏)y1",
  "Ascending shortlex sort",
  "radix length-lexicographic lengthlexicographic military genealogical sorting ordering bylength"
],[  "(≠⊸⋈¨⊸⍒⊸⊏)y1",
  "Descending shortlex sort",
  "radix length-lexicographic lengthlexicographic military genealogical sorting ordering bylength"
],[  "x(+´∧`∘⌽∘=)y",
  "Count number of trailing elements that are equal",
  "matching onright cells items ending"
],[  "x(+´∧`∘⌽∘≠)y",
  "Count number of trailing elements that are unequal",
  "different onright cells items ending"
],[  "(∧`∨`⊸=)⊸∧b",
  "Indicate first group of ones (in each column) only",
  "sequence run trues truths 1st"
],[  "(∧⊑˜2⌊∘÷˜≠)n1",
  "Median of non-empty n1, taking larger value for even lengths",
  "average"
],[  "(100×÷⟜(+˝)˘)n",
  "Row-wise percentage per row",
  "≢ horizontally rowwise"
],[  "(⥊(↕2˘)/¨<)y",
  "Power set: a list of all subsets of the cells of y",
  "powerset power-set all combinations choices at most one"
],[  "(⌈´(⊢⌈+)`)n1",
  "Largest sum of any contiguous non-empty sublist",
  "maximum subarray sublist sub-array sub-list sub-vector biggest highest kadane's kadanes algorithm"
],[  "(0⌈´0(0⌈+)`⊢)n1",
  "Largest sum of any contiguous sublist",
  "maximum subarray sublist sub-array sub-list sub-vector biggest highest kadane's kadanes algorithm"
],[  "i0((+˝÷≠)⍉⁼)n",
  "Average (mean value) of elements of n along axis i0",
  "arithmeticmean() AM() avg() axis dimension cells items"
],[  "c1(⊣∾(@+10)∾⊢)d1",
  "Join lines with line feed (LF)",
  "combine glue 0x0A U+0A U+000A"
],[  "{⍋⍒2|↕≠𝕩}⊸⊏y",
  "Perfect Ripple Shuffle",
  "faro weave dovetail zipper zipping merge merging interweave interweaving interleave interleaving shuffling meshing grade carddeck diversions riffleshuffle"
],[  "(1≥·|-⌜○↕´)j1",
  "Tridiagonal matrix of size j1",
  "tri-diagonal banded"
],[  "(2≥·|-⌜○↕´)j1",
  "Pentadiagonal matrix of size j1",
  "penta-diagonal banded"
],[  "i(⊏⎉∞‿1⍋⊸⊏⊢)y2",
  "Sort rows of table y2 according to column(s) i",
  "sort() sortby() table sorting reordering ordering specific columns"
],[  "i1(∾·F´¨+`⊸⊔)y",
  "Segmented reduction",
  "partionedreduction sub-vectors partitioned sub-lists subvectors sublists"
],[  "a1(∾·F`¨+`⊸⊔)y",
  "Segmented scan: like F` but starting over whenever indicated by a1",
  "cumulativereduce rowwise sub-vectors sub-lists partitioned subvectors sublists row-wise horizontally"
],[  "(∨`' '⊸≠)⊸/d1",
  "Remove leading blanks",
  "delete spaces beginning start drop without"
],[  "(∨`'0'⊸≠)⊸/d1",
  "Remove leading zero characters",
  "zeros 0s trim left falses falsehoods start beginning"
],[  "(¯1⊑/)⎉1∘≠⟜' 'd",
  "Indices of last non-blanks in rows",
  "nonblanks nonspaces characters text row-wise rowwise horizontally"
],[  "(×´⊢÷+´-2×⊢)n1",
  "Aspect ratio of a triangle given its side lengths",
  "AR()"
],[  "m1(+˝∘×÷+´∘⊣)n2",
  "Weighted average of each column of n2 with row weights m1",
  ""
],[  "↕⊸(+´⊣/˜0=|)j0",
  "Aliquot sum (sum of proper divisors)",
  "s(n) divisorsum"
],[  "x(∧`∘∊˜¬⊸/⊢)y",
  "Remove cells that appear in x from beginning of y",
  "trim leading left cells items list start"
],[  "(+⌜´↕¨∘≢)⊸⊔y2",
  "Anti-diagonals of a table, as a list of lists",
  "table SW-NE extract collect select"
],[  "a1(⊢-˜+`×¬)⊸⊔y",
  "Split y at 1s in a1, not including cells of y at those locations",
  "cut separate chop divide chunk dividing strings lists segments partitions"
],[  "(+´⌾(×˜)÷≠)n1",
  "Quadratic mean",
  "Root square rms()"
],[  "(+´÷≠)⌾(√⟜m0)n",
  "Generalised mean",
  "x-mean xmean generalized power Hölder holder cubic"
],[  "x((¬∊∾∊˜)/∾)y",
  "Symmetric set difference: cells that appear in exactly one argument",
  "⊖"
],[  "(+˝÷≠)⌾(⋆⁼)n",
  "Geometric mean, using logarithm",
  "average GM() G() geometricmean"
],[  "m1 1⊸⌽⊸×{1⌽𝔽˜-𝔽} n1",
  "Cross product of 3-dimensional vectors m1 and n1",
  "crossproduct exterior product multiplication multiply"
],[  "(××·⌊|+1>2||)n",
  "Round to nearest odd number, ties away from 0",
  "precision favoring"
],[  "(××·⌊|+1≤2||)n",
  "Round to nearest even number, ties away from 0",
  "precision favoring"
],[  "(××¯1+2×·⌈2÷˜|)n",
  "Round to nearest odd number, ties towards 0",
  "precision favoring"
],[  "(⌊⊢+2÷˜0.5≠2|⊢)n",
  "Round to nearest integer, ties to even",
  "precision whole number favoring"
],[  "i0(⊣√·+´⋆˜⟜|)n",
  "i0-norm",
  "Lp-normal L-p ℓp ℓ-p"
],[  "(⊢↑˝·≍⟜¬2+≢)y",
  "Pad y with a layer of fill elements on all sides",
  "expand enlarge outer outside around edges boundary border surround frame"
],[  "m((π÷3)××˜⊸×)n",
  "Volume of cone with height m and radius n",
  "lengths"
],[  "(»⊸∨' '⊸≠)⊸/d1",
  "Remove leading and duplicate blanks",
  "delete trim without consecutive extraneous normalise normalize spaces multiple drop start beginning"
],[  "(∨⟜«' '⊸≠)⊸/d1",
  "Remove trailing and duplicate blanks",
  "delete trim without consecutive extraneous normalise normalize spaces multiple drop start ending"
],[  "(∨˝˘' '⊸≠)⊸/d2",
  "Remove blank rows",
  "all-space allspace empty remove delete drop space without"
],[  "-⟜(32×1=a{⊸⍋)d",
  "Uppercase ASCII text",
  "casemap lettercase toupper upper-case conversion converting change changing"
],[  "+⟜(32×1=A[⊸⍋)d",
  "Lowercase ASCII text",
  "casemap lettercase tolower lower-case conversion converting change changing"
],[  "(≠`⊸∨'''⊸=)d1",
  "Locations of texts between and including quotes",
  "strings"
],[  "(≠`⊸>'''⊸=)d1",
  "Locations of texts between and excluding quotes",
  "strings"
],[  "(∧`·∧˝' '⊸=)d2",
  "Locate leading blank columns",
  "spaces beginning masking indicate indications allspace all-space start blanks"
],[  "i1(⊢↑˜⊣⌊≠⊸↑⟜≢)y",
  "Take up to i1 positions from axes of y",
  "limit major cells items"
],[  "m1(+˝∘×⎉1÷+´∘⊣)n2",
  "Weighted average of rows of n2 with column weights m1",
  ""
],[  "x≤○≠◶0‿(⊣≡≠⊸↑)y",
  "Is x a prefix of y?",
  "prefixof startswith"
],[  "↕⊸(⊢+´⊣/˜0=|)j0",
  "Sum of positive divisors of j0",
  "sigma σ(n)"
],[  "x(⊢/˜⊏∘⥊˘⊸∊˜)y2",
  "Rows of non-empty table y starting with an element in x",
  "cell item table"
],[  "i1(↕∘≠⊸∊˜¬⊸/⊢)y",
  "Remove major cells at indices i1 from y",
  "elements items without positions"
],[  "i1/⊸(⊏˜⍋⊸⊏⊢)⟜⍋y",
  "Grade up (⍋) for sorting subarrays of y having lengths i1 (≠y ↔ +´i1)",
  "sub-arrays sub-vectors subvectors substrings sub-strings"
],[  "i1/⊸(⊏˜⍋⊸⊏⊢)⟜⍒y",
  "Grade down (⍒) for sorting subarrays of y having lengths i1 (≠y ↔ +´i1)",
  "sub-arrays sub-vectors subvectors substrings sub-strings"
],[  "(1+↕)⊸(⊣/˜0=|)j0",
  "All divisors of j0",
  "factorisation factorization"
],[  "i0(⊢/˜0=|⟜(↕≠))y",
  "Keep every i0'th major cell of y",
  "nth element item"
],[  "i0(⊢/˜0≠|⟜(↕≠))y",
  "Remove every i0'th cell of y",
  "filter item element"
],[  "(⊢>⌜⟜(⌽↕)⌈´)i1",
  "Matrix with i⊑i1 trailing ones on row i",
  "1st trues truths first table ending"
],[  "(⊢≤⌜⟜(⌽↕)⌈´)i1",
  "Matrix with i⊑i1 trailing zeroes on row i",
  "1s 0s zeros ones falses falsehoods trues truths table ending"
],[  "x(∾○(↕≠)⍋⊸⊏∾)y",
  "Merge x and y alternately",
  "faro weave dovetail zipper zipping merging interweave interweaving interleave interleaving shuffle shuffling meshing"
],[  "i0(⊢/˜(⍋⍋)⊸∊˜)y",
  "The i0 smallest cells of y in order of occurrence",
  "least items elements"
],[  "i0(⊢/˜(⍋⍒)⊸∊˜)y",
  "The i0 largest cells of y in order of occurrence",
  "biggest greatestif items elements"
],[  "(∨≠¨⊸(≍˘)∘⊔)y",
  "Sorted frequency table",
  "matrix"
],[  "=⊸{<⎉𝕨⍉⍟𝕨>𝕩}y",
  "Invert array of same-rank arrays, exchanging inner with outer axes",
  "transpose transposing cell element zip() remixing zipping merging interweave interweaving interleave interleaving shuffle shuffling meshing flip"
],[  "(××2×·⌈2÷˜1-˜|)n",
  "Round to nearest even number, ties towards 0",
  "precision favoring"
],[  "(+˝|∘-)⎉1⎉1‿∞˜n2",
  "Manhattan distance table for points in n-space (one point per row)",
  "taxicab L1 L-1 L1-distance ℓ1 ℓ-1 ℓ₁ L¹ d() matrix"
],[  "(28+·≠´0=400‿100‿4|⌜⊢)j",
  "Number of days in February of year j (YYYY)",
  "gregoriancalendar feb29 29february29th feb28 28february28th length"
],[  "(1⊸»⊸∨' '⊸≠)⊸/d1",
  "Remove duplicate blanks, turning each sequence of blanks into a single blank",
  "delete trim reformat extraneous spaces multiple remove drop without"
],[  "⊏⟜(∾0A+⟜↕¨10‿26)j",
  "Translate digits to characters (bases 2 through 36)",
  "base-2 base2 binary Boolean base16 base-16 hexadecimal base36 base-36 letters 0123456789abcdef converting change changing"
],[  "(∾0A+⟜↕¨10‿26)⊸⊐d",
  "Translate characters to digits (bases 2 through 36)",
  "base-2 base2 binary Boolean base16 base-16 hexadecimal base36 base-36 letters 0123456789abcdef converting change changing"
],[  "(∨`⌾⌽' '⊸≠)⊸/d1",
  "Remove trailing blanks",
  "delete spaces drop ending without"
],[  "(÷⟜⊑·⌽·+`0∾↕)j0",
  "Outstanding balances on rule of 78s",
  "sum-of-the-digits method"
],[  "0.01⊸(⊣×·⌊0.5+÷˜)n",
  "Round to nearest hundredth, ties towards ∞",
  "precision favoring whole number favoring"
],[  "0.05⊸(⊣×·⌊0.5+÷˜)n",
  "Round currency to nearest five hundredths",
  "cents nickels ¢5¢"
],[  "(∧`·∧˝˘' '⊸=)d2",
  "Locate leading blank rows",
  "spaces beginning masking indicate indications allspace all-space lines start blanks"
],[  "(∧´∘∊≠|↕∘≠⊸+)j1",
  "Valid siteswap pattern for juggling?",
  "testif beat"
],[  "x(∧`⌾⌽∘∊˜¬⊸/⊢)y",
  "Remove cells that appear in x from end of y",
  "trim trailing right cells items list ending"
],[  "a1+`⊸(⊏˜⍋⊸⊏⊢)⟜⍋y",
  "Grade up (⍋) for sorting subarrays of y indicated by a1",
  "sub-arrays sub-vectors subvectors substrings sub-strings"
],[  "a1+`⊸(⊏˜⍋⊸⊏⊢)⟜⍒y",
  "Grade down (⍒) for sorting subarrays of y indicated by a1",
  "sub-arrays sub-vectors subvectors substrings sub-strings"
],[  "i0((⊢+|⟜-)⟜≠↑⊢)y",
  "Increase the leading dimension of y to multiple of i0",
  "1st axis divisibleby pad extend first start beginning"
],[  "i1((⊢+|⟜-)⟜≢↑⊢)y",
  "Increase the dimensions of y to multiples of i1",
  "allaxes divisibleby pad extend axes"
],[  "(∨⌜´(⌽⊸∨↑⟜1)¨)j1",
  "Array of shape j1 with ones along faces and zeros inside",
  "all-around along outline frame table 1s zeroes 0s zeros in middle"
],[  "(+´(⌈´≠¨)↑¨⊢)y1",
  "Sum of list of polynomials with ascending coefficient order",
  "sumof"
],[  "m0(⋆⟜(↕≠)+´∘×⊢)n1",
  "Value of polynomial with ascending coefficients n1 at point m0",
  ""
],[  "i0(⌊∘÷˜⟜(↕≠)⊔⊢)y",
  "Split y into groups of length i0, plus a shorter one at the end if needed",
  "chunk divide dividing cut partition distribute greedy"
],[  "a1(1(∾/∾˜)(≥/⊣))b1",
  "All elements true (∧´) for each sublist of b1 indicated by starting mask a1",
  "sub-vector major cells items ∧/¨a1⊂[1]b1"
],[  "i0 10⊸⋆⊸(⊣÷˜0.5⌊∘+×) n",
  "Round n to i0 decimal places",
  "precision banking banker's bank's (⍎⍕)"
],[  "i0(⊢÷⊣√·+´⋆˜⟜|)n",
  "Normalisation by i0-norm",
  "Lp-normalise Lp-normalize Lp-normalization L-p ℓp ℓ-p"
],[  "(√·×´0⊸∾-+´÷2˙)n",
  "Area of triangle with side lengths n",
  "Heron's formula herons"
],[  "a1(1⌈·⌈`↕∘≠⊸×)⊸⊏y",
  "Copy each cell of y until before next 1 in a1",
  "item element"
],[  "(<·⌈´≢¨)⊸(↑¨)y1",
  "Pad elements of list of equal-rank arrays y1 to equal shape",
  "list cells items"
],[  "(2=·+´0=(1+↕)⊸|)n0",
  "Is n0 a prime?",
  "testif isprime primality"
],[  "(0=(1+·↕⌈´)|⌜⊢)j1",
  "Divisibility table",
  "divides divisor matrix"
],[  "(∨˝' '⊸≠)⊸(/⎉1)d2",
  "Remove blank columns",
  "all-space allspace empty remove delete drop space without"
],[  "(>⌈´↑¨⥊¨⟜'⎕')j",
  "Bar chart",
  "curve graph plotting"
],[  "(⍋·+˝˘' '⊸≠)⊸⊏d2",
  "Sort words in list d2 according to word length",
  "vector"
],[  "((¬/in˙)∾correct˙)b0",
  "Conditional in text",
  "message true false Boolean binary base-2 base2 converting change changing"
],[  "(⍉↕∘≠+˝∘×=⌜⟜1‿¯1)j2",
  "Change connection matrix j2 (¯1 to 1) to a node matrix",
  "graph connectivity table change converting conversion"
],[  "m1(+´¨+⌜○↕○≠⊔×⌜)n1",
  "Product of polynomials (ascending or descending order)",
  "multiplicationof multiply times coefficients"
],[  "m1((√+´∘×˜)÷⟜2⊸∾)n0",
  "Length of edges of rectangular pyramid with base dimensions m1 and height n0",
  "lengths sides"
],[  "i0(-÷○(×´)1⊸+)⟜↕˜j0",
  "Number of unordered selections (combinations) of i0 items from j0 choices",
  "exclamation bang shriek binomial combinatorics countcombinations choose unordered selecting picking outof nCk C(n,k)"
],[  "i(⊢/˜¬∘∊˜⟜(↕≠))y",
  "Remove major cells with indices i from y",
  "without remove indices delete drop"
],[  "x0((∨`∧∨⟜«)∘≠/⊢)y1",
  "Remove leading, trailing and duplicate x0's",
  "trim left right spaces multiple consecutive blanks start beginning ending"
],[  "i0(⌊∘×⟜(↕⊸÷≠)⊔⊢)y",
  "Distribute major cells of y into i0 slices as evenly as possible",
  "unzip elements items deal"
],[  "a1(¬1(∾/∾˜)(∨/⊣))b1",
  "Any element true (∨´) for each sublist of b1 indicated by starting mask a1",
  "sub-vector cell item ∨/¨a1⊂[1]b1"
],[  "(<⥊¨·⊣⌜˜`⌾⌽↕¨)j1",
  "Index arrays along each dimension for shape j1",
  "separated indices positions locations elements odometer meshgrid ndgrid"
],[  "(≠(«-⊢)·/1»≠⟜«)y1",
  "Lengths of sublists of y1 having equal elements",
  "runs changes identical consistent cells items"
],[  "x0(⊣-(××·↕1+|)∘-)y0",
  "Consecutive values from x0 to y0 (both numbers, or both characters)",
  "inclusive range closed interval seq() sequence … any either direction unordered"
],[  "(-˜˝·(⍋⍋)⌾⥊≍˜)y1",
  "Count of total (not previous) occurrences of each element of y1",
  "tally selfcount items elements"
],[  "(10⊸×⊸+˜´∘⌽-⟜'0')d1",
  "Parse natural number from string",
  "decimal Conversion converting cast integer parseint atoi"
],[  "('F'-·×⊸+60‿70‿80‿90⊸⍋)j",
  "Students grades given score",
  ""
],[  "(⊣+=×'-'⊸-)⟜' 'y",
  "Replace all blanks with dashes",
  "spaces substitute format"
],[  "¬∘∊⟜.,:;?!⊸/d1",
  "Remove punctuation",
  "delete symbols drop without"
],[  "i0↕⊸(+´⊣/˜0=|)∘⊢⍟⊣j0",
  "i0'th number in the Aliquot sequence for j0",
  ""
],[  "(+´↕⊸(⊣/˜0=|))⊸=j0",
  "Is j0 a perfect number?",
  "testif perfect?"
],[  "(+´↕⊸(⊣/˜0=|))⊸<j0",
  "Is j0 a deficient number?",
  "testif deficient?"
],[  "(+´↕⊸(⊣/˜0=|))⊸>j0",
  "Is j0 an abundant number?",
  "testif abundant?"
],[  "m1(-⟜»≠⟜«⊸/⟜(+`))n1",
  "Sum elements of n1 marked by successive identicals in m1",
  "partitioned segmented major cells items"
],[  "x0((⊢-˜+`×¬)∘=⊔⊢)y1",
  "Split y1 at occurrences of separators x0, removing the separators",
  "cut separate chop divide chunk dividing partitions strings lists segments delimiters spaces words"
],[  "i0(+´÷≠){𝔽-⟜𝔽⊸⋆˜}n1",
  "i0'th moment of n1",
  ""
],[  "(√+´∘×˜∘-)⎉1⎉1‿∞˜n2",
  "Euclidean distance table for points in n-space (one point per row)",
  "L2-distance L-2 ℓ2 ℓ-2 ℓ₂ L² Cartesian metric Pythagorean d() matrix"
],[  "a1(¬-˜⊢×·+`»⊸>)⊸⊔y",
  "Cut y at 0s in a1, giving a slice for each group of 1s",
  "split separate chop divide chunk dividing partitions"
],[  "(>·»⊸+⍟(↕≠)1∾⥊⟜0)j0",
  "Binomial coefficients until j0",
  "pascal'striangle numberofcombinations pascalstriangle"
],[  "(1∾·÷˜○(×`)⟜⌽1+↕)j0",
  "Coefficients of the binomial",
  ""
],[  "(¯1⋆·+´·∨´¨⊢<≠↑↑)j1",
  "Sign of permutation",
  "even odd permutationsymbol antisymmetricsymbol anti-symmetricsymbol alternatingsymbol levi-civita symbol LC"
],[  "∊⟜(∾0aA+⟜↕¨10‿26‿26)⊸/d1",
  "Remove non-alphanumeric ASCII characters",
  "punctuation"
],[  "(∧´∘⥊0⊸≠≤<⌜˜∘↕∘≠)b2",
  "Is b2 an upper triangular matrix without diagonal?",
  "testif triangle NE northeast north-east table triangular? remove strict"
],[  "(∧´∘⥊0⊸≠≤>⌜˜∘↕∘≠)b2",
  "Is b2 a lower triangular matrix without diagonal?",
  "testif triangle SW southwest south-west table triangular? remove strict"
],[  "(∧´∘⥊0⊸≠≤≤⌜˜∘↕∘≠)b2",
  "Is b2 an upper triangular matrix with diagonal?",
  "testif triangle NE northeast north-east table triangular?"
],[  "(∧´∘⥊0⊸≠≤≥⌜˜∘↕∘≠)b2",
  "Is b2 a lower triangular matrix with diagonal?",
  "testif triangle SW southwest south-west table triangular?"
],[  "(¬∘∊⟜(⥊×⌜˜)⊸/2↓↕)j0",
  "Primes less than j0",
  "primesuntil numbers"
],[  "x(≠∘⊣(+⟜1|--1˙)⌽⊸⊐)y",
  "Last indices in x of major cells y",
  "indexin indexof find locate positionof locating items elements location"
],[  "i1(-⟜»⊏⟜(0∾⊢)○(+`))n",
  "Sums (+´) of sublists of n with lengths given by i1",
  "segmented partitioned sub-vectors"
],[  "m(×⊸⊢×⊣×·⌈¯0.5+|∘÷˜)n",
  "Round n to nearest multiple of m, ties towards 0",
  "precision favoring"
],[  "m(×⊸⊢×⊣×·⌊0.5+|∘÷˜)n",
  "Round n to nearest multiple of m, ties away from 0",
  "precision favoring"
],[  "((∨`∧∨⟜«)' '⊸≠)⊸/d1",
  "Remove leading, trailing and duplicate blanks",
  "delete trim reformat extraneous normalise normalize spaces multiple drop start beginning ending without"
],[  "(+`∘-⟜»˝()=⌜⊢)d1",
  "Depth of parentheses",
  "bracket brace nesting level parenthesis parens"
],[  "''⊸(⊣∾⊣∾˜⊢/˜1+=)d1",
  "Turn string d1 into string literal source code",
  "serialise ⍎⁼ inverse⍎ escape"
],[  "'0'⊸(⊢-∧`∘=×-⟜' ')d",
  "Replace leading zeros with blanks",
  "spaces nulls zeroes nils naughts noughts 0s falses falsehoods start beginning"
],[  "(-˜˝˘∘‿2⥊0⊸(/∾≠∾˜))b1",
  "Lengths of groups of ones in b1",
  "runs 1s trues truths"
],[  "(-˜`˘∘‿2⥊0⊸(/∾≠∾˜))b1",
  "Start and length of groups of 1s in b1",
  "runs sequences blocks trues truths 1st ones"
],[  "(+´÷≠){𝔽⌾(×˜)-⟜𝔽}n1",
  "Theoretical standard deviation",
  "stddev σ sigma SD"
],[  "i0(1={𝕨(|𝕊⍟(>⟜0)⊣)𝕩})j0",
  "Are i0 and j0 co-prime?",
  "coprime? relatively mutually testif"
],[  "(1+·+´↕⊸(⊣/˜0=|))⊸=j0",
  "Is j0 an almost perfect number?",
  "testif almostperfect? almost-perfect?"
],[  "(¯1+·+´↕⊸(⊣/˜0=|))⊸=j0",
  "Is j0 a quasiperfect number? (none are known)",
  "testif quasiperfect? quasi-perfect?"
],[  "((∨`∧∨`⌾⌽)' '⊸≠)⊸/d1",
  "Removing leading and trailing blanks",
  "trim left right spaces start beginning ending"
],[  "≍⟜(' '(⊣+≠×'¯'-⊣)⊢)d1",
  "Underline non-blanks in a string",
  "wordunderlinewords wordunderscorewords"
],[  "((+´÷≠)∧⊏˜2⌊∘÷˜¯1‿0+≠)n1",
  "Median of non-empty n1, averaging two values for even lengths",
  "average"
],[  "(+´¨(+⌜´↕∘≠¨)⊔×⌜´)y1",
  "Product of list of polynomials (ascending or descending order)",
  "multiplicationof multiply times coefficients"
],[  "a1(∧∨∨{»⊸<⌾(𝕨⊸/)𝕩}⊢)b1",
  "Indicate first one in each sublist of b1 indicated by starting mask a1",
  "sub-vector 1st"
],[  "a1(≠`∨{»⊸≠⌾(𝕨⊸/)𝕩}⊢)b1",
  "State of switch given b1 on and a1 off spikes (initially off)",
  "signal on/off"
],[  "a1(≠`∨{»⊸≠⌾(𝕨⊸/)𝕩}⊢)b1",
  "Not leading zeroes (∨`) in each sublist of b1 indicated by starting mask a1",
  "zeros 0s falses falsehoods start beginning"
],[  "(-·+´2(⋆⁼×⊢)/⁼∘⊐÷≠)y",
  "Shannon entropy of array 𝕩",
  "informationtheory text message string"
],[  "( ⎕⊏˜·>⌜⟜(↕⌈´)/⁼)j1",
  "Histogram (distribution barchart, down the page)",
  ""
],[  "a1(⊢∧∧(⊢∊/)(+`»⊸<)∘⊢)b1",
  "Groups of ones in b1 pointed to by at least one 1 in a1",
  "runs sequences 1s indicated trues truths"
],[  "(⋈÷{𝕨(|𝕊⍟(>⟜0)⊣)𝕩})⟜1 n0",
  "Convert fraction to (numerator,denominator)",
  "rationalnumber simplefraction commonfraction vulgarfraction Conversion converting change changing"
],[  "x0((¬-˜⊢×·+`»⊸>)∘≠⊔⊢)y1",
  "Cut y1 at occurrences of x0, removing separators and empty segments",
  "split separate chop divide chunk dividing partitions strings lists segments delimiters spaces words"
],[  "a1(≤∧≥{¬»⊸<⌾(𝕨⊸/)¬𝕩}⊢)b",
  "Not first zero in each sublist of b indicated by starting mask a1",
  "segmented partitioned 1st"
],[  "((√+´÷≠-1˙)·×˜⊢-+´÷≠)n1",
  "Sample standard deviation",
  "stddev σ sigma SD empirical"
],[  "(=⌜˜∘(↕≠)≡+˝∘×⎉1‿∞⟜⍉)n2",
  "Is square matrix n2 orthogonal?",
  "testif Orthogonal?"
],[  "c1((⊢-˜¬×·+`»⊸<)∘∊˜⊔⊢)d1",
  "Split list d1 at any sequence of characters in c1",
  "cut chop divide linebreak newline carriagereturn crnl crlf linefeed vec2vtv separate chunk list dividing segments partitions"
],[  "(⊏∘⊑˘·(⌈´⊸=≠¨)⊸/⊐⊸⊔)y",
  "Modes: Most frequent major cells of data",
  "average items elements"
],[  "-⟜(64×'^'⊸=»⊸∧1=@`⊸⍋)d1",
  "Evaluate control character sequences (like ^J)",
  "strings escapes characters charvector charvecs null bell backspace bs horizontaltab ht linefeed lf verticaltab vt formfeed ff carriagereturn cr crlf cr+lf ^M^J control-z sub eof endoffile end-of-file escape"
],[  "c1(¯1⊑0¨∘⊢{𝕩⌈⌈`𝕨+»𝕩}˝=⌜⟜⌽)d1",
  "Length of longest common substring",
  "fuzzy match lcs"
],[  "(+´(↕3)(×˝⌽˘){𝔽--⊸𝔽}⊢) n2",
  "Determinant of 3x3 matrix, or vector triple product of its rows or columns",
  "scalar box signed volume parallelepiped"
],[  "a1(⊢⊏˜(⊢⊏˜⊣/+`⊸(⍋⊏˜))⟜⍋)y",
  "Minima (⌊´) of elements of sublists of y indicated by a1",
  "segmented partitioned array minimums smallest least major cells items"
],[  "a1(⊢⊏˜(⊢⊏˜⊣/+`⊸(⍋⊏˜))⟜⍒)y",
  "Maxima (⌈´) of elements of sublists of y indicated by a1",
  "segmented partitioned array maximums greatestif largest biggest major cells items"
],[  "m(+´⋆⌜˜)⟜((1+↕)⊸(⊣/˜0=|))j0",
  "Sum of m'th powers of positive divisors of j0",
  "sigma_x sigma_2 sigma_3 sigma_4 sigmax sigma2 sigma3 sigma4 σₓ(n) σ₂(n) σ₃(n) σ₄(n)"
],[  "a1(≥{¬≠`1⊸»⊸≠⌾(𝕨⊸/)𝕨∧𝕩}⊢)b1",
  "Leading ones (∧`) in each sublist of b1 indicated by starting mask a1",
  "1s trues truths start beginning"
],[  "(16⊸×⊸+˜´∘⌽(∾0A+⟜↕¨10‿6)⊸⊐)d1",
  "Convert from hexadecimal string to number",
  "frombase16 base-16 ₁₆ hex2dec dec() Conversion converting change changing"
],[  "(=⌜˜∘(↕≠)≡+˝∘×⎉1‿∞⟜(⍉+))n2",
  "Is square matrix n2 unitary?",
  "testif Unitary?"
],[  "(+´¨(+⌜´(↕2)¨)⊔·×⌜´1⋈¨˜-)n1",
  "Coefficients in ascending order of polynomial with roots n1",
  "solve"
],[  "⊑∘{𝕩𝕊⍟≢𝕩(+´⊸÷⋈+´⌾÷⊸×)≠𝕩}n1",
  "Arithmetic-harmonic mean",
  "average AHM() HAM() AH() HA() harmonic-arithmetic"
],[  "(<·⌈´≢¨«¨·<1⥊˜·⌈´=¨)⊸(↑¨)y1",
  "Pad elements of list of arbitrary-rank arrays y1 to equal shape",
  "list cells items"
],[  "m1+´∘×○(÷⟜(√+´∘×˜)-⟜(+´÷≠))n1",
  "Sample Pearson correlation coefficient",
  "pcc() ppmcc() bivariate"
],[  "⊑∘{𝕩𝕊⍟≢𝕩(+´⊸÷⋈×´⊸(√˜))≠𝕩}n1",
  "Arithmetic-geometric mean",
  "average AGM() GAM() AG() GA() geometric-arithmetic common"
],[  "((↕-⌈∘÷⟜2)(⊣⌽˘⌾⍉⌽˘)≍˜⥊⟜↕×˜)j0",
  "a magic square, odd side j0",
  ""
],[  "x1(⊑{+´𝕨⋈⟜¬⊸×1‿¯1↓¨<𝕩}⍟(1-˜≠∘⊢)˜)m0",
  "Bezier curve with control points x1 evaluated at m0, by De Casteljau's algorithm",
  "polynomial spline value of interpolate parameter linear quadratic cubic"
],[  "⊑∘{𝕩𝕊⍟≢𝕩(×´⊸(√˜)⋈+´⌾÷⊸×)≠𝕩}n1",
  "Geometric-harmonic mean",
  "average GHM() HGM() GH() HG() harmonic-geometric"
],[  "(((≠×+´∘×˜)-·×˜+´)÷·(1⌈-⟜1)⊸×≠)n1",
  "Sample variance",
  "σ² s² σ^2 s^2 empirical Var(x) dispersion"
],[  "×˜⊸((2÷√π)×⋆∘-⊸××1(1+×)´÷⟜(1.5+↕99))n0",
  "Error function (normalized integral of Gaussian)",
  "statistics erf() normal distribution sigmoid cdf cumulative"
],[  "((≍↕0){∾˝(0∾˘1+𝕩)⊸⊏˘⍒˘=⌜˜↕𝕨}´-⟜↕)n0",
  "All permutations of ↕n0, as table rows in lexicographical order",
  "combinatorics ordered orderings anagrams without replacement list"
],[  "c1(¯1⊑(1⊸+⥊+)○≠(⌊`⊢⌊⊏⊸»∘⊢-0∾1+⊣)˝=⌜⟜⌽)d1",
  "Levenshtein distance (number of single-character edits) between strings",
  "fuzzy match"
],[  "m0(∾·(⍉∾˘¨⟜(∾˜`)˝˜≠↑(↓≍↕0)˙)⌾⌽↕⟜↕)n0",
  "All length-m0 subsets (combinations) of ↕n0, as table rows in lexicographical order",
  "combinatorics selections list sublists subsequences choices choose"
],[  "i0(⊣|·⊑{0=𝕨?1‿0;(⌽-(0⋈𝕩⌊∘÷𝕨)⊸×)𝕨𝕊˜𝕨|𝕩})j0",
  "Multiplicative inverse of n0 modulo m0",
  "extended euclidean algorithm modular modulus modinv() invmod() numbertheory arithmetic"
],[  "f{𝕎𝕩}y",
  "Function to apply f to y as a function",
  "call tacit dynamic value subject"
],[  "{<˘⍉>𝕩}y1",
  "Invert list of lists, so that element i of j of the result is j of i of the argument",
  "transpose transposing vtv cell element 1st lists zip() remixing zipping merging interweave interweaving interleave interleaving shuffle shuffling meshing"
],[  "x1{∾𝕨⊸∾¨𝕩}y1",
  "Join list of lists y1 using separator x1, including leading separator",
  "text with using string list joiner combiner joining combining merge merging"
],[  "c{𝕨⊸⊐⌾<𝕩}d1",
  "Position of first occurrence of string d1 in list of strings c",
  "indexin indexof vtv vector 1st"
],[  "{⥊1‿0‿1∧⌜⍟𝕩1}j0",
  "Cantor set iteration j0",
  "fractal ternary middle third"
],[  "i1{𝕨⊏⍟𝕩↕≠𝕨}j0",
  "Permutation i1 to the power of j0",
  "repeated"
],[  "x{𝕨⌾(¯1⊸⊏)𝕩}y",
  "Replace last major cell of y with x0",
  "substitute merge amend replace update item element"
],[  "{+⟜÷´¨1↓↑𝕩}n1",
  "Continued fraction convergents with terms n1",
  "series sequence"
],[  "{⥊+⌜´𝕩⥊<↕10}i0",
  "Sum of digits of the first 10⋆i0 numbers",
  "sod()"
],[  "m{𝕨⊸×⊸+˜´𝕩}n1",
  "Value of polynomial with ascending coefficients n1 at points m (Horner's method)",
  ""
],[  "x1{𝕨⌾(0‿0⊸⍉)𝕩}y2",
  "Matrix y2 with main diagonal changed to x1",
  "inplace update table"
],[  "{2÷˜-´⥊𝕩×1‿1⌽𝕩}n2",
  "Signed area of 2-dimensional polygon given by 2-column matrix n2",
  " triangle shape region size points coordinates"
],[  "{𝕩⌾(0‿0⊸⍉)0⌜˜𝕩}y1",
  "Diagonal matrix with elements of y1 (filled appropriately)",
  "cells items table"
],[  "m0{(𝕨⊣0)∾𝕩÷1+↕≠𝕩}n1",
  "Integral of polynomial n1 with ascending coefficients and optional constant m0",
  "firstintegral integrate"
],[  "{(√π)÷˜⋆-×˜𝕩}n",
  "Gaussian or normal distribution with mean 0 and variance 1/2",
  "statistics probability bell curve pdf probability density function"
],[  "a1(-⟜»1⊸⌽⊸/⟜(+`))n",
  "Sums over (+/) sublists of n indicated by a1",
  "segmented partitioned sub-vectors"
],[  "i0(1↓=⟜(+`⊑⊸=)/⊢)y1",
  "The i0'th sublist of y1, where sublists are separated by ⊑y1",
  "select pick partitionedvector segmentedstring index cell item 1st"
],[  "{(∾𝕊¨)⍟(1<≡)⥊𝕩}Y",
  "List of all atoms in Y (flatten)",
  "enlist flattening flattened raze razing ϵ ε ∈ flatten() cells items"
],[  "m0{𝕨(|𝕊⍟(>⟜0)⊣)𝕩}n0",
  "Greatest Common Divisor of natural numbers m0 and n0",
  "gcd() gcf() factor hcf() highest gcm() measure hcd Caron hacek invertedcircumflex checkmark hachek"
],[  "{x0¨⌾((y0=𝕩)/○⥊⊢)𝕩}y",
  "Replace all values y0 in y with x0",
  "substitute merge amend replace update"
],[  "n0{𝕩+´∘××`1»𝕨÷1+↕≠𝕩}n1",
  "Value of Taylor series with coefficients n1 at point n0",
  ""
],[  "x{𝕨¨⌾((𝕩∊y)/○⥊⊢)𝕩}z",
  "Replace all occurrences of elements from y in array z with x",
  "substitute merge amend update cells items"
],[  "{𝕩𝕊⍟≢∨˝∘∧⎉1‿∞˜⊸∨𝕩}b2",
  "Transitive closure",
  "adjacency list matrix contingency table"
],[  "m0(×÷{𝕨(|𝕊⍟(>⟜0)⊣)𝕩})n0",
  "Lowest Common Multiple of natural numbers m0 and n0",
  "least smallest lcm() denominator lcd() caret wedge hat circumflex ^"
],[  "{'-'¨⌾((' '=𝕩)⊸/)𝕩}y",
  "Replace all blanks with dashes",
  "spaces substitute format"
],[  "a{𝕩∧𝕨(⊢=⌈`∘×)+`»⊸<𝕩}b",
  "Trim groups of ones in b to begin only where first pointed to by a 1 in a",
  "runs sequences chop limit indicated trues truths 1st"
],[  "(-2⌊∘÷˜·+´·∧`' '=⌽)⊸⌽˘d2",
  "Center flush left character array",
  "centre align"
],[  "{∨´1‿𝕩∧3‿4=+˝⥊⌽⟜𝕩¨⋈⌜˜¯1‿0‿1}b2",
  "Conway's Game of Life: next generation",
  "gol conways cellularautomaton sub-array"
],[  "a1{+`(+`»𝕩)»⊸-⊸+⌾(𝕨⊸/)𝕩}n",
  "Cumulative sums (+`) over sublists of n indicated by a1",
  "sub-vectors"
],[  "a1{≠`(≠`»𝕩)»⊸≠⊸≠⌾(𝕨⊸/)𝕩}b",
  "Running parity (≠`) over sublists of b indicated by a1",
  "sub-vectors sublists sub-lists"
],[  "{÷○⊑˝¨+˝∘×⎉1‿∞`{𝕩‿1≍1‿0}¨𝕩}n1",
  "Continued fraction convergents with terms n1, in linear time",
  "series sequence"
],[  "{{𝕊⍟(𝕩<○≠⊢)⟜(𝕩∾·/𝕨⊸<)𝕨∨∧´∘⊏⟜𝕨¨p}⟜/0¨p←𝕩}y1",
  "Topological sort if each index i of y1 depends on indices i⊑y1 (partial result if there are circular dependencies)",
  "dependency resolution ordering dag scheduling kahn's algorithm"
],[  "i0{(𝕨↑·⍋⊏⟜𝕩)⊸⊏/𝕩≤(𝕨-1)⊑∧(⌈∘√𝕨⊸×)⊸•rand.Subset∘≠⊸⊏𝕩}n1",
  "Indices of smallest i0 elements of n1 (fast i0↑⍋n1)",
  "least minimum infirmum smallest lowest"
],[  "i0{(𝕨↑·⍒⊏⟜𝕩)⊸⊏/𝕩≥(𝕨-1)⊑∨(⌈∘√𝕨⊸×)⊸•rand.Subset∘≠⊸⊏𝕩}n1",
  "Indices of largest i0 elements of n1 (fast i0↑⍒n1)",
  "most maximum supremum biggest largest highest"
],[  "x{𝔽𝔾⊢}y",
  "Church Boolean AND",
  "∧ conjunction caret wedge hat circumflex Kpq"
],[  "x{⊣𝔽𝔾}y",
  "Church Boolean OR",
  "∨ disjunction vel alternation Caron hacek invertedcircumflex checkmark hachek Apq"
],[  "x{𝔽𝔾⊣}y",
  "Church Boolean Converse Implication",
  "≥ because ∵ ⇐ if converseconditional Bpq reverseimplying"
],[  "x{𝔾𝔽⊣}y",
  "Church Boolean Implication",
  "≤ materialconditional materialconsequence implies implying materialimplication therefore ∴ ⇒ Cpq"
],[  "x{⊢𝔽𝔾˜}y",
  "Church Boolean NOR",
  "⍱ peirce'sarrow quine'sdagger ampheck neithernor jointdenial Xpq ⊽"
],[  "x{𝔽˜𝔾⊢}y",
  "Church Boolean Converse Nonimplication",
  "< ⇍ Mpq"
],[  "x{𝔾˜𝔽⊢}y",
  "Church Boolean Nonimplication",
  "> abjunction ⇏ not butnot Lpq"
],[  "x{𝔽˜𝔾⊣}y",
  "Church Boolean NAND",
  "⍲ shefferstroke notand andtilde carettilde alternativedenial Dpq ⊼"
],[  "{𝔽˜𝔾𝔽}",
  "Church Boolean XOR",
  "≠ exclusivedisjunction eor exor ⊕ ⊻ ⇎ Jpq"
],[  "{𝔽𝔾𝔽˜}",
  "Church Boolean XNOR",
  "= materialbiconditional biimplication eqv nxor bothorneither exclusivenor materialequivalence ⇔ δ ẟ Kroneckerdelta iff logicalequivalence Epq doubleimplying"
],[  "F{𝔽𝕩⋄𝕩}y",
  "Apply function F but discard result and return the original value",
  "is-yfunction do-yfunction enpassant noresult isyfunction doyfunction"
],[  "F{⊐⊏𝔽∘⍷}y",
  "Apply deterministic cell-wise F to cells of y, avoiding extra calls for duplicate cells",
  "performance memoisation memoization quick speed"
],[  "F{⊢𝔽¨¨1↓↓}n1",
  "Apply F to all pairs of distinct elements in n1, reverse order",
  "all-pairs combinations ordered every each"
],[  "F{⊢𝔽¨¨1↓↑}n1",
  "Apply F to all pairs of elements in n1 including self-pairs",
  "all-pairs combinations ordered every each"
],[  "F{𝕨𝔽˜´⌽𝕩}y",
  "Fold from the left",
  "reduction typenotation reducing folding"
],[  "F{⊢𝔽¨¨≠↑↓}n1",
  "Apply F to all pairs of elements in n1 including self-pairs, reverse order",
  "all-pairs combinations ordered every each"
],[  "F{⊢𝔽¨¨≠↑↑}n1",
  "Apply F to all pairs of distinct elements in n1",
  "all-pairs combinations ordered every each"
],[  "F{𝕊∘⊢⍟≢⟜𝔽𝕩} y",
  "Fixed point of F if applied repeatedly to y",
  "fixpoint ycombinator repeated iterated until convergence powerlimit stable"
],[  "x i0{𝕗⊸↑∾⊣∾𝕗⊸↓} y",
  "Insert x into y before major cell i0",
  "items elements"
],[  "f{𝕨𝕩{𝕨𝕏𝕗}⚇∞‿0𝕗}",
  "Function that applies all functions in nested array f and returns all results",
  "each every list gerund elements to both arguments collect"
],[  "F{𝔽⍟𝔾∘𝔽_𝕣_𝔾∘𝔽⍟𝔾𝕩}G y",
  "Apply F to y repeatedly until G returns 0 (avoiding stack overflow)",
  "application poweroperator circlestar starcircle repeated repeating iterating looping while"
],[  "F{F _𝕣_ G: {𝕊:F𝕩 ; 𝕊⁼:G𝕩}}G",
  "Function that applies like F with inverse set to G",
  "obverse specify specified undo header opposite"
],[  "F{𝔽∘⊢⍟≢⟜𝔽_𝕣∘⊢⍟≢⟜𝔽𝕩} y",
  "Fixed point of F starting at y (avoiding stack overflow)",
  "fixpoint ycombinator repeated iterated until convergence powerlimit stable low stack"
],[  "x{(𝕘⊏˜𝕗⊸⊐)⌾((𝕩∊𝕗)⊸/)𝕩}y z",
  "Replace major cells of z that appear in x with the corresponding major cell from y",
  "substitute merge amend update translate transform map selective search-and-replace find-and-replace items high-rank array matrix matrices set"
],[  "10{⌽𝕗|⌊∘÷⟜𝕗⍟(↕1+·⌊𝕗⋆⁼1⌈⊢)}j0",
  "Base-10 digits of natural number j0",
  "base10 decimal base-10"
],[  "2{⌽𝕗|⌊∘÷⟜𝕗⍟(↕1+·⌊𝕗⋆⁼1⌈⊢)}j0",
  "Binary representation of natural number j0",
  "digits base2 base-2 Boolean"
],[  "x1{(𝕘⊏˜𝕗⊸⊐)⌾((𝕩∊𝕗)/○⥊⊢)𝕩}y1 z",
  "Replace elements of z that appear in x1 with the corresponding element from y1",
  "substitute merge amend update translate transform map selective search-and-replace find-and-replace items lists set cells"
],[  "{(>⟜«0≤𝕩)/0(0⊸≤××⟜10⊸+)`𝕩}∘-⟜'0' d1",
  "Extract natural numbers from a string of digits and separators less than '0'",
  "frombase10 base-10 dec() decimal Conversion converting change changing scanf read"
],[  "c1 d0{∾1(↑∾·⥊𝕩≍˘↓)𝕨⊔˜(1-˜∾⟜0¬⊸×1+`∾⟜1)𝕗=𝕨} y1",
  "Replace the instances of d0 in c1 with the strings in list y1 in order",
  "substitute merge amend update translate transform map selective search-and-replace find-and-replace items lists set interpolate"
],[  "mantEexp",
  "Scaled Notation",
  "exponent timestento mantissa"
],[  "realIimag",
  "Complex Notation",
  "plusitimes imaginary"
],[  "¯",
  "Negative number indicator",
  "macron highminus minus indicate sign masking indicating"
],[  "name←y",
  "Define",
  "leftarrow gets is copula let define naming denotes means"
],[  "name F↩y",
  "Modify: change name to name F y",
  "leftarrow gets is copula let redefine naming denotes means inplace update"
],[  "name↩y",
  "Change definition",
  "inplace replace value reassignment re-assignment reassigning re-assigning"
],[  "𝕨",
  "Block left argument",
  "alpha leftarg α ɑ alfa larg"
],[  "𝕨",
  "Optional left argument in header",
  "curlybraces function operator default ambivalent variadic traditional ambivalence header"
],[  "𝕩",
  "Block right argument",
  "omega rightarg ω ꞷ rarg"
],[  "𝔽",
  "Block modifier left operand",
  "alpha leftop"
],[  "𝔾",
  "Block modifier right operand",
  "omega rightop"
],[  "𝕊",
  "Function self-reference",
  "del recurse triangledown downtriangle carrot"
],[  "𝕣",
  "Modifier self-reference",
  "deldel recurse triangledown downtriangle carrot"
],[  "⋄",
  "Statement Separator",
  "diamond statementseparator break stop else then"
],[  ",",
  "Statement Separator",
  "diamond statementseparator break stop else then"
],[  "#",
  "Comment symbol (disables rest of line)",
  "commentout lamp ignore skip note nb"
],[  "int.frac",
  "Decimal Point",
  "period rational"
],[  "'",
  "Character delimiter",
  "quote apostrophe string text"
],[  "",
  "String delimiter",
  "quote apostrophe string text "
],[  "∞",
  "Positive infinity",
  "upper limit ∞ ∞ ¯ positiveinfinity ∞"
],[  "¯∞",
  "Negative infinity",
  "lower limit -∞ ¯∞ ¯¯ negativeinfinity -∞"
],[  "x0⌈y0⌊z",
  "Force z to range x0≤z≤y0",
  "clamp limitrange between –"
],[  "a0⊑x‿y",
  "Pick y if a0 is true or x if a0 is false",
  "conditionalck choose"
],[  "@+0",
  "Null character (NUL)",
  ""
],[  "@+10",
  "Line Feed (LF)",
  ""
],[  "@+11",
  "Vertical Tab character (VT)",
  ""
],[  "@+12",
  "Form Feed character (FF)",
  ""
],[  "@+127",
  "Delete character (DEL)",
  ""
],[  "@+13",
  "Carriage Return character (CR)",
  ""
],[  "@+26",
  "End-Of-File character (EOF)",
  ""
],[  "@+27",
  "Escape character (ESC)",
  ""
],[  "@+7",
  "Bell character (BEL)",
  ""
],[  "@+8",
  "Backspace character (BS)",
  ""
],[  "@+9",
  "Horizontal Tab character (HT)",
  ""
],[  "⊢name←y",
  "Define, and print if in the session",
  "passthroughvalue yieldassignment"
],[  "name∾↩y",
  "Fast: 'name' redefined to be its value with y catenated along its first axis",
  "amend append extend accumulate concatenate dimension 1st"
],[  "(F G H)y",
  "Fork: (F y)G(H y)",
  "pointwise tacit roundparentheses roundparens grouping derived fgh 3train 3-train"
],[  "(F G)y",
  "Atop: F G y",
  "tacit roundparentheses roundparens grouping derived fg 2train 2-train"
],[  "(x G H)y",
  "Fork: x G H y",
  "pointwise tacit roundparentheses roundparens grouping derived Agh 3train 3-train"
],[  "x(F G H)y",
  "Fork: (x F y)G(x H y)",
  "pointwise tacit roundparentheses roundparens grouping derived fgh 3train 3-train"
],[  "x(F G)y",
  "Atop: F x G y",
  "tacit roundparentheses roundparens grouping derived fg 2train 2-train"
],[  "x(z G H)y",
  "Fork: z G x H y",
  "pointwise tacit roundparentheses roundparens grouping derived Agh 3train 3-train"
],[  "2×π",
  "tau (2 pi)",
  "Palais'circleconstant Palais'constant Palaisconstant 6.283185307179586476925286766559006 τ 𝜏"
],[  "m×n⋆¯1⋆a",
  "Conditionally multiply (where a=0) or divide (where a=1) m by n",
  "per-element item cell"
],[  "m0+n0×↕j0",
  "Arithmetic progression list: j0 elements starting at m0 with step n0",
  "list sequence seq() cells items"
],[  "@+13‿10",
  "Carriage Return-Line Feed pair (CRLF)",
  ""
],[  "⌊0.5+n",
  "Round to nearest integer",
  "int()"
],[  "'''",
  "Quote character",
  "apostrophe ’ U+27 0x27 ≢27 quotationmark prime singlequoted in string symbol escape literal"
],[  "2÷˜1+√5",
  "Golden ratio (direct formula)",
  "phi φ ϕ ɸ 1.618033988749894848204586834365638 0.618033988749894848204586834365638"
],[  "@+31↓↕126",
  "Printable ASCII",
  "characters"
],[  "(x+y)×z",
  "Precedence: z×x+y",
  "roundparentheses grouping roundparens"
],[  "(a×i1)↓y",
  "Conditional drop of i1 elements from array y only if a is true",
  "major cells items delete remove without"
],[  "x‿(y‿z)",
  "Stranding: ⟨x,⟨y,z⟩⟩",
  "roundparentheses roundparens grouping nestedarraynotation nestedvectornotation"
],[  "F←{𝕨}",
  "Prototypical dyadic block function",
  "direct dynamic lambda anonymous curlybraces assignment header defining"
],[  "F←{𝕩}",
  "Prototypical monadic block function",
  "direct dynamic lambda anonymous curlybraces assignment header defining"
],[  "⟨name1,name2⟩←y",
  "Multiple assignment",
  "leftarrow get are copula let define list naming denote mean unpacking distributing distribution vector distributed pervasive pervading pervade unpacking unpacked"
],[  ">x1‿y1‿…",
  "n-row table from n vectors",
  "rows table lists"
],[  "'0'+↕10",
  "The digits from 0 to 9",
  "123456789 numbers arabicnumerals 0-9 0123456789"
],[  "'a'+↕26",
  "The letters from a to z",
  "abcdefghijklmnopqrstuvwxyz latinalphabet englishletters uppercase a-z ABCDEFGHIJKLMNOPQRSTUVWXYZ"
],[  "(1˙𝕨)⊣0",
  "Was this block function called monadically?",
  "arity ambivalent ambivalence variadic leftargument 900⌶ monadic?"
],[  "_op←{𝔽𝕨}",
  "Prototypical block 1-modifier deriving dyadic functions",
  "direct dynamic lambda anonymous curlybraces assignment header defining"
],[  "_op←{𝔽𝕩}",
  "Prototypical block 1-modifier deriving monadic functions",
  "direct dynamic lambda anonymous curlybraces assignment header defining"
],[  "_op_←{𝔾𝕨}",
  "Prototypical block 2-modifier deriving dyadic functions",
  "direct dynamic lambda anonymous curlybraces assignment header defining"
],[  "_op_←{𝔾𝕩}",
  "Prototypical block 2-modifier deriving monadic functions",
  "direct dynamic lambda anonymous curlybraces assignment header defining"
],[  "name1‿name2⌽∘⊣↩@",
  "Swap variable values",
  "leftarrow get are copula let redefine redefining list renaming denote mean unpacking redistributing redistribution vector exchange exchanging swapping variables"
],[  "x{𝕨⌾⊏𝕩}y",
  "Replace first major cell of y with x",
  "substitute merge amend replace update 1st item element"
],[  "f{𝕎𝕩}¨<y",
  "Apply each function in f to the whole of y",
  "functions each every list gerund elements collect"
],[  "m1⊸+¨n1⊸×¨↕j1",
  "Multi-dimensional arithmetic progression with dimensions j1 starting at m1 with steps n1",
  "sequence seq() multidimensional axes"
],[  "{𝕩𝕊⍟≠1+÷𝕩}1",
  "Golden ratio (as a limit)",
  "phi φ ϕ ɸ 1.618033988749894848204586834365638 0.618033988749894848204586834365638"
],[  "(↕2)∾⌜⍟2<⟨⟩",
  "Unit square",
  ""
],[  "(↕2)∾⌜⍟3<⟨⟩",
  "Unit cube",
  ""
],[  "(↕2)∾⌜⍟4<⟨⟩",
  "Unit tesseract",
  ""
],[  "↕∘⌈⌾((m0+c0×⊢)⁼)n0",
  "Range starting at m0 with step size c0, ending before n0",
  "sequence interval"
],[  "(↕1+⌈)⌾((m0+c0×⊢)⁼)n0",
  "Range starting at m0 with step size c0, ending after n0",
  "sequence interval"
],[  "(↕1+⌊)⌾((m0+c0×⊢)⁼)n0",
  "Range starting at m0 with step size c0, ending at or before n0",
  "sequence interval"
],[  "1⌽∾˜9⥊1⌽∾˜9⥊",
  "An expression giving itself",
  "quine"
],[  "(2×a)÷˜b-⊸(+⋈-)√(×˜b)-(4×a×c)",
  "Solutions of quadratic equation ax²+bx+c=0",
  "coefficients F(x)=ax²+bx+c=0 F(x)=ax^2+bx+c=0"
],[  "1‿¯1‿¯1‿1‿0{y‿z←3↓𝕨⋄0⊸<◶⟨Y+Z,»⟜𝕨⊸𝕊{𝕤𝔽k-↩1}⟩k←𝕩}10",
  "Man or boy test",
  "Knuth ALGOL"
],[  "(0=3‿5⊸|)◶(⊢˙⌾⊑∾⌜○{‿𝕩}´Fizz‿Buzz)¨1+↕100",
  "FizzBuzz",
  "fizz buzz interview counting"
]]
"""



/**
 This autocomplete provider can be used in the non-pro demos,
 where KeyboardKit Pro standard autocomplete isn't available.

 ``KeyboardViewController`` registers it to show how you can
 register and use a custom autocomplete provider.

 This provider always returns three autocomplete suggestions,
 with the current word suffixed with "-1", "-2" and "-3". It
 also adds a static subtitle to the middle suggestion.

 If the currently typed word is "match" (this can be changed
 in the init) the provider returns another result, where the
 left suggestion is an "unknown" suggestion, the center is a
 highlighted autocomplete suggestion and the right is just a
 regular suggestion without any special look or behavior.
 */
class FakeAutocompleteProvider: AutocompleteProvider {
    var bqncrate: [[String]]

    init(match: String = "match") {
        self.match = match
        let data = JSONString.data(using: .utf8, allowLossyConversion: false)
        self.bqncrate = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [[String]]
    }

    private var match: String
    
    var locale: Locale = .current
    
    var canIgnoreWords: Bool { false }
    var canLearnWords: Bool { false }
    var ignoredWords: [String] = []
    var learnedWords: [String] = []
    
    func hasIgnoredWord(_ word: String) -> Bool { false }
    func hasLearnedWord(_ word: String) -> Bool { false }
    func ignoreWord(_ word: String) {}
    func learnWord(_ word: String) {}
    func removeIgnoredWord(_ word: String) {}
    func unlearnWord(_ word: String) {}
    
    func autocompleteSuggestions(for text: String, completion: AutocompleteCompletion) {
        guard text.count > 0 else { return completion(.success([])) }
        if text == match {
            completion(.success(matchSuggestions()))
        } else {
            completion(.success(fakeSuggestions(for: text)))
        }
    }
}

private extension FakeAutocompleteProvider {
    func fakeSuggestions(for text: String) -> [AutocompleteSuggestion] {
        var res = ""
       let filteredStrings = self.bqncrate.filter({(item: [String]) -> Bool in
           let stringMatch = item[1].lowercased().range(of: text.lowercased())
           return stringMatch != nil ? true : false
       })
        if filteredStrings.count != 0 {
            res = filteredStrings.first![0]
        }
        return [
          AutocompleteSuggestion(text: res, subtitle: "@BQNCrate"),
        ]
    }
    
    func fakeSuggestion(_ text: String, _ subtitle: String? = nil) -> AutocompleteSuggestion {
        AutocompleteSuggestion(text: text, subtitle: subtitle)
    }

    func matchSuggestions() -> [AutocompleteSuggestion] {
        [
            AutocompleteSuggestion(text: match, isAutocomplete: true),
        ]
    }
}
