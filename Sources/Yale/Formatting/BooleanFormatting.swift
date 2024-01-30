//
//  BooleanFormatting.swift
//
//
//  Created by Md. Rayhan Nabi on 9/1/24.
//

import Foundation

// MARK: - Yale.BooleanFormatting

extension Yale {
  
  /// Provides boolean formatting.
  public enum BooleanFormatting {
    /// Formats as `true` or `false` value.
    case truth
    /// Formats as `YES` or `NO` value.
    case answer
  }
}

// MARK: - Yale.BooleanFormatting + ValueFormatting

extension Yale.BooleanFormatting: ValueFormatting {
  public typealias Input = Bool
  public typealias Output = String
  
  public func format(_ value: Bool) -> String {
    switch self {
    case .answer: answerFormat(for: value)
    case .truth: truthFormat(for: value)
    }
  }

  private func answerFormat(for value: Bool) -> String {
    switch value {
    case true: "YES"
    case false: "NO"
    }
  }

  private func truthFormat(for value: Bool) -> String {
    switch value {
    case true: "true"
    case false: "false"
    }
  }
}
