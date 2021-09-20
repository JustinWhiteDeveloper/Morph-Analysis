//
//  File.swift
//  
//
//  Created by Justin White on 20/09/21.
//

import Foundation

struct File {
    let name: String
    
    var subtitles: [String] = []
    
    var success: Bool = false
}

protocol FileComparable {
    func numberOfMatchingItems(file: File) -> Int
    
    func percentageOfMatchingItems(file: File) -> Double
    
    func averageNumberOfMatchingItems(folder: Folder) -> Double
    
    func averagePercentageOfMatchingItems(folder: Folder) -> Double
}

extension File: FileComparable {

    func numberOfMatchingItems(file: File) -> Int {
                
        let set1:Set<String> = Set(file.subtitles)
        let set2:Set<String> = Set(self.subtitles)
        
        let difference = set2.intersection(set1)
        
        return difference.count
    }
    
    func percentageOfMatchingItems(file: File) -> Double {
        
        if subtitles.count == 0 || file.subtitles.count == 0 {
            return 0
        }
        
        let selfSet:Set<String> = Set(self.subtitles)
        let fileSet:Set<String> = Set(file.subtitles)
        
        let difference = selfSet.intersection(fileSet).count
        
        return Double(difference)/Double(fileSet.count)
    }
    
    func averageNumberOfMatchingItems(folder: Folder) -> Double {
        
        let folderCount = folder.files.count
        
        if folderCount == 0 {
            return 0.0
        }
        
        let total = folder.files
            .map({ self.numberOfMatchingItems(file: $0)} ).reduce(0, +)
        
        return Double(total)/Double(folderCount)
    }
    
    func averagePercentageOfMatchingItems(folder: Folder) -> Double {
        
        let folderCount = folder.files.count
        
        if folderCount == 0 {
            return 0.0
        }
        
        let total = folder.files
            .map({ self.percentageOfMatchingItems(file: $0)} ).reduce(0, +)
        
        return total/Double(folderCount)
    }
    
}
