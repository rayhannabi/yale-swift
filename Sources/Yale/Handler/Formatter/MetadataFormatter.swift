//
//  MetadataFormatter.swift
//
//
//  Created by Md. Rayhan Nabi on 25/1/24.
//

import Foundation
import Logging

/// Describes the logger metadata formatting.
public protocol MetadataFormatter {

  /// Formats the metadata to textual representation
  /// - Parameter metadata: Metadata to format.
  /// - Returns: A textual representation of the metadata.
  func string(from metadata: Logger.Metadata?) -> String?
}

/// Default log metadata formatter.
public struct DefaultMetadataFormatter: MetadataFormatter {
  private let separator: String

  /// Initializes the default metadata formatter.
  /// - Parameter separator: A string value to use as separator in the formatted text.
  public init(separator: String = ",") {
    self.separator = separator
  }

  public func string(from metadata: Logger.Metadata?) -> String? {
    guard let metadata, !metadata.isEmpty else { return nil }
    return metadata.map { "\($0.key)=\($0.value)" }.joined(separator: separator)
  }
}
