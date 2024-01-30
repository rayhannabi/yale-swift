//
//  TextStream.swift
//
//
//  Created by Md. Rayhan Nabi on 19/1/24.
//

import Darwin

/// Defines the log text output stream.
public enum TextStream {
  /// The standard output stream a.k.a `stdout`.
  case standardOutput
  /// The standard error stream a.k.a `stderr`.
  case standardError
}

extension TextStream: TextOutputStream {
  public func write(_ string: String) {
    switch self {
    case .standardError:
      fputs("\(string)\n", stderr)
    case .standardOutput:
      fputs("\(string)\n", stdout)
    }
  }
}
