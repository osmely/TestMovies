//
//  Logger.swift
//  Movies
//
//  Created by Osmely Fernandez on 12/27/19.
//  Copyright © 2019 Osmely Fernandez. All rights reserved.
//

import Foundation

class Logger {
  enum Priority : String {
    case verbose = "verbose"
    case warning = "Warning!"
    case error = "ERROR"
  }
  
  private static var dateFormatter:DateFormatter = {
    let df = DateFormatter()
    df.dateFormat = "dd/MM/yyyy HH:mm:ss"
    return df
  }()
  
  static func log(message:String, tag:String? = nil, priority:Logger.Priority = .verbose) {
    #if DEBUG
    let timestamp = dateFormatter.string(from: Date())
    var fullMessage = "[\(timestamp)] || [\(priority.rawValue)]"

    if let tag = tag {
        fullMessage = "\(fullMessage) || [\(tag)]"
    }

    fullMessage = "\(fullMessage)\n\(message)"

    //print(message)
    #endif
  }
}
