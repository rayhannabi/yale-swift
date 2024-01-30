//
//  LogMessageFormatter.swift
//
//
//  Created by Md. Rayhan Nabi on 19/1/24.
//

import Foundation
import Logging

/// Describes the log message formatter.
public protocol LogMessageFormatter {

  /// A `DateTime` formatter to generate timestamp.
  var timestampFormatter: DateFormatter { get }

  /// Formats the log message with specified components.
  /// - Parameters:
  ///   - components: A list of components to include in the log message.
  ///   - level: Log level of the message.
  ///   - source: Source or category of the message.
  ///   - date: Specifies a date that will be used as timestamp for the log message.
  ///   - message: The message to log.
  ///   - metadata: The metadata dictionary associated with the log message.
  ///   - file: Name of the file where the log originated.
  ///   - line: Line number in the file where the log originated.
  ///   - function: Name of the function where the log originated,
  /// - Returns: Formatted log message.
  func string(
    with components: [LogMessageFormatComponent],
    level: Logger.Level,
    source: String,
    date: Date,
    message: String,
    metadata: String,
    file: String,
    line: UInt,
    function: String
  ) -> String
}

/// Default text log message formatter.
public struct DefaultLogMessageFormatter: LogMessageFormatter {
  public let timestampFormatter: DateFormatter
  private let separator: String

  /// Initializes the default log message formatter.
  /// - Parameter separator: A separator text to use between components.
  public init(separator: String = " ") {
    self.separator = separator
    timestampFormatter = .init()
  }

  public func string(
    with components: [LogMessageFormatComponent],
    level: Logger.Level,
    source: String,
    date: Date,
    message: String,
    metadata: String,
    file: String,
    line: UInt,
    function: String
  ) -> String {
    let date = Date()
    return
      components.map {
        formatComponent(
          $0,
          level: level,
          source: source,
          date: date,
          message: message,
          metadata: metadata,
          file: file,
          line: line,
          function: function
        )
      }
      .joined(separator: separator)
  }
}

extension DefaultLogMessageFormatter {

  /// A closure that maps the `Logger.Level` to emoji symbols.
  public static var levelSymbols: (Logger.Level) -> String = {
    switch $0 {
    case .trace: "🔍"
    case .debug: "🪲"
    case .info: "ℹ️"
    case .notice: "🔔"
    case .warning: "⚠️"
    case .error: "❌"
    case .critical: "🚨"
    }
  }

  /// A closure that maps the `Logger.Level` description.
  public static var levelDescription: (Logger.Level) -> String = {
    $0.rawValue.uppercased()
  }
}

extension DefaultLogMessageFormatter {
  private func timestamp(_ date: Date, format: String) -> String {
    timestampFormatter.dateFormat = format
    return timestampFormatter.string(from: date)
  }

  private func logLevel(_ level: Logger.Level, showsText: Bool, showsSymbol: Bool) -> String {
    var output = ""
    if showsSymbol {
      let symbol = DefaultLogMessageFormatter.levelSymbols(level)
      output.append(symbol)
    }
    if showsText {
      output.append(" ")
      output.append(DefaultLogMessageFormatter.levelDescription(level))
    }
    return output.trimmingCharacters(in: .whitespaces)
  }

  private func filename(_ name: String, stripPath: Bool) -> String {
    guard let filename = name.split(separator: "/").last else { return name }
    return String(filename)
  }

  private func formatComponent(
    _ component: LogMessageFormatComponent,
    level: Logger.Level,
    source: String,
    date: Date,
    message: String,
    metadata: String,
    file: String,
    line: UInt,
    function: String
  ) -> String {
    switch component {
    case .timestamp(let format):
      timestamp(date, format: format)
    case .level(let text, let symbol):
      logLevel(level, showsText: text, showsSymbol: symbol)
    case .source:
      source
    case .message:
      message
    case .metadata:
      metadata
    case .file(let stripPath):
      filename(file, stripPath: stripPath)
    case .line:
      "\(line)"
    case .function:
      function
    case .text(let value):
      value
    case .group(let components):
      components.map {
        formatComponent(
          $0,
          level: level,
          source: source,
          date: date,
          message: message,
          metadata: metadata,
          file: file,
          line: line,
          function: function
        )
      }
      .joined()
      .trimmingCharacters(in: .whitespaces)
    }
  }
}
