//
//  ValueFormatting.swift
//
//
//  Created by Md. Rayhan Nabi on 9/1/24.
//

import Foundation

/// A protocol that provides value formatting.
public protocol ValueFormatting {
  /// Any input type to format.
  associatedtype Input
  /// An output type conforming to `StringProtocol`.
  associatedtype Output: StringProtocol

  /// Formats a value to the specified output type.
  /// - Parameter value: A value of ``Input`` type.
  /// - Returns: A value of ``Output`` type.
  func format(_ value: Input) -> Output
}
