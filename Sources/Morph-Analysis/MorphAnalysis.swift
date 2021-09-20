//
//  MorphAnalysis.swift
//  
//
//  Created by Justin White on 20/09/21.
//

import Foundation

public struct MorphAnalysis: Codable {
    var version: Int = 0
    
    var items: [String: Double] = [:]
    
    public init() {}
}

extension MorphAnalysis: CustomStringConvertible {
    
    public var description: String {
        
        let defaultValue = "{}"
        
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(self)
            let json = String(data: jsonData, encoding: String.Encoding.utf8)
            
            return json ?? defaultValue
        }
        catch {
            print(error)
            return defaultValue
        }
    }
}
