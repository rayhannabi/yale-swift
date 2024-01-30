//
//  LogMessageFormatComponent.swift
//
//
//  Created by Md. Rayhan Nabi on 19/1/24.
//

import Foundation

/// Message components to use in a log  formatter.
public enum LogMessageFormatComponent: Equatable {
  /// The timestamp of the log.
  ///
  /// ## Example
  /// `yyyy-MM-dd'T'HH:mm:ssZ` will produce `2024-01-12T09:43:12+0100`
  ///
  /// - Parameters:
  ///   - format: A `DateTimeFormatter` compatible format text.
  case timestamp(format: String)

  /// Log level description.
  /// - Parameters:
  ///   - text: A boolean value to print the level description.
  ///   - symbol: A boolean value to print the level symbol.
  case level(text: Bool, symbol: Bool)

  /// Source or category of the log.
  case source

  /// The actual log message.
  case message

  /// Metadata associated with the log message.
  case metadata

  /// Name of the file where the log originated.
  /// - Parameters:
  ///   - stripPath: A boolean value for stripping the file path to only filename.
  case file(stripPath: Bool)

  /// Line number of the file where the log originated.
  case line

  /// Parent function where the log originated.
  case function

  /// String literal value.
  /// - Parameters:
  ///   - literal: A string literal that will be inserted while formatting.
  case text(_ literal: String)

  /// A group of format components.
  ///
  /// ### Example
  /// ```swift
  /// ...
  /// .group([
  ///   .text("["),
  ///   .source,
  ///   .text("]"),
  /// ])
  /// ...
  /// ```
  /// This is particularly useful when you need custom formatting.
  /// If the value for ``source`` is `App` then this group will produce `[App]` when formatting
  /// the log message.
  /// - Parameters:
  ///   - components: An array of ``LogMessageFormatComponent`` items.
  case group(_ components: [Self])
}

public typealias LogMessageFormatComponents = [LogMessageFormatComponent]

extension LogMessageFormatComponents {
  /// Default format for logging
  ///
  /// ## Sample
  ///  ```
  ///  2024-01-01T09:43:37.123+0000 ⚠️ WARNING [App] main.swift:13 aFunction() - This is a warning
  ///  ```
  public static var `default`: Self {
    [
      .timestamp(format: "yyyy-MM-dd'T'HH:mm:ss.sssZ"),
      .level(text: true, symbol: true),
      .group([
        .text("["),
        .source,
        .text("]"),
      ]),
      .group([
        .file(stripPath: true),
        .text(":"),
        .line,
      ]),
      .function,
      .text("-"),
      .metadata,
      .message,
    ]
  }

  /// A very compact log format
  ///
  /// ## Sample
  ///  ```
  ///  2024-01-01 09:43:37 ⚠️ This is a warning
  ///  ```
  public static var compact: Self {
    [
      .timestamp(format: "yyyy-MM-dd HH:mm:ss"),
      .level(text: false, symbol: true),
      .metadata,
      .message,
    ]
  }

  /// A format similar to Apple's swift-log `StreamLogHandler` output
  ///
  /// ## Sample
  ///  ```
  ///  2019-03-13T15:46:38+0000 INFO: Hello World!
  ///  ```
  public static var apple: Self {
    [
      .timestamp(format: "yyyy-MM-dd'T'HH:mm:ssZ"),
      .group([
        .level(text: true, symbol: false),
        .text(":"),
      ]),
      .metadata,
      .message,
    ]
  }

  /// Default format for file logging
  ///
  /// ## Sample
  ///  ```
  ///  2024-01-01T09:43:37.123+0000 WARNING [App] - This is a warning
  ///  ```
  public static var file: Self {
    [
      .timestamp(format: "yyyy-MM-dd'T'HH:mm:ss.sssZ"),
      .level(text: true, symbol: false),
      .group([
        .text("["),
        .source,
        .text("]"),
      ]),
      .text("-"),
      .metadata,
      .message,
    ]
  }

  /// Default format for JSON file logging
  ///
  /// ## Sample
  /// Log messages will be formatted using the  following JSON structure -
  ///  ```json
  /// {
  ///   "timestamp": "2024-01-10T09:43:23.567+0000",
  ///   "level": "info",
  ///   "category": "net",
  ///   "file": "Sources/Network/ApiClient.swift",
  ///   "line": 234,
  ///   "function": "submitData(url:method:)",
  ///   "message": "Error occured while processing the request",
  ///   "metadata": {
  ///     "request-id": "432B642B-BF76-4C0E-A36F-D259E2B27E79",
  ///     "error": "403 - Forbidden",
  ///     "http" : {
  ///       "method": "POST",
  ///       "body": {
  ///         "bundle": ["mini", "12"]
  ///       }
  ///     }
  ///   }
  /// }
  ///  ```
  ///  > Note:
  ///  > In log file, the JSON object will be written in a single line without indentations.
  public static var json: Self {
    [
      .timestamp(format: "yyyy-MM-dd'T'HH:mm:ss.sssZ"),
      .level(text: true, symbol: false),
      .source,
      .file(stripPath: false),
      .line,
      .function,
      .metadata,
      .message,
    ]
  }
}
