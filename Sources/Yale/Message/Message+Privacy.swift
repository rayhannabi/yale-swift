//
//  Message+Privacy.swift
//
//
//  Created by Md. Rayhan Nabi on 9/1/24.
//

import CryptoKit
import Foundation

// MARK: - Yale.Message.Privacy

extension Yale.Message {

  /// Defines the privacy of the log message items.
  public struct Privacy {
    private var mask: Mask
    private var label: Label
  }
}

// MARK: - Yale.Message.Privacy.Mask

extension Yale.Message.Privacy {

  /// Defines the masking behavior of the private and sensitive log message items.
  public enum Mask {
    /// Generates hash value to use in mask
    case hash
    /// Values are not masked.
    case none
  }
}

// MARK: - Yale.Message.Privacy.Label

extension Yale.Message.Privacy {
  private enum Label {
    case auto
    case `private`
    case `public`
    case sensitive
  }
}

extension Yale.Message.Privacy {

  /// Automatically decide the privacy level. Default is `public`.
  ///
  /// > Note:
  /// > When ``Yale/Yale/useOSLog`` is set to true, this privacy mask acts differently.
  /// > Any custom object will be redacted in `OSLog`.
  /// > See [more](https://developer.apple.com/documentation/os/oslogprivacy/3578094-auto).
  public static var auto: Yale.Message.Privacy { .init(mask: .none, label: .auto) }

  /// Automatically decide the privacy level. Default is `public`.
  /// - Parameter mask: A mask that determines whether to replace a redacted value with a generic string
  /// or a string from a hash of the redacted value.
  /// - Returns: A privacy level with masking behavior.
  public static func auto(mask: Mask) -> Yale.Message.Privacy { .init(mask: mask, label: .auto) }

  /// The standard option to always redact the interpolated value.
  public static var `private`: Self { .init(mask: .none, label: .private) }

  /// Returns a privacy that marks an interpolated value as private, and customizes the display of redacted values.
  /// - Parameter mask: A mask that determines whether to replace a redacted value with a generic string
  /// or a string from a hash of the redacted value.
  /// - Returns: A privacy level with redacted value.
  public static func `private`(mask: Mask) -> Yale.Message.Privacy {
    .init(mask: mask, label: .private)
  }

  /// The option to always redact interpolated values that contain sensitive information.
  public static var sensitive: Self { .init(mask: .none, label: .sensitive) }

  /// Returns a privacy that marks an interpolated value as sensitive, and customizes the display of redacted values.
  /// - Parameter mask: A mask that determines whether to replace a redacted value with a generic string
  /// or a string from a hash of the redacted value.
  /// - Returns: A privacy level that redacts a sensitive value.
  public static func sensitive(mask: Mask) -> Yale.Message.Privacy {
    .init(mask: mask, label: .sensitive)
  }

  /// The standard option to always show the interpolated value.
  public static var `public`: Yale.Message.Privacy { .init(mask: .none, label: .public) }
}

// MARK: - Yale.Message.Privacy + Equatable

extension Yale.Message.Privacy: Equatable {}

// MARK: - Yale.Message.Privacy + ValueFormatting

extension Yale.Message.Privacy: ValueFormatting {
  public typealias Input = String
  public typealias Output = String
  public func format(_ value: String) -> String {
    if Yale.debugMode { return value }

    switch self {
    case let privacy where privacy == .private,
      let privacy where privacy == .private(mask: .none):
      return "<Private>"

    case let privacy where privacy == .sensitive,
      let privacy where privacy == .sensitive(mask: .none):
      return Array(repeating: "*", count: value.count).joined()

    case let privacy where privacy == .auto(mask: .hash),
      let privacy where privacy == .private(mask: .hash),
      let privacy where privacy == .sensitive(mask: .hash):
      let hash = hash(for: value) ?? "-"
      return "<Mask:\(hash)>"

    default:
      return value
    }
  }

  private func hash(for value: String) -> String? {
    guard let data = value.data(using: .utf8) else { return nil }
    let digest = Insecure.MD5.hash(data: data)
    return digest.map { String(format: "%02hhx", $0) }.joined()
  }
}
