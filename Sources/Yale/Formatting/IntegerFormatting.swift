//
//  IntegerFormatting.swift
//
//
//  Created by Md. Rayhan Nabi on 9/1/24.
//

import Foundation

// MARK: - Yale.IntegerFormatting

extension Yale {

  /// Provides formatting for integer values.
  public struct IntegerFormatting {
    private var base: NumberBase
    private var explicitPositiveSign: Bool
    private var includePrefix: Bool
    private var uppercase: Bool
    private var minDigits: (() -> Int)?
  }
}

// MARK: - Yale.IntegerFormatting.NumberBase

extension Yale.IntegerFormatting {
  private enum NumberBase {
    case decimal
    case octal
    case hexadecimal
  }
}

extension Yale.IntegerFormatting {

  /// Formats integers in Base-10 format.
  public static var decimal: Yale.IntegerFormatting {
    .init(base: .decimal, explicitPositiveSign: false, includePrefix: false, uppercase: false)
  }

  /// Formats integers in Base-10 format.
  /// - Parameter explicitPositiveSign: A boolean value to add an explicit`+` sign, e.g. `+19998`
  /// - Returns: An integer value formatter.
  public static func decimal(explicitPositiveSign: Bool = false) -> Yale.IntegerFormatting {
    .init(
      base: .decimal,
      explicitPositiveSign: explicitPositiveSign,
      includePrefix: false,
      uppercase: false
    )
  }

  /// Formats integers in Base-10 format.
  /// - Parameters:
  ///   - explicitPositiveSign: A boolean value to add an explicit`+` sign, e.g. `+19998`
  ///   - minDigits: Minimum number of digits to show. If this value is greater than the digits in the integer,
  ///   additional `0` will be added before to fill.
  /// - Returns: An integer value formatter.
  public static func decimal(
    explicitPositiveSign: Bool = false,
    minDigits: @autoclosure @escaping () -> Int
  ) -> Yale.IntegerFormatting {
    .init(
      base: .decimal,
      explicitPositiveSign: explicitPositiveSign,
      includePrefix: false,
      uppercase: false,
      minDigits: minDigits
    )
  }

  /// Formats integers in Base-8 format.
  public static var octal: Yale.IntegerFormatting {
    .init(base: .octal, explicitPositiveSign: false, includePrefix: false, uppercase: false)
  }

  /// Formats integers in Base-8 format.
  /// - Parameters:
  ///   - explicitPositiveSign: A boolean value to add an explicit`+` sign, e.g. `+17405`
  ///   - includePrefix: A boolean value to add the `0o` prefix.
  ///   - uppercase: A boolean value to use uppercase letters.
  /// - Returns: An octal integer value formatter.
  public static func octal(
    explicitPositiveSign: Bool = false,
    includePrefix: Bool = false,
    uppercase: Bool = false
  ) -> Yale.IntegerFormatting {
    .init(
      base: .octal,
      explicitPositiveSign: explicitPositiveSign,
      includePrefix: includePrefix,
      uppercase: uppercase
    )
  }

  /// Formats integers in Base-8 format.
  /// - Parameters:
  ///   - explicitPositiveSign: A boolean value to add an explicit`+` sign, e.g. `+17405`
  ///   - includePrefix: A boolean value to add the `0o` prefix.
  ///   - uppercase: A boolean value to use uppercase letters.
  ///   - minDigits: Minimum number of digits to show. If this value is greater than the digits in the integer,
  ///   additional `0` will be added before to fill.
  /// - Returns: An octal integer value formatter.
  public static func octal(
    explicitPositiveSign: Bool = false,
    includePrefix: Bool = false,
    uppercase: Bool = false,
    minDigits: @autoclosure @escaping () -> Int
  ) -> Yale.IntegerFormatting {
    .init(
      base: .octal,
      explicitPositiveSign: explicitPositiveSign,
      includePrefix: includePrefix,
      uppercase: uppercase,
      minDigits: minDigits
    )
  }

  /// Formats integers in Base-16 format.
  public static var hex: Yale.IntegerFormatting {
    .init(base: .hexadecimal, explicitPositiveSign: false, includePrefix: false, uppercase: false)
  }

  /// Formats integers in Base-16 format.
  /// - Parameters:
  ///   - explicitPositiveSign: A boolean value to add an explicit`+` sign, e.g. `+ffad34`
  ///   - includePrefix: A boolean value to add the `0x` prefix.
  ///   - uppercase: A boolean value to use uppercase letters.
  /// - Returns: A hexadecimal integer value formatter.
  public static func hex(
    explicitPositiveSign: Bool = false,
    includePrefix: Bool = false,
    uppercase: Bool = false
  ) -> Yale.IntegerFormatting {
    .init(
      base: .hexadecimal,
      explicitPositiveSign: explicitPositiveSign,
      includePrefix: includePrefix,
      uppercase: uppercase
    )
  }

  /// Formats integers in Base-16 format.
  /// - Parameters:
  ///   - explicitPositiveSign: A boolean value to add an explicit`+` sign, e.g. `+ffad34`
  ///   - includePrefix: A boolean value to add the `0x` prefix.
  ///   - uppercase: A boolean value to use uppercase letters.
  ///   - minDigits: Minimum number of digits to show. If this value is greater than the digits in the integer,
  ///   additional `0` will be added before to fill.
  /// - Returns: A hexadecimal integer value formatter.
  public static func hex(
    explicitPositiveSign: Bool = false,
    includePrefix: Bool = false,
    uppercase: Bool = false,
    minDigits: @autoclosure @escaping () -> Int
  ) -> Yale.IntegerFormatting {
    .init(
      base: .hexadecimal,
      explicitPositiveSign: explicitPositiveSign,
      includePrefix: includePrefix,
      uppercase: uppercase,
      minDigits: minDigits
    )
  }
}

// MARK: - Yale.IntegerFormatting + ValueFormatting

extension Yale.IntegerFormatting: ValueFormatting {
  public typealias Input = (any BinaryInteger)
  public typealias Output = String
  
  public func format(_ value: any BinaryInteger) -> String {
    var stringValue = baseConverted(value)
    if let minDigits = minDigits?(), minDigits > stringValue.count {
      let zeros = Array(repeating: "0", count: minDigits - stringValue.count).joined()
      stringValue = zeros + stringValue
    }
    if (value.signum() as! Int) > -1, explicitPositiveSign {
      stringValue = "+" + stringValue
    }
    if includePrefix {
      stringValue = prefixForBase + stringValue
    }
    return stringValue
  }

  func baseConverted<T>(_ integer: T) -> String where T: BinaryInteger {
    switch base {
    case .decimal:
      String(integer, radix: 10)
    case .hexadecimal:
      String(integer, radix: 16, uppercase: uppercase)
    case .octal:
      String(integer, radix: 8, uppercase: uppercase)
    }
  }

  var prefixForBase: String {
    switch base {
    case .decimal: ""
    case .hexadecimal: "0x"
    case .octal: "0o"
    }
  }
}
