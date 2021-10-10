//
//  MorphFolderWriter.swift
//  
//
//  Created by Justin White on 10/10/21.
//

import Foundation

protocol MorphFolderWriter {
    func write(folder: MorphFolder, location: String)
}

class LocalMorphFolderWriter: MorphFolderWriter {
    func write(folder: MorphFolder, location: String) {
                
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        do {
            let data = try encoder.encode(folder)

            guard let formattedText = String(data: data, encoding: .utf8) else {
                return
            }
            
            try formattedText.write(toFile: location, atomically: true, encoding: .utf8)

        } catch {
            print(error)
        }
    }
}
