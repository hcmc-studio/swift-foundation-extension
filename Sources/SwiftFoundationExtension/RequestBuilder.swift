//
//  RequestBuilder.swift
//
//
//  Created by Ji-Hwan Kim on 11/6/23.
//

import Foundation
import Combine
import Logging

public struct RequestBuilder {
    public var session: URLSession
    public var url: URL
    public var method: HttpMethod!
    public var headers: [String : String?]
    public var body: Data?
    public var logger: Logger?
    
    public init(
        session: URLSession = .shared,
        url: URL,
        method: HttpMethod? = nil,
        headers: [String : String?] = [:],
        body: Data? = nil,
        logger: Logger? = nil
    ) {
        self.session = session
        self.url = url
        if let method = method {
            self.method = method
        }
        self.headers = headers
        self.logger = logger
    }
    
    public init(
        overriding from: RequestBuilder,
        session: URLSession? = nil,
        url: URL? = nil,
        method: HttpMethod? = nil,
        headers: [String : String?]? = nil,
        body: Data? = nil,
        logger: Logger? = nil
    ) {
        self.session = session ?? from.session
        self.url = url ?? from.url
        self.method = method ?? from.method
        self.headers = headers ?? from.headers
        self.body = body ?? from.body
        self.logger = logger ?? from.logger
    }
}

extension RequestBuilder {
    public mutating func set(session: URLSession) {
        self.session = session
    }
    
    public mutating func set(url: URL) {
        self.url = url
    }
    
    @available(macOS 13.0, *)
    @available(iOS 16.0, *)
    public mutating func append(urlComponent component: any StringProtocol, directoryHint: URL.DirectoryHint = .inferFromPath) {
        self.url.append(component: component, directoryHint: directoryHint)
    }
    
    @available(macOS 13.0, *)
    @available(iOS 16.0, *)
    public mutating func append(urlPath path: any StringProtocol, directoryHint: URL.DirectoryHint = .inferFromPath) {
        self.url.append(path: path, directoryHint: directoryHint)
    }
    
    @available(macOS 13.0, *)
    @available(iOS 16.0, *)
    public mutating func append(urlQueryItems queryItems: [URLQueryItem]) {
        self.url.append(queryItems: queryItems)
    }
    
    @available(macOS, introduced: 10.10, deprecated: 100000.0, message: "Use append(path:directoryHint:) instead")
    @available(iOS, introduced: 8.0, deprecated: 100000.0, message: "Use append(path:directoryHint:) instead")
    @available(tvOS, introduced: 9.0, deprecated: 100000.0, message: "Use append(path:directoryHint:) instead")
    @available(watchOS, introduced: 2.0, deprecated: 100000.0, message: "Use append(path:directoryHint:) instead")
    public mutating func append(urlPathComponent pathComponent: String) {
        self.url.appendPathComponent(pathComponent)
    }
    
    @available(macOS, introduced: 10.10, deprecated: 100000.0, message: "Use append(path:directoryHint:) instead")
    @available(iOS, introduced: 8.0, deprecated: 100000.0, message: "Use append(path:directoryHint:) instead")
    @available(tvOS, introduced: 9.0, deprecated: 100000.0, message: "Use append(path:directoryHint:) instead")
    @available(watchOS, introduced: 2.0, deprecated: 100000.0, message: "Use append(path:directoryHint:) instead")
    public mutating func append(urlPathComponent pathComponent: String, isDirectory: Bool) {
        self.url.appendPathComponent(pathComponent, isDirectory: isDirectory)
    }
    
    public mutating func set(method: HttpMethod) {
        self.method = method
    }
    
    public mutating func set(header name: String, value: String?) {
        self.headers[name] = value
    }
    
    public mutating func set(header: HttpHeader, value: String?) {
        self.headers[header.rawValue] = value
    }
    
    public mutating func set(body: Data?) {
        self.body = body
    }
    
    @available(macOS 13.0, *)
    @available(iOS 13.0, *)
    public mutating func set<Body, TEncoder>(body: Body?, encoder: TEncoder) throws where Body : Encodable, TEncoder : TopLevelEncoder, TEncoder.Output == Data {
        guard let body = body else {
            self.body = nil
            return
        }
        
        self.body = try encoder.encode(body)
    }
}

extension RequestBuilder {
    public func setting(session: URLSession) -> RequestBuilder {
        var s = self
        s.set(session: session)
        
        return s
    }
    
    public func setting(url: URL) -> RequestBuilder {
        var s = self
        s.set(url: url)
        
        return s
    }
    
    @available(macOS 13.0, *)
    @available(iOS 16.0, *)
    public func appending(urlComponent component: any StringProtocol, directoryHint: URL.DirectoryHint = .inferFromPath) -> RequestBuilder {
        var s = self
        s.append(urlComponent: component, directoryHint: directoryHint)
        
        return s
    }
    
    @available(macOS 13.0, *)
    @available(iOS 16.0, *)
    public func appending(urlPath path: any StringProtocol, directoryHint: URL.DirectoryHint = .inferFromPath) -> RequestBuilder {
        var s = self
        s.append(urlPath: path, directoryHint: directoryHint)
        
        return s
    }
    
    @available(macOS 13.0, *)
    @available(iOS 16.0, *)
    public func appending(urlQueryItems queryItems: [URLQueryItem]) -> RequestBuilder {
        var s = self
        s.append(urlQueryItems: queryItems)
        
        return s
    }
    
    @available(macOS, introduced: 10.10, deprecated: 100000.0, message: "Use append(path:directoryHint:) instead")
    @available(iOS, introduced: 8.0, deprecated: 100000.0, message: "Use append(path:directoryHint:) instead")
    @available(tvOS, introduced: 9.0, deprecated: 100000.0, message: "Use append(path:directoryHint:) instead")
    @available(watchOS, introduced: 2.0, deprecated: 100000.0, message: "Use append(path:directoryHint:) instead")
    public func appending(urlPathComponent pathComponent: String) -> RequestBuilder {
        var s = self
        s.append(urlPathComponent: pathComponent)
        
        return s
    }
    
    @available(macOS, introduced: 10.10, deprecated: 100000.0, message: "Use append(path:directoryHint:) instead")
    @available(iOS, introduced: 8.0, deprecated: 100000.0, message: "Use append(path:directoryHint:) instead")
    @available(tvOS, introduced: 9.0, deprecated: 100000.0, message: "Use append(path:directoryHint:) instead")
    @available(watchOS, introduced: 2.0, deprecated: 100000.0, message: "Use append(path:directoryHint:) instead")
    public func appending(urlPathComponent pathComponent: String, isDirectory: Bool) -> RequestBuilder {
        var s = self
        s.append(urlPathComponent: pathComponent, isDirectory: isDirectory)
        
        return s
    }
    
    public func setting(method: HttpMethod) -> RequestBuilder {
        var s = self
        s.set(method: method)
        
        return s
    }
    
    public func setting(header name: String, value: String?) -> RequestBuilder {
        var s = self
        s.set(header: name, value: value)
        
        return s
    }
    
    public func setting(header: HttpHeader, value: String?) -> RequestBuilder {
        var s = self
        s.set(header: header, value: value)
        
        return s
    }
    
    public func setting(body data: Data?) -> RequestBuilder {
        var s = self
        s.set(body: data)
        
        return s
    }
    
    @available(macOS 13.0, *)
    @available(iOS 13.0, *)
    public func setting<Body, TEncoder>(body: Body?, encoder: TEncoder) throws -> RequestBuilder where Body: Encodable, TEncoder: TopLevelEncoder, TEncoder.Output == Data {
        var s = self
        try s.set(body: body, encoder: encoder)
        
        return s
    }
}

extension RequestBuilder {
    private func createRequest() -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody = body
        for (name, value) in headers {
            urlRequest.setValue(value, forHTTPHeaderField: name)
        }
        
        if let cookies = session.configuration.httpCookieStorage?.cookies {
            let cookies = HTTPCookie.requestHeaderFields(with: cookies)
            for (name, value) in cookies {
                urlRequest.setValue(value, forHTTPHeaderField: name)
            }
        }
        
        logger?.trace(createRequestLogMessage(request: urlRequest))
        
        return urlRequest
    }
    
    private func createRequestLogMessage(request: URLRequest) -> Logger.Message {
        var message = "==================================================\n" +
            "< \(method.rawValue) \(url)\n" +
            "< Header:\n"
        if let headers = request.allHTTPHeaderFields {
            for (name, value) in headers {
                message += "< "
                message += name
                message += ": "
                message += value
                message += "\n"
            }
        } else {
            message += "< (no header)\n"
        }
        if let body = request.httpBody {
            message += "< Body:\n"
            message += "< "
            if let body = String(data: body, encoding: .utf8) {
                message += body
            } else {
                message += body.description
            }
        }
        
        return .init(stringLiteral: message)
    }
    
    private func createLogPrefix(response: URLResponse?) -> String {
        var message = "==================================================\n" +
            "> \(method.rawValue) \(url)\n" +
            "> Header:\n"
        if let response = response {
            if let response = response as? HTTPURLResponse {
                for (name, value) in response.allHeaderFields {
                    message += "> "
                    message += String(describing: name)
                    message += ": "
                    message += String(describing: value)
                    message += "\n"
                }
            } else {
                message += "> (not a HTTPURLResponse)\n"
            }
        } else {
            message += "> (response == nil)\n"
        }
        
        return message
    }
    
    private func appendLog(responseMessage message: String, error: Error?) -> String {
        var message = message
        if let error = error {
            message += "> Error:\n"
            message += "> "
            message += String(describing: error)
        }
        
        return message
    }
    
    private func createLogMessage(
        data: Data?,
        response: URLResponse?,
        error: Error?
    ) -> Logger.Message {
        var message = createLogPrefix(response: response)
        if let data = data {
            if let string = String(data: data, encoding: .utf8) {
                message += "> Body:\n"
                for line in string.split(separator: "\n") {
                    message += "> "
                    message += line
                    message += "\n"
                }
            } else {
                message += "> Body:\n"
                message += data.description
            }
        } else {
            message += "> (data == nil)\n"
        }
        
        return .init(stringLiteral: appendLog(responseMessage: message, error: error))
    }
}

extension RequestBuilder {
    @available(macOS 12.0, *)
    @available(iOS 15.0, *)
    public func data<TDecoder, TDecodable>(
        decoder: TDecoder,
        type: TDecodable.Type
    ) async throws -> (TDecodable, URLResponse) where
        TDecoder: TopLevelDecoder,
        TDecoder.Input == Data,
        TDecodable: Decodable
    {
        let data: Data
        let response: URLResponse
        do {
            (data, response) = try await session.data(for: createRequest())
        } catch {
            logger?.trace(createLogMessage(data: nil, response: nil, error: error))
            
            throw error
        }
        
        let decoded: TDecodable
        do {
            decoded = try decoder.decode(type, from: data)
        } catch {
            logger?.trace(createLogMessage(data: data, response: response, error: error))
            
            throw error
        }
        
        logger?.trace(createLogMessage(data: data, response: response, error: nil))
        
        return (decoded, response)
    }
    
    @available(macOS 12.0, *)
    @available(iOS 15.0, *)
    public func data<TDecoder, TDecodable0, TDecodable1>(
        decoder: TDecoder,
        type: TDecodable0.Type,
        fallbackType: TDecodable1.Type
    ) async throws -> (TDecodable0, URLResponse) where
        TDecoder: TopLevelDecoder,
        TDecoder.Input == Data,
        TDecodable0: Decodable,
        TDecodable1: Decodable,
        TDecodable1: Error
    {
        let data: Data
        let response: URLResponse
        do {
            (data, response) = try await session.data(for: createRequest())
        } catch {
            logger?.trace(createLogMessage(data: nil, response: nil, error: error))
            
            throw error
        }
        
        let decoded: TDecodable0
        do {
            decoded = try decoder.decode(type, from: data)
        } catch let error0 {
            let decoded1: TDecodable1
            do {
                decoded1 = try decoder.decode(fallbackType, from: data)
            } catch let error1 {
                let error = SwiftFoundationExtension.RequestBuilder.decodingError(error0: error0, error1: error1)
                logger?.trace(createLogMessage(data: data, response: response, error: error))
                
                throw error
            }
            
            throw decoded1
        }
        
        logger?.trace(createLogMessage(data: data, response: response, error: nil))
        
        return (decoded, response)
    }
    
    @available(macOS 12.0, *)
    @available(iOS 15.0, *)
    public func upload<TDecoder, TDecodable>(
        from body: Data,
        decoder: TDecoder,
        type: TDecodable.Type
    ) async throws -> (TDecodable, URLResponse) where
        TDecoder: TopLevelDecoder,
        TDecoder.Input == Data,
        TDecodable: Decodable
    {
        let data: Data
        let response: URLResponse
        do {
            (data, response) = try await session.upload(for: createRequest(), from: body)
        } catch {
            logger?.trace(createLogMessage(data: nil, response: nil, error: error))
            
            throw error
        }
        
        let decoded: TDecodable
        do {
            decoded = try decoder.decode(type, from: data)
        } catch {
            logger?.trace(createLogMessage(data: data, response: response, error: error))
            
            throw error
        }
        
        logger?.trace(createLogMessage(data: data, response: response, error: nil))
        
        return (decoded, response)
    }
    
    @available(macOS 12.0, *)
    @available(iOS 15.0, *)
    public func upload<TDecoder, TDecodable0, TDecodable1>(
        from body: Data,
        decoder: TDecoder,
        type: TDecodable0.Type,
        fallbackType: TDecodable1.Type
    ) async throws -> (TDecodable0, URLResponse) where
        TDecoder: TopLevelDecoder,
        TDecoder.Input == Data,
        TDecodable0: Decodable,
        TDecodable1: Decodable,
        TDecodable1: Error
    {
        let data: Data
        let response: URLResponse
        do {
            (data, response) = try await session.upload(for: createRequest(), from: body)
        } catch {
            logger?.trace(createLogMessage(data: nil, response: nil, error: error))
            
            throw error
        }
        
        let decoded: TDecodable0
        do {
            decoded = try decoder.decode(type, from: data)
        } catch let error0 {
            let decoded1: TDecodable1
            do {
                decoded1 = try decoder.decode(fallbackType, from: data)
            } catch let error1 {
                let error = SwiftFoundationExtension.RequestBuilder.decodingError(error0: error0, error1: error1)
                logger?.trace(createLogMessage(data: data, response: response, error: error))
                
                throw error
            }
            
            throw decoded1
        }
        
        logger?.trace(createLogMessage(data: data, response: response, error: nil))
        
        return (decoded, response)
    }
    
    @available(macOS 12.0, *)
    @available(iOS 15.0, *)
    public func upload<TDecoder, TDecodable>(
        fromFile url: URL,
        decoder: TDecoder,
        type: TDecodable.Type
    ) async throws -> (TDecodable, URLResponse) where
        TDecoder: TopLevelDecoder,
        TDecoder.Input == Data,
        TDecodable: Decodable
    {
        let data: Data
        let response: URLResponse
        do {
            (data, response) = try await session.upload(for: createRequest(), fromFile: url)
        } catch {
            logger?.trace(createLogMessage(data: nil, response: nil, error: error))
            
            throw error
        }
        
        let decoded: TDecodable
        do {
            decoded = try decoder.decode(type, from: data)
        } catch {
            logger?.trace(createLogMessage(data: data, response: response, error: error))
            
            throw error
        }
        
        logger?.trace(createLogMessage(data: data, response: response, error: nil))
        
        return (decoded, response)
    }
    
    @available(macOS 12.0, *)
    @available(iOS 15.0, *)
    public func upload<TDecoder, TDecodable0, TDecodable1>(
        fromFile url: URL,
        decoder: TDecoder,
        type: TDecodable0.Type,
        fallbackType: TDecodable1.Type
    ) async throws -> (TDecodable0, URLResponse) where
        TDecoder: TopLevelDecoder,
        TDecoder.Input == Data,
        TDecodable0: Decodable,
        TDecodable1: Decodable,
        TDecodable1: Error
    {
        let data: Data
        let response: URLResponse
        do {
            (data, response) = try await session.upload(for: createRequest(), fromFile: url)
        } catch {
            logger?.trace(createLogMessage(data: nil, response: nil, error: error))
            
            throw error
        }
        
        let decoded: TDecodable0
        do {
            decoded = try decoder.decode(type, from: data)
        } catch let error0 {
            let decoded1: TDecodable1
            do {
                decoded1 = try decoder.decode(fallbackType, from: data)
            } catch let error1 {
                let error = SwiftFoundationExtension.RequestBuilder.decodingError(error0: error0, error1: error1)
                logger?.trace(createLogMessage(data: data, response: response, error: error))
                
                throw error
            }
            
            throw decoded1
        }
        
        logger?.trace(createLogMessage(data: data, response: response, error: nil))
        
        return (decoded, response)
    }
}

public enum HttpMethod: String, Codable {
    case Post = "POST",
         Get = "GET",
         Put = "PUT",
         Patch = "PATCH",
         Delete = "DELETE",
         Connect = "CONNECT",
         Head = "HEAD",
         Options = "OPTIONS"
}

public enum HttpHeader: String, Codable {
    case Accept = "Accept",
         AcceptCharset = "Accept-Charset",
         AcceptEncoding = "Accept-Encoding",
         AcceptLanguage = "Accept-Language",
         AcceptRanges = "Accept-Ranges",
         Age = "Age",
         Allow = "Allow",
         ALPN = "ALPN",
         AuthenticationInfo = "Authentication-Info",
         Authorization = "Authorization",
         CacheControl = "Cache-Control",
         Connection = "Connection",
         ContentDisposition = "Content-Disposition",
         ContentEncoding = "Content-Encoding",
         ContentLanguage = "Content-Language",
         ContentLength = "Content-Length",
         ContentLocation = "Content-Location",
         ContentRange = "Content-Range",
         ContentType = "Content-Type",
         Cookie = "Cookie",
         DASL = "DASL",
         Date = "Date",
         DAV = "DAV",
         Depth = "Depth",
         Destination = "Destination",
         ETag = "ETag",
         Expect = "Expect",
         Expires = "Expires",
         From = "From",
         Forwarded = "Forwarded",
         Host = "Host",
         HTTP2Settings = "HTTP2-Settings",
         If = "If",
         IfMatch = "If-Match",
         IfModifiedSince = "If-Modified-Since",
         IfNoneMatch = "If-None-Match",
         IfRange = "If-Range",
         IfScheduleTagMatch = "If-Schedule-Tag-Match",
         IfUnmodifiedSince = "If-Unmodified-Since",
         LastModified = "Last-Modified",
         Location = "Location",
         LockToken = "Lock-Token",
         Link = "Link",
         MaxForwards = "Max-Forwards",
         MIMEVersion = "MIME-Version",
         OrderingType = "Ordering-Type",
         Origin = "Origin",
         Overwrite = "Overwrite",
         Position = "Position",
         Pragma = "Pragma",
         Prefer = "Prefer",
         PreferenceApplied = "Preference-Applied",
         ProxyAuthenticate = "Proxy-Authenticate",
         ProxyAuthenticationInfo = "Proxy-Authentication-Info",
         ProxyAuthorization = "Proxy-Authorization",
         PublicKeyPins = "Public-Key-Pins",
         PublicKeyPinsReportOnly = "Public-Key-Pins-Report-Only",
         Range = "Range",
         Referrer = "Referer",
         RetryAfter = "Retry-After",
         ScheduleReply = "Schedule-Reply",
         ScheduleTag = "Schedule-Tag",
         SecWebSocketAccept = "Sec-WebSocket-Accept",
         SecWebSocketExtensions = "Sec-WebSocket-Extensions",
         SecWebSocketKey = "Sec-WebSocket-Key",
         SecWebSocketProtocol = "Sec-WebSocket-Protocol",
         SecWebSocketVersion = "Sec-WebSocket-Version",
         Server = "Server",
         SetCookie = "Set-Cookie",
         SLUG = "SLUG",
         StrictTransportSecurity = "Strict-Transport-Security",
         TE = "TE",
         Timeout = "Timeout",
         Trailer = "Trailer",
         TransferEncoding = "Transfer-Encoding",
         Upgrade = "Upgrade",
         UserAgent = "User-Agent",
         Vary = "Vary",
         Via = "Via",
         Warning = "Warning",
         WWWAuthenticate = "WWW-Authenticate",
         AccessControlAllowOrigin = "Access-Control-Allow-Origin",
         AccessControlAllowMethods = "Access-Control-Allow-Methods",
         AccessControlAllowCredentials = "Access-Control-Allow-Credentials",
         AccessControlAllowHeaders = "Access-Control-Allow-Headers",
         AccessControlRequestMethod = "Access-Control-Request-Method",
         AccessControlRequestHeaders = "Access-Control-Request-Headers",
         AccessControlExposeHeaders = "Access-Control-Expose-Headers",
         AccessControlMaxAge = "Access-Control-Max-Age",
         XHttpMethodOverride = "X-Http-Method-Override",
         XForwardedHost = "X-Forwarded-Host",
         XForwardedServer = "X-Forwarded-Server",
         XForwardedProto = "X-Forwarded-Proto",
         XForwardedFor = "X-Forwarded-For",
         XForwardedPort = "X-Forwarded-Port",
         XRequestId = "X-Request-ID",
         XCorrelationId = "X-Correlation-ID",
         XTotalCount = "X-Total-Count"
}
