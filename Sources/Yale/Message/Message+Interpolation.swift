//
//  Message+Interpolation.swift
//
//
//  Created by Md. Rayhan Nabi on 9/1/24.
//

import Foundation

extension Yale.Message {

  /// Provides string interpolation and additional formatting for the log message.
  public struct StringInterpolation: StringInterpolationProtocol {
    var output = ""

    public init(literalCapacity: Int, interpolationCount: Int) {
      output.reserveCapacity(literalCapacity * 2)
    }

    public mutating func appendLiteral(_ literal: StringLiteralType) {
      output.append(literal)
    }

    /// Appends `Any` value to the interpolated value.
    ///
    /// This method will create debug descriptions by default. Use applicable privacy mask.
    /// - Parameter value: Any value to interpolate.
    public mutating func appendInterpolation(_ value: @autoclosure () -> Any) {
      output.append("\(value())")
    }

    /// Appends any optional value to the interpolated value.
    /// - Parameter value: An `Optional` value.
    public mutating func appendInterpolation<T>(_ value: @autoclosure () -> T?) {
      guard let value = value() else {
        output.append("<Nil>")
        return
      }
      output.append("\(value)")
    }
  }
}
