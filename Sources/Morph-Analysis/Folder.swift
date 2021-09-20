//
//  Folder.swift
//  
//
//  Created by Justin White on 20/09/21.
//

import Foundation

struct Folder {
    let name: String
    
    var files: [File] = []
    
    var fileCount: Int = 0
    
    var success: Bool = false
    
    var subFolders: [Folder] = []
}
