//
//  PodUnitTests.swift
//  {{NAME}}
//
//  Created by {{AUTHOR}} on {{DAY}}.{{MONTH}}.{{YEAR}}.
//

import XCTest

@testable import {{NAME}}

final class PodUnitTests: XCTestCase {
    func testSample() {
        let sut = PodSample()
        XCTAssertEqual(sut.value, 1)
    }
}
