import XCTest
@testable import Morph_Analysis

class MorphAnalysisReaderTests: XCTestCase {

    func testMorphAnalysisReader_ReadMorphAnalysisFile() {
        
        //given
        let path = Bundle.module.path(forResource: "test1", ofType: "morphanalysis")!
        let reader: MorphAnalysisReader = FolderMorphAnalysisReader()
        
        //when
        let value = reader.read(file: path)
        
        //then
        XCTAssertEqual(value?.version, 1)
        XCTAssertEqual(value?.items.count, 1)
        XCTAssertEqual(value?.items["identityTest"], 0.1)
    }
    
    func testMorphAnalysisReader_ReadFromBundleSource() {
        
        //given
        let compareFileSource = Bundle.module.path(forResource: "test2", ofType: "mcb")!

        let sourcePath = Bundle.module.bundlePath + "/contents"
        let reader: MorphAnalysisReader = FolderMorphAnalysisReader()
        
        //when
        let value = reader.readFrom(sourceFolder: sourcePath,
                                    compareFileSource: compareFileSource)
        //then
        XCTAssertEqual(value?.items, ["Resources":1.0])
    }
    
    //If no morphs are matched its highly unlikely so don't count unless its all values are zero
    func testMorphAnalysisReader_ZeroValuesDoNotCountTowardsTotal() {
        
        //given
        let file1 = File(name: "test1", subtitles: ["ありがとう"], success: true)
        let file2 = File(name: "test2", subtitles: [], success: true)
        let compareFile = File(name: "test3", subtitles: ["ありがとう"], success: true)

        let subFolder = Folder(name: "test", files: [file1,file2], success: true, subFolders: [])
        
        let folder = Folder(name: "abcd", files: [], success: true, subFolders: [subFolder])
        
        let reader = FolderMorphAnalysisReader()
        
        //when
        let value = reader.readFrom(resultFolder: folder, compareFile: compareFile)
        
        //then
        XCTAssertEqual(value?.items, ["test":1.0])
    }
    
    //If no morphs are matched its highly unlikely so don't count unless its all values are zero
    func testMorphAnalysisReader_AllZeroValuesInTotal() {
        
        //given
        let file1 = File(name: "test1", subtitles: [], success: true)
        let file2 = File(name: "test2", subtitles: [], success: true)
        let compareFile = File(name: "test3", subtitles: ["ありがとう"], success: true)

        let subFolder = Folder(name: "test", files: [file1,file2], success: true, subFolders: [])
        
        let folder = Folder(name: "abcd", files: [], success: true, subFolders: [subFolder])
        
        let reader = FolderMorphAnalysisReader()
        
        //when
        let value = reader.readFrom(resultFolder: folder, compareFile: compareFile)
        
        //then
        XCTAssertEqual(value?.items, ["test":0.0])
    }
    
    func testMorphAnalysisReader_AnalysisFromMorphFolders() {
        
        //given
        let filePath = Bundle.module.path(forResource: "test2", ofType: "mcb")!
        
        let morphFolder = MorphFolder(morphsAndPoints: ["こんにちは":2,"c":2],
                                      points: 4,
                                      show: "test9")
        
        //when
        let reader = FolderMorphAnalysisReader()

        guard let value = reader.from(folders: [morphFolder], compareFileSource: filePath) else {
            XCTFail("Unable to find files")
            return
        }

        //then
        XCTAssertEqual(value.items, ["test9":0.5])
    }
}
