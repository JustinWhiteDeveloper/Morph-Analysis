//
//  McbReader.swift
//  
//
//  Created by Justin White on 20/09/21.
//

import Foundation

protocol FileFormatReader {
    func getSubtitles(file: String, encoding: String.Encoding) -> [String]
    
    var fileExtension: String { get }
}

extension FileFormatReader {
    func getSubtitles(file: String) -> [String] {
        return getSubtitles(file: file, encoding: .utf8)
    }
}

class McbReader: FileFormatReader {
    
    static let expectedVersion = "0.1"
    
    func getSubtitles(file: String, encoding: String.Encoding) -> [String] {
        var items: [String] = []
        
        do {
            let data = try String(contentsOfFile: file)
            var lines = data.components(separatedBy: .newlines)
            
            if lines.count == 0 {
                return items
            }
            
            let versionString = lines[0]
            
            let wrongVersion = versionString != McbReader.expectedVersion
            if wrongVersion {
                return items
            }
            
            lines.remove(at: 0)
            
            for line in lines where line.isEmpty == false {
                items.append(line)
            }

        } catch {
            print(error)
        }
        
        return items
    }
    
    var fileExtension: String {
        return "mcb"
    }
}

class JapaneseFilteredMcbReader: McbReader {
    override func getSubtitles(file: String, encoding: String.Encoding) -> [String] {
        let subtitles = super.getSubtitles(file: file, encoding: encoding)
        
        return subtitles.filter({$0.containsValidJapaneseCharacters})
    }
}
