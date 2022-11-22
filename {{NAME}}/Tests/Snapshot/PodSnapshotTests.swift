//
//  PodSnapshotTests.swift
//  {{NAME}}
//
//  Created by {{AUTHOR}} on {{DAY}}.{{MONTH}}.{{YEAR}}.
//

import SumUpSnapshotTesting
import XCTest

@testable import {{NAME}}

final class PodSnapshotTests: SumUpSnapshotTestCase {
    override func setUp() {
        super.setUp()
        // set to true to update the references images
        recordMode = false
    }

    func testSample() {
        let sut = PodSample()
        XCTAssertEqual(sut.value, 1)
    }
}
