//
//  SampleAppSnapshotTests.swift
//  {{NAME}}SnapshotTests
//
//  Created by {{AUTHOR}} on {{DAY}}.{{MONTH}}.{{YEAR}}.
//

import SumUpSnapshotTesting
import XCTest

class SampleAppSnapshotTests: SumUpSnapshotTestCase {
    override func setUp() {
        super.setUp()
        // set to true to update the references images
        recordMode = false
    }

    func testSample() {
        XCTAssertTrue(true)
    }
}
