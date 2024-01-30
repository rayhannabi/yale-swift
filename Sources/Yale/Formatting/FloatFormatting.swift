//
//  FloatFormatting.swift
//
//
//  Created by Md. Rayhan Nabi on 9/1/24.
//

import Foundation

// MARK: - Yale.FloatFormatting

extension Yale {

  /// Provides formatting for floating point values.
  public struct FloatFormatting {
    private var format: Format
    private var explicitPositiveSign: Bool
    private var uppercase: Bool
    private var precision: (() -> Int)?
  }
}

// MARK: - Yale.FloatFormatting.Format

extension Yale.FloatFormatting {
  private enum Format {
    case fixed
    case exponential
    case hex
    case hybrid
  }
}

extension Yale.FloatFormatting {

  /// Fixed floating point format.
  public static var fixed: Yale.FloatFormatting {
    .init(format: .fixed, explicitPositiveSign: false, uppercase: false)
  }

  /// Fixed floating point format.
  /// - Parameters:
  ///   - explicitPositiveSign: A boolean value for adding an explicit`+` sign, e.g. `+3.1415`
  ///   - uppercase: A boolean value to use uppercase letters, e.g. `3.14E-12`.
  /// - Returns: A floating point formatter.
  public static func fixed(explicitPositiveSign: Bool, uppercase: Bool) -> Yale.FloatFormatting {
    .init(format: .fixed, explicitPositiveSign: explicitPositiveSign, uppercase: uppercase)
  }

  /// Fixed floating point format.
  /// - Parameters:
  ///   - precision: Precision of the value after the decimal point.
  ///   - explicitPositiveSign: A boolean value for adding an explicit`+` sign, e.g. `+3.1415`
  ///   - uppercase: A boolean value to use uppercase letters, e.g. `3.14E-12`.
  /// - Returns: A floating point formatter.
  public static func fixed(
    precision: @autoclosure @escaping () -> Int,
    explicitPositiveSign: Bool,
    uppercase: Bool
  ) -> Yale.FloatFormatting {
    .init(
      format: .fixed,
      explicitPositiveSign: explicitPositiveSign,
      uppercase: uppercase,
      precision: precision
    )
  }

  /// Exponential floating point format.
  public static var exponential: Yale.FloatFormatting {
    .init(format: .fixed, explicitPositiveSign: false, uppercase: false)
  }

  /// Exponential floating point format.
  /// - Parameters:
  ///   - explicitPositiveSign: A boolean value for adding an explicit`+` sign, e.g. `+3.1415e12`
  ///   - uppercase: A boolean value to use uppercase letters, e.g. `3.14E-12`.
  /// - Returns: An exponential floating point formatter.
  public static func exponential(
    explicitPositiveSign: Bool,
    uppercase: Bool
  ) -> Yale.FloatFormatting {
    .init(format: .exponential, explicitPositiveSign: explicitPositiveSign, uppercase: uppercase)
  }

  /// Exponential floating point format.
  /// - Parameters:
  ///   - precision: Precision of the value after the decimal point.
  ///   - explicitPositiveSign: A boolean value for adding an explicit`+` sign, e.g. `+3.1415e12`
  ///   - uppercase: A boolean value to use uppercase letters, e.g. `3.14E-12`.
  /// - Returns: An exponential floating point formatter.
  public static func exponential(
    precision: @autoclosure @escaping () -> Int,
    explicitPositiveSign: Bool,
    uppercase: Bool
  ) -> Yale.FloatFormatting {
    .init(
      format: .exponential,
      explicitPositiveSign: explicitPositiveSign,
      uppercase: uppercase,
      precision: precision
    )
  }

  /// Hexadecimal floating point format.
  ///
  /// ## Example
  /// The value of `Double.pi` will be formatted in
  /// ```
  /// 0x1.921fb54442d18p+1
  /// ```
  public static var hex: Yale.FloatFormatting {
    .init(format: .hex, explicitPositiveSign: false, uppercase: false)
  }

  /// Hexadecimal floating point format.
  /// - Parameters:
  ///   - explicitPositiveSign: A boolean value for adding an explicit`+` sign, e.g. `+0x1.92bfp+1`
  ///   - uppercase: A boolean value to use uppercase letters, e.g. `0X1.92BFP+1`.
  /// - Returns: A hexadecimal floating point formatter.
  public static func hex(explicitPositiveSign: Bool, uppercase: Bool) -> Yale.FloatFormatting {
    .init(format: .hex, explicitPositiveSign: explicitPositiveSign, uppercase: uppercase)
  }

  /// Hexadecimal floating point format.
  /// - Parameters:
  ///   - precision: Precision of the value after the decimal point.
  ///   - explicitPositiveSign: A boolean value for adding an explicit`+` sign, e.g. `+0x1.92bfp+1`
  ///   - uppercase: A boolean value to use uppercase letters, e.g. `0X1.92BFP+1`.
  /// - Returns: A hexadecimal floating point formatter.
  public static func hex(
    precision: @autoclosure @escaping () -> Int,
    explicitPositiveSign: Bool,
    uppercase: Bool
  ) -> Yale.FloatFormatting {
    .init(
      format: .hex,
      explicitPositiveSign: explicitPositiveSign,
      uppercase: uppercase,
      precision: precision
    )
  }

  /// A hybrid floating point format.
  ///
  /// Normally, values will be formatted in the ``fixed`` format. If the value is greater
  /// than `1e22` or less than `1e-22` then it will be formatted in the ``exponential`` format.
  public static var hybrid: Yale.FloatFormatting {
    .init(format: .hybrid, explicitPositiveSign: false, uppercase: false)
  }

  /// A hybrid floating point format.
  /// - Parameters:
  ///   - explicitPositiveSign: A boolean value for adding an explicit`+` sign, e.g. `+3.1415`
  ///   - uppercase: A boolean value to use uppercase letters, e.g. `3.14E-12`.
  /// - Returns: A hybrid floating point formatter.
  public static func hybrid(explicitPositiveSign: Bool, uppercase: Bool) -> Yale.FloatFormatting {
    .init(format: .hybrid, explicitPositiveSign: explicitPositiveSign, uppercase: uppercase)
  }

  /// A hybrid floating point format.
  /// - Parameters:
  ///   - precision: Precision of the value after the decimal point.
  ///   - explicitPositiveSign: A boolean value for adding an explicit`+` sign, e.g. `+3.1415`
  ///   - uppercase: A boolean value to use uppercase letters, e.g. `3.14E-12`.
  /// - Returns: A hybrid floating point formatter.
  public static func hybrid(
    precision: @autoclosure @escaping () -> Int,
    explicitPositiveSign: Bool,
    uppercase: Bool
  ) -> Yale.FloatFormatting {
    .init(
      format: .hybrid,
      explicitPositiveSign: explicitPositiveSign,
      uppercase: uppercase,
      precision: precision
    )
  }
}

// MARK: - Yale.FloatFormatting + ValueFormatting

extension Yale.FloatFormatting: ValueFormatting {
  public typealias Input = (any FloatingPoint)
  public typealias Output = String

  public func format(_ value: any FloatingPoint) -> String {
    switch format {
    case .exponential:
      exponentialFormat(value)
    case .fixed:
      fixedFormat(value)
    case .hex:
      hexFormat(value)
    case .hybrid:
      hybridFormat(value)
    }
  }

  private func fixedFormat(_ value: any FloatingPoint) -> String {
    guard let arg = value as? CVarArg else { return "\(value)" }
    let plusSign = value.sign == .plus && explicitPositiveSign ? "+" : ""
    let uppercased = uppercase ? "\(value)".uppercased() : "\(value)"
    guard let precision else { return "\(plusSign)\(uppercased)" }
    let fmt = uppercase ? "F" : "f"
    return String(format: "\(plusSign)%.\(precision())\(fmt)", arg)
  }

  private func hexFormat(_ value: any FloatingPoint) -> String {
    guard let arg = value as? CVarArg else { return "\(value)" }
    let precision = precision == nil ? "" : ".\(precision!())"
    let fmt = uppercase ? "A" : "a"
    let plusSign = value.sign == .plus && explicitPositiveSign ? "+" : ""
    return String(format: "\(plusSign)%\(precision)\(fmt)", arg)
  }

  private func exponentialFormat(_ value: any FloatingPoint) -> String {
    guard let arg = value as? CVarArg else { return "\(value)" }
    let precision = precision == nil ? "" : ".\(precision!())"
    let fmt = uppercase ? "E" : "e"
    let plusSign = value.sign == .plus && explicitPositiveSign ? "+" : ""
    return String(format: "\(plusSign)%\(precision)\(fmt)", arg)
  }

  private func hybridFormat(_ value: any FloatingPoint) -> String {
    if let doubleValue = value as? Double, doubleValue > 1e22 || doubleValue < 1e-22 {
      return exponentialFormat(value)
    }
    return fixedFormat(value)
  }
}
