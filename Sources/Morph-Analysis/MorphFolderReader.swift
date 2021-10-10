//
//  CachedFileReader.swift
//  
//
//  Created by Justin White on 10/10/21.
//

import Foundation

protocol MorphFolderReader {
    func read(folder: Folder) -> MorphFolder

    func read(file: String) -> MorphFolder?
}

class LocalMorphFolderReader: MorphFolderReader {
    
    func read(folder: Folder) -> MorphFolder {
                
        var itemDictionary: [String: Int] = [:]
        
        var pointsTotal = 0
        
        for file in folder.files {
                        
            for subtitle in file.subtitles {
                
                itemDictionary[subtitle] = (itemDictionary[subtitle] ?? 0) + 1
                
                pointsTotal += 1
            }
        }
        
        return MorphFolder(morphsAndPoints: itemDictionary,
                           points: pointsTotal,
                           show: folder.name)
    }
    
    func read(file: String) -> MorphFolder? {
                
        do {
            guard let data = FileManager.default.contents(atPath: file) else {
                return nil
            }
            
            let format = try JSONDecoder().decode(MorphFolder.self, from: data)
            return format
        }
        catch {
            print(error)
            return nil
        }
    }
    
    func readFilesFromFolder(folder: String) -> [MorphFolder] {
             
        var result: [MorphFolder] = []
        
        do {
            let paths = try FileManager.default.contentsOfDirectory(atPath: folder)
            
            let files = paths.filter({$0.pathExtension.isEmpty == false})
                        
            for file in files where file.pathExtension == "che" {
                if let folder = read(file: folder + "/" + file) {
                    result.append(folder)
                }
            }

            return result
        }
        catch {
            return []
        }
    }
}

