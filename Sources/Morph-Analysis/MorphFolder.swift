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
    
    public func score(knownValues: [String], scoreGenerator: ScoreGenerator = OptimizedScoreGenerator()) -> Double {
        return scoreGenerator.score(folder: self, knownValues: knownValues)
    }
}

public protocol ScoreGenerator {
    func score(folder: MorphFolder, knownValues: [String]) -> Double
}
    
public class BasicScoreGenerator: ScoreGenerator {
    
    public init() {
    }
    
    public func score(folder: MorphFolder, knownValues: [String]) -> Double {
        
        if folder.points == 0 {
            return 0.0
        }
        
        let crossOver = folder.morphsAndPoints.filter({ knownValues.contains($0.key) })
        let pointsKnown: Double = Double(crossOver.map({$0.value}).reduce(0, +))
        
        return pointsKnown / Double(folder.points)
    }
}


public class OptimizedScoreGenerator: ScoreGenerator {
    
    public init() {
    }
    
    public func score(folder: MorphFolder, knownValues: [String]) -> Double {
        if folder.points == 0 {
            return 0.0
        }
        
        var points: Int = 0
        
        for value in knownValues {
            if let item = folder.morphsAndPoints[value] {
                points += item
            }
        }
        
        return Double(points)/Double(folder.points)
    }
}
