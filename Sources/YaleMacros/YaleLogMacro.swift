import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

/// Macro for  Yale logger
///
/// ## Example
/// ```swift
/// #logInfo("Hello, \(world)", category: .app)
/// ```
public struct YaleLogMacro: ExpressionMacro {
  public static func expansion(
    of node: some FreestandingMacroExpansionSyntax,
    in context: some MacroExpansionContext
  ) throws -> ExprSyntax {
    guard node.argumentList.count >= 1 else {
      throw YaleMacroError.missingArguments
    }

    let macroName = node.macro.text
    guard macroName.contains("log") else { throw YaleMacroError.invalidMacroName }
    let methodName = String(macroName.dropFirst(3)).lowercased()
    let logMethodNames = ["trace", "debug", "info", "notice", "warning", "error", "critical"]
    guard logMethodNames.contains(methodName) else { throw YaleMacroError.invalidMacroName }

    return """
      {
        Yale.\(raw: methodName)(\(node.argumentList))
        if Yale.useOSLog {
          // log to OSLog
        }
      }()
      """
  }
}

enum YaleMacroError: Error, CustomStringConvertible {
  case missingArguments
  case invalidMacroName

  var description: String {
    switch self {
    case .missingArguments: "Required arguments are missing"
    case .invalidMacroName: "Macro name does not correspond to any logging method"
    }
  }
}
