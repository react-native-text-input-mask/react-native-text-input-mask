//
// Project «InputMask»
// Created by Jeorge Taflanidi
//


import Foundation


/**
 ### AffinityCalculationStrategy
 
 Allows to opt for a different mask picking algorithm in text field listeners.
 */
public enum AffinityCalculationStrategy {
    /**
     Default strategy.
     
     Uses ```Mask``` built-in mechanism to calculate total affinity between the text and the mask format.
     */
    case wholeString
    
    /**
     Finds the longest common prefix between the original text and the same text after applying the mask.
     */
    case prefix
    
    public func calculateAffinity(
        ofMask mask: Mask,
        forText text: CaretString,
        autocomplete: Bool
    ) -> Int {
        switch self {
            case .wholeString:
                return mask.apply(
                    toText: text,
                    autocomplete: autocomplete
                ).affinity
            case .prefix:
                return mask.apply(
                    toText: text,
                    autocomplete: autocomplete
                ).formattedText.string.prefixIntersection(with: text.string).count
        }
    }
}
