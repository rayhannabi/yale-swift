//
//  YaleMacrosPlugin.swift
//
//
//  Created by Md. Rayhan Nabi on 9/1/24.
//

import Foundation
import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct YalePlugin: CompilerPlugin {
  let providingMacros: [Macro.Type] = [
    YaleLogMacro.self,
    OSLogMacro.self,
  ]
}
