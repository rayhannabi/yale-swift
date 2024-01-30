//
//  BooleanFormatTests.swift
//
//
//  Created by Md. Rayhan Nabi on 9/1/24.
//

import XCTest

@testable import Yale

final class BooleanFormatTests: XCTestCase {
  func testTruthFormatting() {
    let fmt = Yale.BooleanFormatting.truth
    XCTAssertEqual(fmt.format(true), "true")
    XCTAssertEqual(fmt.format(false), "false")
  }

  func testAnswerFormatting() {
    let fmt = Yale.BooleanFormatting.answer
    XCTAssertEqual(fmt.format(true), "YES")
    XCTAssertEqual(fmt.format(false), "NO")
  }
}
