//
//  FolderContainer.swift
//
//  Created by Justin White on 21/08/21.
//

import Foundation

protocol FolderContainer {
    func read(folder: String) -> Folder
}

class LocalFolderContainer: FolderContainer {
    
    private let container: FileContainer = LocalFileContainer()
    
    private let reader: FileFormatReader
    
    init(reader: FileFormatReader = McbReader()) {
        self.reader = reader
    }
    
    func read(folder: String) -> Folder {
        var result = Folder(name: folder.lastPathComponent)

        do {
            let paths = try FileManager.default.contentsOfDirectory(atPath: folder)
            
            let files = paths.filter({$0.pathExtension.isEmpty == false})
                        
            for file in files where file.pathExtension == reader.fileExtension {
                let file = container.read(file: folder + "/" + file, reader: reader)
                result.files.append(file)
            }
            
            for path in paths where path.pathExtension.isEmpty && !path.starts(with: ".") {
                let innerResult = self.read(folder: folder + "/" + path)
                result.subFolders.append(innerResult)
            }
            
            result.success = true
            return result

        }
        catch {
            print (error)
        }
        
        return result
    }
}

