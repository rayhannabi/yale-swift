//
//  OSLogMacro.swift
//
//
//  Created by Md. Rayhan Nabi on 9/1/24.
//

import Foundation
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct OSLogMacro: ExpressionMacro {
  public static func expansion(
    of node: some FreestandingMacroExpansionSyntax,
    in context: some MacroExpansionContext
  ) throws -> ExprSyntax {
    return ""
  }
}
