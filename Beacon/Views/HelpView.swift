//
//  HelpView.swift
//  Beacon
//
//
//

import Foundation
import SwiftUI

func toDict(h: String) -> [String: String] {
    var helpDict = [String: String]()
    var components = h.components(separatedBy: "--------------------------------------------------------------------------------")
    components.removeFirst()
    for component in components {
        let lines = component.components(separatedBy: "\n")
        let key = String(lines[1])
        let value = lines[2...].joined(separator: "\n")
        helpDict[key] = value
    }
    return helpDict
}

// taken from ngn/k/repl.k
let kh: String = """
--------------------------------------------------------------------------------
\\:h
\\   help               \\\\         exit
\\a  license(AGPLv3)    \\l file.k  load
\\0  types              \\d foo.bar set namespace; restore with  \\d .
\\+  verbs              \\t:n expr  time(elapsed milliseconds after n runs)
\\:  I/O verbs          \\v         variables
\\'  adverbs            \\f         functions
\\`  symbols            \\cd path   change directory
\\h  summary            \\other     command(through /bin/sh)
--------------------------------------------------------------------------------
\\0
Types:
list atom
 `A        generic list   ()   ,"ab"   (0;`1;"2";{3};%)
 `I   `i   int            0N -9223372036854775807 01b
 `F   `f   float          -0w -0.0 0.0 0w 1.2e308 0n
 `C   `c   char           "a"   0x6263   "d\\0\\"\\n\\r\\t"
 `S   `s   symbol         `   `a   `"file.txt"   `b`cd`"ef"
 `M   `m   table&dict     +`a`b!(0 1;"23")   (0#`)!()
      `o   lambda         {1+x*y#z}  {[a;b]+/*/2#,a,b}
      `p   projection     1+   {z}[0;1]   @[;i;;]
      `q   composition    *|:   {1+x*y}@
      `r   derived verb   +/   2\\   {y,x}':
      `u   monadic verb   +:   0::
      `v   dyadic  verb   +   0:
      `w   adverb         '   /:
      `x   external func
--------------------------------------------------------------------------------
\\:
I/O verbs
  0:x read  lines
x 0:y write lines
  1:x read  bytes
x 1:y write bytes
   <s open          fd:<`"file.txt"
   >i close         >fd

x can be a file descriptor (int) or symbol or string such as
 "file.txt"
 "/path/to/file"
 "host:port"
 ":port"         /host defaults to 127.0.0.1
--------------------------------------------------------------------------------
\\+
Verbs:    : + - * % ! & | < > = ~ , ^ # _ $ ? @ . 0: 1:
notation: [c]har [i]nt [n]umber(int|float|char) [s]ymbol [a]tom [d]ict
          [f]unc(monad) [F]unc(dyad) [xyz]any
special:  var:y     set    a:1;a -> 1
          var::y    global a:1;{a::2}[];a -> 2
          (v;..):y  unpack (b;(c;d)):(2 3;4 5);c -> 4
          :x        return {:x+1;2}[3] -> 4
          :[x;y;..] cond   :[0;`a;"\\0";`b;`;`c;();`d;`e] -> `e
          o[..]     recur  {:[x<2;x;+/o'x-1 2]}9 -> 34
          [..]      progn  [0;1;2;3] -> 3

::  self      f:(::);f 12 -> 12
 :  right     f:(:);f[1;2] -> 2   "abc":'"d" -> "ddd"
 +x flip      +("ab";"cd") -> ("ac";"bd")
N+N add       1 2+3 -> 4 5
 -N negate    - 1 2 -> -1 -2
N-N subtract  1-2 3 -> -1 -2
 *x first     *`a`b -> `a   *(0 1;"cd") -> 0 1
N*N multiply  1 2*3 4 -> 3 8
 %N sqrt      %25 -> 5.0   %-1 -> 0n
N%N divide    2 3%4 -> 0.5 0.75
 !i enum      !3 -> 0 1 2   !-3 -> -3 -2 -1
 !I odometer  !2 3 -> (0 0 0 1 1 1;0 1 2 0 1 2)
 !d keys      !`a`b!0 1 -> `a`b
 !S ns keys   a.b.c:1;a.b.d:2;!`a`b -> `c`d
x!y dict      `a`b!1 2 -> `a`b!1 2
i!I div       -10!1234 567 -> 123 56
i!I mod       10!1234 567 -> 4 7
 &I where     &3 -> 0 0 0   &1 0 1 4 2 -> 0 2 3 3 3 3 4 4
 &x deepwhere &(0 1 0;1 0 0;1 1 1) -> (0 1 2 2 2;1 0 0 1 2)
N&N min/and   2&-1 3 -> -1 2   0 0 1 1&0 1 0 1 -> 0 0 0 1
 |x reverse   |"abc" -> "cba"   |12 -> 12
N|N max/or    2|-1 3 -> 2 3   0 0 1 1|0 1 0 1 -> 0 1 1 1
 <X ascend    <"abacus" -> 0 2 1 3 5 4
 >X descend   >"abacus" -> 4 5 3 1 0 2
 <s open      fd:<`"/path/to/file.txt"
 >i close     >fd
N<N less      0 2<1 -> 1 0
N>N more      0 1>0 2 -> 0 0
 =X group     ="abracadabra" -> "abrcd"!(0 3 5 7 10;1 8;2 9;,4;,6)
 =i unitmat   =3 -> (1 0 0;0 1 0;0 0 1)
N=N equal     0 1 2=0 1 3 -> 1 1 0
 ~x not       ~(0 2;``a;"a \\0";::;{}) -> (1 0;1 0;0 0 1;1;0)
x~y match     2 3~2 3 -> 1   "4"~4 -> 0   0~0.0 -> 0
 ,x enlist    ,0 -> ,0   ,0 1 -> ,0 1   ,`a!1 -> +(,`a)!,,1
x,y concat    0,1 2 -> 0 1 2  "a",1 -> ("a";1)
d,d merge     (`a`b!0 1),`b`c!2 3 -> `a`b`c!0 2 3
 ^x null      ^(" a";0 1 0N;``a;0.0 0n) -> (1 0;0 0 1;1 0;0 1)
a^y fill      1^0 0N 2 3 0N -> 0 1 2 3 1   "b"^" " -> "b"
X^y without   "abracadabra"^"bc" -> "araadara"
 #x length    #"abc" -> 3   #4 -> 1   #`a`b`c!0 1 0 -> 3
i#y take      5#"abc" -> "abcab"   -5#`a`b`c -> `b`c`a`b`c
X#d take keys `c`d`f#`a`b`c`d!1 2 3 4 -> `c`d`f!3 4 0N
I#y reshape   2 3#` -> (```;```)
f#y replicate (3>#:')#(0;2 1 3;5 4) -> (0;5 4)   {2}#"ab" -> "aabb"
 _n floor     _12.34 -12.34 -> 12 -13
 _c lowercase _"Ab" -> "ab"
i_Y drop      2_"abcde" -> "cde"   -2_`a`b`c -> ,`a
X_d drop keys `a`c_`a`b`c!0 1 2 -> (,`b)!,1
I_Y cut       2 4 4_"abcde" -> ("cd";"";,"e")
f_Y weed out  (3>#:')_(0;2 1 3;5 4) -> ,2 1 3
X_i delete    "abcde"_2 -> "abde"
 $x string    $(12;"ab";`cd;+) -> ("12";(,"a";,"b");"cd";,"+")
i$C pad       5$"abc" -> "abc  "   -3$"a" -> "  a"
s$y cast      `c$97 -> "a"   `i$-1.2 -> -1   `$"a" -> `a
s$y int       `I$"-12" -> -12
 ?X distinct  ?"abacus" -> "abcus"
 ?i uniform   ?2 -> 0.6438163747387873 0.8852656305774402 /random
X?y find      "abcde"?"bfe" -> 1 0N 4
i?x roll      3?1000 -> 11 398 293   1?0 -> ,-8164324247243690787
i?x deal      -3?1000 -> 11 398 293 /guaranteed distinct
 @x type      @1 -> `i   @"ab" -> `C   @() -> `A   @(@) -> `v
x@y apply(1)  {x+1}@2 -> 3   "abc"@1 -> "b"   (`a`b!0 1)@`b -> 1
 .S get       a:1;.`a -> 1   b.c:2;.`b`c -> 2
 .C eval      ."1+2" -> 3
 .d values    .`a`b!0 1 -> 0 1
x.y apply(n)  {x*y+1}. 2 3 -> 8   (`a`b`c;`d`e`f). 1 0 -> `d

@[x;y;f]   amend  @["ABC";1;_:] -> "AbC"   @[2 3;1;{-x}] -> 2 -3
@[x;y;F;z] amend  @["abc";1;:;"x"] -> "axc"   @[2 3;0;+;4] -> 6 3
.[x;y;f]   drill  .[("AB";"CD");1 0;_:] -> ("AB";"cD")
.[x;y;F;z] drill  .[("ab";"cd");1 0;:;"x"] -> ("ab";"xd")
.[f;y;f]   try    .[+;1 2;"E:",] -> 3   .[+;1,`;"E:",] -> "E:'type\\n"
?[x;y;z]   splice ?["abcd";1 3;"xyz"] -> "axyzd"
--------------------------------------------------------------------------------
\\`
Special symbols:
   `j?C parse json   `j?"{\\"a\\":1,\\"b\\":[true,\\"c\\"]}" -> `a`b!(1.0;(1;,"c"))
   `k@x pretty-print `k("ab";2 3) -> "(\\"ab\\";2 3)"
   `p@C parse k
 `hex@C hexadecimal  `hex"ab" -> "6162"
 `pri@i primes       `pri 20  ->  2 3 5 7 11 13 17 19
   `x@x fork-exec    `x(("/bin/wc";"-l");"a\\nbc\\nd\\n") -> "3\\n"
   `t[] current time (microseconds)
`argv[] list of cmd line args (also in global variable x)
 `env[] dict of env variables
`prng[] `prng@I get/set pseudo-random number generator internal state
                     s:`prng[];r:9?0;`prng s;r~9?0 -> 1
        `prng@0 use current time to set state
 `err@C throw error
 `sin@N trigonometry `sin 12.34 -> -0.22444212919135995
 `exp@N exponential  `exp 1 -> 2.7182818284590455
  `ln@N logarithm    `ln 2 -> 0.6931471805599453
`exit@i exit
--------------------------------------------------------------------------------
\\'
Adverbs:   ' / \\ ': /: \\:
   f' each1     #'("abc";3 4 5 6) -> 3 4
 x F' each2     2 3#'"ab" -> ("aa";"bbb")
   X' binsearch 1 3 5 7 9'8 9 0 -> 3 4 -1
   F/ fold      +/1 2 3 -> 6
   F\\ scan      +\\1 2 3 -> 1 3 6
 x F/ seeded /  10+/1 2 3 -> 16
 x F\\ seeded \\  10+\\1 2 3 -> 11 13 16
 i f/ n-do      5(2*)/1 -> 32
 i f\\ n-dos     5(2*)\\1 -> 1 2 4 8 16 32
 f f/ while     (1<){:[2!x;1+3*x;-2!x]}/3 -> 1
 f f\\ whiles    (1<){:[2!x;1+3*x;-2!x]}\\3 -> 3 10 5 16 8 4 2 1
   f/ converge  {1+1.0%x}/1 -> 1.618033988749895
   f\\ converges (-2!)\\100 -> 100 50 25 12 6 3 1 0
   C/ join      "ra"/("ab";"cadab";"") -> "abracadabra"
   C\\ split     "ra"\\"abracadabra" -> ("ab";"cadab";"")
   I/ decode    24 60 60/1 2 3 -> 3723   2/1 1 0 1 -> 13
   I\\ encode    24 60 60\\3723 -> 1 2 3   2\\13 -> 1 1 0 1
  i': window    3':"abcdef" -> ("abc";"bcd";"cde";"def")
i f': stencil   3{x,"."}':"abcde" -> ("abc.";"bcd.";"cde.")
  F': eachprior -':12 13 11 17 14 -> 12 1 -2 6 -3
x F': seeded ': 10-':12 13 11 17 14 -> 2 1 -2 6 -3
x F/: eachright 1 2*/:3 4 -> (3 6;4 8)
x F\\: eachleft  1 2*\\:3 4 -> (3 4;6 8)
--------------------------------------------------------------------------------
\\h
: SET      RETURN    :[c;t;f]     COND
+ add      flip
- subtract negate    '  each|slide|bin
* multiply first     /  fold|join |dec|comment
% divide   sqrt      \\  scan|split|enc|trace
! mod|dict enum|key  ': eachprior
& min|and  where     /: eachright
| max|or   reverse   \\: eachleft
< less     ascend
> more     descend   /
= equal    group     multiline comment
~ match    not       \\
, concat   enlist
^ without  null      0: lines i/o
# reshape  length    1: bytes i/o
_ drop|cut floor
$ cast     string
? find|rnd uniq      ?[a;i;b]     splice
@ apply(1) type      @[x;i;[f;]y] amend
. apply(n) eval      .[x;i;[f;]y] drill
grammar:  E:E;e|e e:nve|te| t:n|v v:tA|V n:t[E]|(E)|{E}|N
limits: 8 args, 16 locals, 256 bytecode, 2048 stack
"""

struct HelpView: View {
    @Binding var key: String
    let helpDictionary: [String: String] = toDict(h: kh)
    var body: some View {
        ScrollView {
            if key == #"\\:"#  || key == "" {
                all()
            } else {
                single(for: key)
            }
        }
    }

    private func single(for key: String) -> some View {
        VStack(alignment: .leading) {
            if let helpText = helpDictionary[key] {
                Text(key)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color.blue)
                ScrollView(.horizontal, showsIndicators: false) {
                    Text(helpText)
                        .font(.system(.body, design: .monospaced))
                        .lineLimit(nil)
                }
                .padding()
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .padding(.bottom)
    }

    private func all() -> some View {
        ForEach(Array(helpDictionary.keys), id: \.self) { key in
            single(for: key)
        }
    }
}

#Preview {
    HelpView(key: .constant("\\:"))
}
