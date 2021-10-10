//
//  MorphFolder.swift
//  
//
//  Created by Justin White on 10/10/21.
//

import Foundation

public struct MorphFolder: Codable {
    public var morphsAndPoints: [String: Int] = [:]
    
    public var points = 0
    
    public var show: String
    
    public var version: Int = 1
    
    public func score(usingKnownValues knownValues: [String]) -> Double {
        
        if points == 0 {
            return 0.0
        }
        
        let crossOver = morphsAndPoints.filter({ knownValues.contains($0.key) })
        let pointsKnown: Double = Double(crossOver.map({$0.value}).reduce(0, +))
        
        return pointsKnown / Double(points)
    }
}
