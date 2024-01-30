@_exported import Logging

// MARK: - Yale

/// The Yale log interface.
public enum Yale {}

extension Yale {

  /// Determines whether logging is enabled.
  public static var enabled = true

  /// Sets the label for logging.
  public static var label = "com.rayhannabi.yale" {
    didSet { logger = Logger(label: label) }
  }

  /// Subsystem for OSLog. Defaults to label's value.
  public static var subsystem = label

  /// Determines whether to use `OSLog` for logging alongside swift-log handlers.
  public static var useOSLog = true

  /// A `Logger` object to use with swift-log.
  public static var logger = Logger(label: label)

  /// Bootstraps the logging system with provided default handlers.
  /// - Parameter defaultHandlers: An array of ``DefaultHandler`` to use.
  /// - Warning: Any bootstrap method may only be called once.
  /// Mutiple calls will result in unknown state and may crash.
  public static func bootstrap(_ defaultHandlers: [DefaultHandler]) {
    guard !defaultHandlers.isEmpty else { return }
    LoggingSystem.bootstrap { _ in
      guard enabled else {
        return SwiftLogNoOpLogHandler()
      }
      if defaultHandlers.count == 1, let defaultHandler = defaultHandlers.first {
        return defaultHandler.logHandler
      }
      return MultiplexLogHandler(defaultHandlers.map(\.logHandler))
    }
  }

  /// Bootstraps the logging system with swift-log's LogHandler backends.
  /// - Parameter factory: A closure that given a Logger identifier, produces an instance of the LogHandler.
  /// - Warning: Any bootstrap method may only be called once.
  /// Mutiple calls will result in unknown state and may crash.
  public static func bootstrap(_ factory: @escaping (String) -> LogHandler) {
    LoggingSystem.bootstrap(factory)
  }

  /// Bootstraps the logging system with swift-log's LogHandler backends and metadata providers
  /// - Parameters:
  ///   - factory: A closure that given a Logger identifier and metadata provider,
  ///   produces an instance of the LogHandler.
  ///   - metadataProvider: The MetadataProvider used to inject runtime-generated
  ///   metadata from the execution context.
  /// - Warning: Any bootstrap method may only be called once.
  /// Mutiple calls will result in unknown state and may crash.
  public static func bootstrap(
    _ factory: @escaping (String, Logger.MetadataProvider?) -> LogHandler,
    metadataProvider: Logger.MetadataProvider?
  ) {
    LoggingSystem.bootstrap(factory, metadataProvider: metadataProvider)
  }
}

extension Yale {
  #if DEBUG
    static var debugMode = true
  #else
    static var debugMode = false
  #endif
}
