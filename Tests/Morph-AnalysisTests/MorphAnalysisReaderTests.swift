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
}
