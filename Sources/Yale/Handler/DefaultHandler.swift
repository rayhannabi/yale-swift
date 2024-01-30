//
//  DefaultHandler.swift
//
//
//  Created by Md. Rayhan Nabi on 25/1/24.
//

import Foundation
import Logging

/// Default log handlers.
public struct DefaultHandler {
  let logHandler: LogHandler

  private init(_ logHandler: LogHandler) {
    self.logHandler = logHandler
  }
}

extension DefaultHandler {

  /// Default text output stream handler.
  public static var textStream: DefaultHandler {
    .init(TextStreamLogHandler(logLevel: .info))
  }

  /// Text output stream handler.
  /// - Parameters:
  ///   - stream: Output stream to use. Defaults to ``TextStream/standardOutput``.
  ///   - level: Minimum log level. Defaults to `info`.
  ///   - formatter: A formatter that formats the log message.
  ///   Defaults to ``DefaultLogMessageFormatter``.
  ///   - metadataFormatter: A formatter that formats the logger metadata.
  ///   Defaults to ``DefaultMetadataFormatter``.
  ///   - components: A list of format components.
  ///   - metadata: Metadata for the logger.
  /// - Returns: A default handler object.
  public static func textStream(
    _ stream: TextStream = .standardOutput,
    level: Logger.Level = .info,
    formatter: LogMessageFormatter = DefaultLogMessageFormatter(),
    metadataFormatter: MetadataFormatter = DefaultMetadataFormatter(),
    components: LogMessageFormatComponents = .default,
    metadata: Logger.Metadata = .init()
  ) -> DefaultHandler {
    .init(
      TextStreamLogHandler(
        metadata: metadata,
        logLevel: level,
        formatter: formatter,
        metadataFormatter: metadataFormatter,
        components: components,
        stream: stream
      )
    )
  }
}
