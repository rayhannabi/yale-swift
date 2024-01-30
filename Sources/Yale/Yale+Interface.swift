//
//  Yale+Interface.swift
//
//
//  Created by Md. Rayhan Nabi on 10/1/24.
//

import Foundation

extension Yale {

  /// Logs message with trace level.
  /// - Parameters:
  ///   - message: An interpolated log ``Message``.
  ///   - category: ``Category`` to log.
  ///   - metadata: Logger metadata for the log message.
  ///   - file: The filepath where the log originated.
  ///   - line: The line number in a file where the log originated.
  ///   - function: The name of the function where the log originated.
  public static func trace(
    _ message: Message,
    category: Category = .default,
    metadata: Logger.Metadata? = nil,
    file: String = #fileID,
    line: UInt = #line,
    function: String = #function
  ) {
    logger.trace(
      .init(stringLiteral: message.description),
      metadata: metadata,
      source: category.description,
      file: file,
      function: function,
      line: line
    )
  }

  /// Logs message with debug level.
  /// - Parameters:
  ///   - message: An interpolated log ``Message``.
  ///   - category: ``Category`` to log.
  ///   - metadata: Logger metadata for the log message.
  ///   - file: The filepath where the log originated.
  ///   - line: The line number in a file where the log originated.
  ///   - function: The name of the function where the log originated.
  public static func debug(
    _ message: Message,
    category: Category = .default,
    metadata: Logger.Metadata? = nil,
    file: String = #fileID,
    line: UInt = #line,
    function: String = #function
  ) {
    logger.debug(
      .init(stringLiteral: message.description),
      metadata: metadata,
      source: category.description,
      file: file,
      function: function,
      line: line
    )
  }

  /// Logs message with info level.
  /// - Parameters:
  ///   - message: An interpolated log ``Message``.
  ///   - category: ``Category`` to log.
  ///   - metadata: Logger metadata for the log message.
  ///   - file: The filepath where the log originated.
  ///   - line: The line number in a file where the log originated.
  ///   - function: The name of the function where the log originated.
  public static func info(
    _ message: Message,
    category: Category = .default,
    metadata: Logger.Metadata? = nil,
    file: String = #fileID,
    line: UInt = #line,
    function: String = #function
  ) {
    logger.info(
      .init(stringLiteral: message.description),
      metadata: metadata,
      source: category.description,
      file: file,
      function: function,
      line: line
    )
  }

  /// Logs message with notice level.
  /// - Parameters:
  ///   - message: An interpolated log ``Message``.
  ///   - category: ``Category`` to log.
  ///   - metadata: Logger metadata for the log message.
  ///   - file: The filepath where the log originated.
  ///   - line: The line number in a file where the log originated.
  ///   - function: The name of the function where the log originated.
  public static func notice(
    _ message: Message,
    category: Category = .default,
    metadata: Logger.Metadata? = nil,
    file: String = #fileID,
    line: UInt = #line,
    function: String = #function
  ) {
    logger.notice(
      .init(stringLiteral: message.description),
      metadata: metadata,
      source: category.description,
      file: file,
      function: function,
      line: line
    )
  }

  /// Logs message with warning level.
  /// - Parameters:
  ///   - message: An interpolated log ``Message``.
  ///   - category: ``Category`` to log.
  ///   - metadata: Logger metadata for the log message.
  ///   - file: The filepath where the log originated.
  ///   - line: The line number in a file where the log originated.
  ///   - function: The name of the function where the log originated.
  public static func warning(
    _ message: Message,
    category: Category = .default,
    metadata: Logger.Metadata? = nil,
    file: String = #fileID,
    line: UInt = #line,
    function: String = #function
  ) {
    logger.warning(
      .init(stringLiteral: message.description),
      metadata: metadata,
      source: category.description,
      file: file,
      function: function,
      line: line
    )
  }

  /// Logs message with error level.
  /// - Parameters:
  ///   - message: An interpolated log ``Message``.
  ///   - category: ``Category`` to log.
  ///   - metadata: Logger metadata for the log message.
  ///   - file: The filepath where the log originated.
  ///   - line: The line number in a file where the log originated.
  ///   - function: The name of the function where the log originated.
  public static func error(
    _ message: Message,
    category: Category = .default,
    metadata: Logger.Metadata? = nil,
    file: String = #fileID,
    line: UInt = #line,
    function: String = #function
  ) {
    logger.error(
      .init(stringLiteral: message.description),
      metadata: metadata,
      source: category.description,
      file: file,
      function: function,
      line: line
    )
  }

  /// Logs message with critical level.
  /// - Parameters:
  ///   - message: An interpolated log ``Message``.
  ///   - category: ``Category`` to log.
  ///   - metadata: Logger metadata for the log message.
  ///   - file: The filepath where the log originated.
  ///   - line: The line number in a file where the log originated.
  ///   - function: The name of the function where the log originated.
  public static func critical(
    _ message: Message,
    category: Category = .default,
    metadata: Logger.Metadata? = nil,
    file: String = #fileID,
    line: UInt = #line,
    function: String = #function
  ) {
    logger.critical(
      .init(stringLiteral: message.description),
      metadata: metadata,
      source: category.description,
      file: file,
      function: function,
      line: line
    )
  }
}

/// Macro for trace logs.
/// - Parameters:
///   - message: An interpolated log message.
///   - category: Category or source of the log.
///   - metadata: Logger metadata for the log message.
@freestanding(expression)
public macro logTrace(
  _ message: Yale.Message,
  category: Yale.Category = .default,
  metadata: Logger.Metadata? = nil
) = #externalMacro(module: "YaleMacros", type: "YaleLogMacro")

/// Macro for debug logs.
/// - Parameters:
///   - message: An interpolated log message.
///   - category: Category or source of the log.
///   - metadata: Logger metadata for the log message.
@freestanding(expression)
public macro logDebug(
  _ message: Yale.Message,
  category: Yale.Category = .default,
  metadata: Logger.Metadata? = nil
) = #externalMacro(module: "YaleMacros", type: "YaleLogMacro")

/// Macro for info logs.
/// - Parameters:
///   - message: An interpolated log message.
///   - category: Category or source of the log.
///   - metadata: Logger metadata for the log message.
@freestanding(expression)
public macro logInfo(
  _ message: Yale.Message,
  category: Yale.Category = .default,
  metadata: Logger.Metadata? = nil
) = #externalMacro(module: "YaleMacros", type: "YaleLogMacro")

/// Macro for notice logs.
/// - Parameters:
///   - message: An interpolated log message.
///   - category: Category or source of the log.
///   - metadata: Logger metadata for the log message.
@freestanding(expression)
public macro logNotice(
  _ message: Yale.Message,
  category: Yale.Category = .default,
  metadata: Logger.Metadata? = nil
) = #externalMacro(module: "YaleMacros", type: "YaleLogMacro")

/// Macro for warning logs.
/// - Parameters:
///   - message: An interpolated log message..
///   - category: Category or source of the log.
///   - metadata: Logger metadata for the log message.
@freestanding(expression)
public macro logWarning(
  _ message: Yale.Message,
  category: Yale.Category = .default,
  metadata: Logger.Metadata? = nil
) = #externalMacro(module: "YaleMacros", type: "YaleLogMacro")

/// Macro for error logs.
/// - Parameters:
///   - message: An interpolated log  message.
///   - category: Category or source of the log.
///   - metadata: Logger metadata for the log message.
@freestanding(expression)
public macro logError(
  _ message: Yale.Message,
  category: Yale.Category = .default,
  metadata: Logger.Metadata? = nil
) = #externalMacro(module: "YaleMacros", type: "YaleLogMacro")

/// Macro for critical logs.
/// - Parameters:
///   - message: An interpolated log message.
///   - category: Category or source of the log.
///   - metadata: Logger metadata for the log message.
@freestanding(expression)
public macro logCritical(
  _ message: Yale.Message,
  category: Yale.Category = .default,
  metadata: Logger.Metadata? = nil
) = #externalMacro(module: "YaleMacros", type: "YaleLogMacro")
