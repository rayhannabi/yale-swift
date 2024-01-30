//
//  Message.swift
//
//
//  Created by Md. Rayhan Nabi on 9/1/24.
//

import Foundation

// MARK: - Yale.Message

extension Yale {

  /// Defines a log message.
  public struct Message {
    private var content: String
  }
}

// MARK: - Yale.Message + CustomStringConvertible

extension Yale.Message: CustomStringConvertible {
  public var description: String { content }
}

// MARK: - Yale.Message + ExpressibleByStringLiteral

extension Yale.Message: ExpressibleByStringLiteral {
  public init(stringLiteral value: StringLiteralType) {
    content = value
  }
}

// MARK: - Yale.Message + ExpressibleByStringInterpolation

extension Yale.Message: ExpressibleByStringInterpolation {
  public init(stringInterpolation: StringInterpolation) {
    content = stringInterpolation.output
  }
}
