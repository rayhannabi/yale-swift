//
//  Message+StringAlignment.swift
//
//
//  Created by Md. Rayhan Nabi on 9/1/24.
//

import Foundation

// MARK: - Yale.Message.StringAlignment

extension Yale.Message {

  /// The alignment options for interpolated strings.
  enum StringAlignment {

    /// Aligns the value on the left side of a column with the specified width.
    /// - Parameters:
    ///   - columns: The width of the item in characters.
    case left(columns: Int)

    /// Aligns the value on the right side of a column with the specified width.
    /// - Parameters:
    ///   - columns: The width of the item in characters.
    case right(columns: Int)

    /// No alignment.
    case none
  }
}

// MARK: - Yale.Message.StringAlignment + ValueFormatting

extension Yale.Message.StringAlignment: ValueFormatting {
  public func format(_ value: String) -> String {
    switch self {
    case let .left(columns):
      return leftPad(value, columns: columns)
    case let .right(columns):
      return rightPad(value, columns: columns)
    case .none:
      return value
    }
  }

  private func leftPad(_ value: String, columns: Int) -> String {
    guard let spaces = spaces(for: value, columns: columns) else { return value }
    return value + spaces
  }

  private func rightPad(_ value: String, columns: Int) -> String {
    guard let spaces = spaces(for: value, columns: columns) else { return value }
    return spaces + value
  }

  private func spaces(for value: String, columns: Int) -> String? {
    if value.count >= columns { return nil }
    return Array(repeating: " ", count: columns - value.count).joined()
  }
}
