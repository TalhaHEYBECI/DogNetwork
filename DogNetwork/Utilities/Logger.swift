//
//  Logger.swift
//  DogNetwork
//
//  Created by talha heybeci on 21.07.2024.
//

import Foundation

public class Logger {
    public static let shared = Logger()
    private var isLoggingEnabled = true

    private init() {}

    public enum LogLevel: String {
        case debug = "DEBUG"
        case info = "INFO"
        case warning = "WARNING"
        case error = "ERROR"
    }

    public func enableLogging(_ enable: Bool) {
        isLoggingEnabled = enable
    }

    public func log(message: String, level: LogLevel = .info, file: String = #file, function: String = #function, line: Int = #line) {
        guard isLoggingEnabled else { return }
        let timestamp = getCurrentTimestamp()
        let fileName = (file as NSString).lastPathComponent
        print("\(timestamp) [\(level.rawValue)] \(fileName):\(line) \(function) - \(message)")
    }

    private func getCurrentTimestamp() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        return dateFormatter.string(from: Date())
    }
}
