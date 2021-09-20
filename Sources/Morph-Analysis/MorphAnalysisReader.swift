//
//
//  Created by Justin White on 20/09/21.
//

import Foundation

struct MorphAnalysis: Codable {
    var version: Int = 0
    
    var items: [String: Double]
}

protocol MorphAnalysisReader {
    func read(file: String) -> MorphAnalysis?
}

class FolderMorphAnalysisReader: MorphAnalysisReader {
    func read(file: String) -> MorphAnalysis? {
        
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
}
