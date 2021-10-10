//
//  MorphFolderTests.swift
//  
//
//  Created by Justin White on 10/10/21.
//

import XCTest
@testable import Morph_Analysis

class MorphFolderTests: XCTestCase {

    func testMorphFolderFullPointsCalculation() throws {
        //given
        let morphFolder = MorphFolder(morphsAndPoints: ["a":2], points: 2, show: "test")
        
        //when
        let points = morphFolder.score(knownValues: ["a"])
        
        //then
        XCTAssertEqual(1, points)
    }
    
    func testMorphFolderHalfPointsCalculation() throws {
        //given
        let morphFolder = MorphFolder(morphsAndPoints: ["a":2,"b":2,"c":2,"d":2], points: 8, show: "test2")
        
        //when
        let points = morphFolder.score(knownValues: ["a","d"])
        
        //then
        XCTAssertEqual(0.5, points)
    }
    
    func testMorphFolderThirdPointsCalculation() throws {
        //given
        let morphFolder = MorphFolder(morphsAndPoints: ["a":2,"c":2,"d":2], points: 6, show: "test3")
        
        //when
        let points = morphFolder.score(knownValues: ["c"])
        
        //then
        XCTAssertEqual("0.33", String(format:"%.2f", points))
    }
    
    func testMorphFolderZeroPointsCalculation() throws {
        //given
        let morphFolder = MorphFolder(morphsAndPoints: ["a":2,"c":2,"d":2], points: 6, show: "test4")
        
        //when
        let points = morphFolder.score(knownValues: [])
        
        //then
        XCTAssertEqual(0, points)
    }
    
    
    func testMorphFolderZeroValuesShouldReturnZero() throws {
        //given
        let morphFolder = MorphFolder(morphsAndPoints: [:], points: 0, show: "test5")
        
        //when
        let points = morphFolder.score(knownValues: [])
        
        //then
        XCTAssertEqual(0, points)
    }
    
    func testMorphFolderFromReadFolder() throws {
        //given
        guard let filePath = Bundle.module.path(forResource: "test2",
                                         ofType: "mcb") else {
            XCTFail("Unable to find file")
            return
        }
        
        guard let folderPath = Bundle.module.path(forResource: "test3",
                                         ofType: "che") else {
            XCTFail("Unable to find file")
            return
        }
        
        let folderReader = LocalMorphFolderReader()
        
        let reader = McbReader()
        let compareList: [String] = reader.getSubtitles(file: filePath)

        //when
        let morphFolder = folderReader.read(file: folderPath)
        
        guard let morphFolder = morphFolder else {
            XCTFail("Unable to find file")
            return
        }
        
        let points = morphFolder.score(knownValues: compareList)
        
        //then
        XCTAssertEqual(1, morphFolder.version)
        XCTAssertEqual("天", morphFolder.show)
        XCTAssertEqual("0.00048", String(format:"%.5f",points))
    }
    
    func testMorphFolderFromReadFolderSource() throws {
        
        //given
        guard let folderPath = Bundle.module.resourcePath else {
            XCTFail("Unable to find file")
            return
        }
        
        let folderReader = LocalMorphFolderReader()
    
        //when
        let morphFolder = folderReader.readFilesFromFolder(folder: folderPath)
                
        //then
        XCTAssertEqual(1, morphFolder.count)
        XCTAssertEqual(2592, morphFolder[0].morphsAndPoints.count)
        XCTAssertEqual(6248,morphFolder[0].points)
        XCTAssertEqual(1, morphFolder[0].version)
    }
}
