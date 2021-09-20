import XCTest
@testable import Morph_Analysis

class MorphAnalysisWriterTests: XCTestCase {

    func testMorphAnalysisWriter_WriteEmptyFormat() {
        //given
        let destination = "test2.morphanalysis"
        
        let writer: MorphAnalysisWriter = FolderMorphAnalysisWriter()
        
        let item = MorphAnalysis()
        
        //when
        writer.writeFile(destination: destination, value: item)
        
        //then
        XCTAssertTrue(FileManager.default.fileExists(atPath: destination))
    }
}
