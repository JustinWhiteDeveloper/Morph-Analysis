//
//  FileContainer.swift
//  
//
//  Created by Justin White on 20/09/21.
//

import Foundation

protocol FileContainer {
    func read(file: String, reader: FileFormatReader) -> File
}

class LocalFileContainer: FileContainer {
    func read(file: String, reader: FileFormatReader) -> File {
        
        var result = File(name: file.lastPathComponent)
        result.subtitles = reader.getSubtitles(file: file, encoding: .utf8)
        result.success = true
        return result
    }
}
