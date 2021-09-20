//
//
//  Created by Justin White on 20/09/21.
//

import Foundation

public protocol MorphAnalysisReader {
    func read(file: String) -> MorphAnalysis?
    
    func readFrom(sourceFolder: String, compareFileSource: String) -> MorphAnalysis?
}

public class FolderMorphAnalysisReader: MorphAnalysisReader {
    
    public init() {}
    
    public func read(file: String) -> MorphAnalysis? {
        
        do {
            guard let data = FileManager.default.contents(atPath: file) else {
                return nil
            }
            
            let value = try JSONDecoder().decode(MorphAnalysis.self, from: data)
            return value
        }
        catch {
            print(error)
            return nil
        }
    }
    
    public func readFrom(sourceFolder: String, compareFileSource: String) -> MorphAnalysis? {
        
        let missingFiles = !FileManager.default.fileExists(atPath: sourceFolder) || !FileManager.default.fileExists(atPath: compareFileSource)
        
        if missingFiles {
            return nil
        }

        let fileContainer: FileContainer = LocalFileContainer()
        let compareFile: File = fileContainer.read(file: compareFileSource,
                                                      reader: JapaneseFilteredMcbReader())

        let folderContainer = LocalFolderContainer(reader: McbReader())
        let resultFolder = folderContainer.read(folder: sourceFolder)

        if compareFile.success == false || resultFolder.success == false {
            return nil
        }
        
        var valueMap: [String: Double] = [:]
        
        for folder in resultFolder.subFolders {
            let matchingPercentages = compareFile.averagePercentageOfMatchingItems(folder: folder)

            valueMap[folder.name] = max(0.0,matchingPercentages)
        }
        
        var result = MorphAnalysis()
        result.items = valueMap
        return result
    }
}
