//
//  TextStreamLogHandler.swift
//
//
//  Created by Md. Rayhan Nabi on 25/1/24.
//

import Foundation
import Logging

/// A swift-log backend for text output.
public struct TextStreamLogHandler: LogHandler {
  public subscript(metadataKey key: String) -> Logger.Metadata.Value? {
    get { metadata[key] }
    set(newValue) { metadata[key] = newValue }
  }

  public var metadata: Logger.Metadata { didSet { generatePrettyMetadata() } }
  public var logLevel: Logger.Level

  /// Formatter for the log message.
  public let formatter: LogMessageFormatter

  /// Formatter for the logger metadata.
  public let metadataFormatter: MetadataFormatter

  /// Components to use in formatting the log message.
  public let components: [LogMessageFormatComponent]

  /// Text output stream that is used to print the logs.
  public let stream: TextStream

  private var prettyMetadata: String?

  /// Initializes the text stream log handler.
  /// - Parameters:
  ///   - metadata: Metadata for the logger. Defaults to empty dictionary.
  ///   - logLevel: Minimum log level for the logger.
  ///   - formatter: A ``LogMessageFormatter`` object that is used to format log message.
  ///   Defaults to ``DefaultLogMessageFormatter``.
  ///   - metadataFormatter: A ``MetadataFormatter`` object that is used to format the logger metadata.
  ///   Defaults to ``DefaultMetadataFormatter``.
  ///   - components: A list of ``LogMessageFormatComponent`` to include in the formatted message.
  ///   Available options are `default`, `compact`, `apple` and `json`.
  ///   - stream: Text output stream to use to print the logs.
  public init(
    metadata: Logger.Metadata = .init(),
    logLevel: Logger.Level,
    formatter: LogMessageFormatter = DefaultLogMessageFormatter(),
    metadataFormatter: MetadataFormatter = DefaultMetadataFormatter(),
    components: LogMessageFormatComponents = .default,
    stream: TextStream = .standardOutput
  ) {
    self.metadata = metadata
    self.logLevel = logLevel
    self.formatter = formatter
    self.metadataFormatter = metadataFormatter
    self.components = components
    self.stream = stream
  }

  public func log(
    level: Logger.Level,
    message: Logger.Message,
    metadata: Logger.Metadata?,
    source: String,
    file: String,
    function: String,
    line: UInt
  ) {
    let processedMetadataString = processMetadata(metadata)
    let formattedMesssage = formatter.string(
      with: components,
      level: level,
      source: source,
      date: Date(),
      message: message.description,
      metadata: processedMetadataString,
      file: file,
      line: line,
      function: function
    )
    stream.write(formattedMesssage)
  }

  private mutating func generatePrettyMetadata() {
    self.prettyMetadata = metadataFormatter.string(from: self.metadata)
  }

  private func processMetadata(_ metadata: Logger.Metadata?) -> String {
    guard let metadata, !metadata.isEmpty else { return self.prettyMetadata ?? "" }
    let mergedMetadata = self.metadata.merging(metadata) { _, new in new }
    return metadataFormatter.string(from: mergedMetadata) ?? ""
  }
}
