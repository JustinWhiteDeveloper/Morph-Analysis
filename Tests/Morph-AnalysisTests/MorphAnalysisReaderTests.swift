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
}
