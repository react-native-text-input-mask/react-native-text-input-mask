//
// Project «InputMask»
// Created by Jeorge Taflanidi
//


import Foundation


/**
 Utility extension for commonly used ```Mask``` operations upon strings.
 */
public extension String {

    /**
     A shortcut for ```String(str.reversed())```.
     */
    var reversed: String {
        return String(self.reversed())
    }
    
    /**
     Make a string by cutting the first character of current.
     
     - returns: Current string without first character.
     
     - throws: EXC_BAD_INSTRUCTION for empty strings.
     */
    func truncateFirst() -> String {
        return String(self[self.index(after: self.startIndex)...])
    }
    
    /**
     Find common prefix.
     */
    func prefixIntersection(with string: String) -> Substring {
        var lhsIndex = startIndex
        var rhsIndex = string.startIndex
        
        while lhsIndex != endIndex && rhsIndex != string.endIndex {
            if self[lhsIndex] == string[rhsIndex] {
                lhsIndex = index(after: lhsIndex)
                rhsIndex = string.index(after: rhsIndex)
            } else {
                return self[..<lhsIndex]
            }
        }
        
        return self[..<lhsIndex]
    }
    
    /**
     Reverse format string preserving `[...]` and `{...}` symbol groups.
     */
    func reversedFormat() -> String {
        return String(
            String(self.reversed())
                .replacingOccurrences(of: "[\\", with: "\\]")
                .replacingOccurrences(of: "]\\", with: "\\[")
                .replacingOccurrences(of: "{\\", with: "\\}")
                .replacingOccurrences(of: "}\\", with: "\\{")
                .map { (c: Character) -> Character in
                    switch c {
                        case "[": return "]"
                        case "]": return "["
                        case "{": return "}"
                        case "}": return "{"
                        default: return c
                    }
                }
        )
    }

    /**
     A shortcut for ```str.distance(from: str.startIndex, to: index)```.
     */
    func distanceFromStartIndex(to index: String.Index) -> Int {
        return self.distance(from: self.startIndex, to: index)
    }

    /**
     A shortcut for ```str.index(str.startIndex, offsetBy: offset)```.
     */
    func startIndex(offsetBy offset: Int) -> String.Index {
        return self.index(self.startIndex, offsetBy: offset)
    }
    
}
