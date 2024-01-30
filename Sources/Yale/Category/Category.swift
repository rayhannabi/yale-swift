//
//  Category.swift
//
//
//  Created by Md. Rayhan Nabi on 10/1/24.
//

import Foundation

// MARK: - Yale.Category

extension Yale {

  /// Defines a log category.
  ///
  /// Category values are used in swift-log's `source` parameter.
  /// More categories can be added via extension.
  public struct Category {

    /// Description of the log category.
    public let description: String
  }
}

// MARK: - Yale.Category + ExpressibleByStringLiteral

extension Yale.Category: ExpressibleByStringLiteral {
  public init(stringLiteral value: StringLiteralType) {
    description = value
  }
}

// MARK: - Yale.Category + CustomStringConvertible

extension Yale.Category: CustomStringConvertible {}
