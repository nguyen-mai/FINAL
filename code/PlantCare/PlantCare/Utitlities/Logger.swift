import Foundation

enum LogLevel: String {
    case info       = "🔵"
    case debug      = "🟡"
    case warning    = "🟠"
    case error      = "🔴"
    case server     = "🟢"
    case http       = "⚫️"
}

/// Override print function to avoid print function working in production mode
func print(_ object: Any) {
    // Only allowing in DEBUG mode
    #if DEBUG
    if object is [Any] {
        dump(object)
    } else {
        Swift.print(object)
    }
    #endif
}

final class Logger {
    private static var isLogEnable: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }

    private class func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")

        if let componentLast = components.last {
            return componentLast
        } else {
            return ""
        }
    }
}

extension Logger {
    class func http(filename: String = #file,
                    line: Int = #line,
                    column: Int = #column,
                    funcName: String = #function,
                    _ objects: Any...) {
        if isLogEnable {
            print("\(LogLevel.http.rawValue) HTTPS [[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName)]")
            for logInfo in objects {
                if logInfo is [Any] {
                    dump(logInfo)
                } else if logInfo is URLRequest, let request = logInfo as? URLRequest {
                    let urlAsString = request.url?.absoluteString ?? ""
                    let urlComponents = NSURLComponents(string: urlAsString)

                    let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
                    let path = "\(urlComponents?.path ?? "")"
                    let query = "\(urlComponents?.query ?? "")"
                    let host = "\(urlComponents?.host ?? "")"

                    var logOutput = """
                                    \(urlAsString) \n\n
                                    \(method) \(path)?\(query) HTTPS/1.1 \n
                                    HOST: \(host)\n
                                    """
                    for (key, value) in request.allHTTPHeaderFields ?? [:] {
                        logOutput += "\(key): \(value) \n"
                    }
                    if let body = request.httpBody {
                        logOutput += "\n \(NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "")"
                    }

                    print(logOutput)
                } else {
                    print(logInfo)
                }
            }
        }
    }

    class func server(filename: String = #file,
                      line: Int = #line,
                      column: Int = #column,
                      funcName: String = #function,
                      _ objects: Any...) {
        if isLogEnable {
            print("\(LogLevel.server.rawValue) SERVER [[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName)]")
            for logInfo in objects {
                if logInfo is [Any] {
                    dump(logInfo)
                } else {
                    print(logInfo)
                }
            }
        }
    }

    class func error(filename: String = #file,
                     line: Int = #line,
                     column: Int = #column,
                     funcName: String = #function,
                     _ objects: Any...) {
        if isLogEnable {
            print("\(LogLevel.error.rawValue) ERROR [[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName)]")
            for logInfo in objects {
                if logInfo is [Any] {
                    dump(logInfo)
                } else {
                    print(logInfo)
                }
            }
        }
    }

    class func warning(filename: String = #file,
                       line: Int = #line,
                       column: Int = #column,
                       funcName: String = #function,
                       _ objects: Any...) {
        if isLogEnable {
            print("\(LogLevel.warning.rawValue) WARNING [[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName)]")
            for logInfo in objects {
                if logInfo is [Any] {
                    dump(logInfo)
                } else {
                    print(logInfo)
                }
            }
        }
    }

    class func debug(filename: String = #file,
                     line: Int = #line,
                     column: Int = #column,
                     funcName: String = #function,
                     _ objects: Any...) {
        if isLogEnable {
            print("\(LogLevel.debug.rawValue) DEBUG [[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName)]")
            for logInfo in objects {
                if logInfo is [Any] {
                    dump(logInfo)
                } else {
                    print(logInfo)
                }
            }
        }
    }

    class func info(filename: String = #file,
                    line: Int = #line,
                    column: Int = #column,
                    funcName: String = #function,
                    _ objects: Any...) {
        if isLogEnable {
            print("\(LogLevel.info.rawValue) INFO [[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName)]")
            for logInfo in objects {
                if logInfo is [Any] {
                    dump(logInfo)
                } else {
                    print(logInfo)
                }
            }
        }
    }
}

