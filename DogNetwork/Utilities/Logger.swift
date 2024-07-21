//
//  Logger.swift
//  DogNetwork
//
//  Created by talha heybeci on 21.07.2024.
//

import Foundation

public class Logger {
    public static let shared = Logger()
    private var isLoggingEnabled = false
    private var showClassFunctionDetails = false

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

    public func showDetails(_ show: Bool) {
        showClassFunctionDetails = show
    }

    public func logStart() {
        let timestamp = getCurrentTimestamp()
        print("\(timestamp) ---------------------- DOG NETWORK INTERFACE STARTED --------------------------------")
    }

    public func logEnd() {
        let timestamp = getCurrentTimestamp()
        print("\(timestamp) ---------------------- DOG NETWORK INTERFACE ENDED   --------------------------------")
    }

    public func log(message: String, level: LogLevel = .info, file: String = #file, function: String = #function, line: Int = #line, alwaysLog: Bool = false) {
        if alwaysLog || isLoggingEnabled {
            let timestamp = getCurrentTimestamp()
            let fileName = (file as NSString).lastPathComponent
            if showClassFunctionDetails {
                print("\(timestamp) [\(level.rawValue)] \(fileName):\(line) \(function) - \(message)")
            } else {
                print("\(timestamp) [\(level.rawValue)] - \(message)")
            }
        }
    }


    private func getCurrentTimestamp() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        return dateFormatter.string(from: Date())
    }
}
