//
//
//  Created by Justin White on 20/09/21.
//

import Foundation

public protocol MorphAnalysisWriter {
    func writeFile(destination: String, value: MorphAnalysis)
}

public class FolderMorphAnalysisWriter: MorphAnalysisWriter {
    
    public init() {}
    
    public func writeFile(destination: String, value: MorphAnalysis) {
        let encodedValue = value.description
        
        do {
            try encodedValue.write(toFile: destination, atomically: true, encoding: .utf8)
        }
        catch {
            print(error)
        }
    }
}
