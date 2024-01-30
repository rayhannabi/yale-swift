//
//  IntegerFormatTests.swift
//
//
//  Created by Md. Rayhan Nabi on 9/1/24.
//

import XCTest

@testable import Yale

final class IntegerFormatTests: XCTestCase {
  func testPositiveDecimalFormatting() {
    let fmt = Yale.IntegerFormatting.decimal
    let output = fmt.format(123)
    XCTAssertEqual(output, "123")
  }

  func testNegativeDecimalFormatting() {
    let fmt = Yale.IntegerFormatting.decimal()
    let output = fmt.format(-123)
    XCTAssertEqual(output, "-123")
  }

  func testPositiveExplicitDecimalFormatting() {
    let fmt = Yale.IntegerFormatting.decimal(explicitPositiveSign: true)
    var output = fmt.format(123)
    XCTAssertEqual(output, "+123")
    output = fmt.format(-123)
    XCTAssertEqual(output, "-123")
  }

  func testDecimalFormattingMinDigits() {
    let fmt = Yale.IntegerFormatting.decimal(minDigits: 6)
    let output = fmt.format(123)
    XCTAssertEqual(output, "000123")
  }

  func testPositiveHexFormatting() {
    let fmt = Yale.IntegerFormatting.hex
    let output = fmt.format(0x0F)
    XCTAssertEqual(output, "f")
  }

  func testPositiveHexConvertedFormatting() {
    let fmt = Yale.IntegerFormatting.hex
    let output = fmt.format(15)
    XCTAssertEqual(output, "f")
  }

  func testNegativeHexFormatting() {
    let fmt = Yale.IntegerFormatting.hex()
    let output = fmt.format(-15)
    XCTAssertEqual(output, "-f")
  }

  func testPositiveExplicitHexFormatting() {
    let fmt = Yale.IntegerFormatting.hex(explicitPositiveSign: true)
    var output = fmt.format(15)
    XCTAssertEqual(output, "+f")
    output = fmt.format(-15)
    XCTAssertEqual(output, "-f")
  }

  func testHexFormattingPrefix() {
    let fmt = Yale.IntegerFormatting.hex(includePrefix: true)
    let output = fmt.format(15)
    XCTAssertEqual(output, "0xf")
  }

  func testHexFormattingUppercase() {
    let fmt = Yale.IntegerFormatting.hex(uppercase: true)
    let output = fmt.format(255)
    XCTAssertEqual(output, "FF")
  }

  func testHexFormattingMinDigits() {
    let fmt = Yale.IntegerFormatting.hex(minDigits: 6)
    let output = fmt.format(255)
    XCTAssertEqual(output, "0000ff")
  }

  func testPositiveOctalFormatting() {
    let fmt = Yale.IntegerFormatting.octal
    let output = fmt.format(0o17)
    XCTAssertEqual(output, "17")
  }

  func testPositiveOctalConvertedFormatting() {
    let fmt = Yale.IntegerFormatting.octal
    let output = fmt.format(15)
    XCTAssertEqual(output, "17")
  }

  func testNegativeOctalFormatting() {
    let fmt = Yale.IntegerFormatting.octal()
    let output = fmt.format(-15)
    XCTAssertEqual(output, "-17")
  }

  func testPositiveExplicitOctalFormatting() {
    let fmt = Yale.IntegerFormatting.octal(explicitPositiveSign: true)
    var output = fmt.format(15)
    XCTAssertEqual(output, "+17")
    output = fmt.format(-15)
    XCTAssertEqual(output, "-17")
  }

  func testOctalFormattingPrefix() {
    let fmt = Yale.IntegerFormatting.octal(includePrefix: true)
    let output = fmt.format(15)
    XCTAssertEqual(output, "0o17")
  }

  func testOctalFormattingUppercase() {
    let fmt = Yale.IntegerFormatting.octal(uppercase: true)
    let output = fmt.format(255)
    XCTAssertEqual(output, "377")
  }

  func testOctalFormattingMinDigits() {
    let fmt = Yale.IntegerFormatting.octal(minDigits: 4)
    let output = fmt.format(255)
    XCTAssertEqual(output, "0377")
  }
}
