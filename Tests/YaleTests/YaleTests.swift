import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

#if canImport(YaleMacros)
  import YaleMacros

  let testMacros: [String: Macro.Type] = [
    "logTrace": YaleLogMacro.self
  ]
#endif

final class YaleTests: XCTestCase {
  func testMacro() throws {
    #if canImport(YaleMacros)
      assertMacroExpansion(
        #"""
        #logTrace("Hello, \(world)")
        """#,
        expandedSource:
          #"""
          {
            Yale.trace("Hello, \(world)")
            if Yale.useOSLog {
              // log to OSLog
            }
          }()
          """#,
        macros: testMacros
      )
    #else
      throw XCTSkip("macros are only supported when running tests for the host platform")
    #endif
  }
}
