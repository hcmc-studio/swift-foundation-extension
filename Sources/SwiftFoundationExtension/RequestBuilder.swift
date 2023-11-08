//
//  RequestBuilder.swift
//
//
//  Created by Ji-Hwan Kim on 11/6/23.
//

import Foundation
import Combine

public struct RequestBuilder {
    public var session: URLSession
    public var url: URL
    public var method: HttpMethod
    public var headers: [String : String?]
    public var body: Data?
    
    public init(
        session: URLSession = .shared,
        url: URL,
        method: HttpMethod,
        headers: [String : String?] = [:],
        body: Data? = nil
    ) {
        self.session = session
        self.url = url
        self.method = method
        self.headers = headers
    }
    
    public init(
        overriding from: RequestBuilder,
        session: URLSession? = nil,
        url: URL? = nil,
        method: HttpMethod? = nil,
        headers: [String : String?]? = nil,
        body: Data? = nil
    ) {
        self.session = session ?? from.session
        self.url = url ?? from.url
        self.method = method ?? from.method
        self.headers = headers ?? from.headers
        self.body = body ?? from.body
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
    public mutating func set<TEncoder>(body: (any Encodable)?, encoder: TEncoder) throws where TEncoder : TopLevelEncoder, TEncoder.Output == Data {
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
    public func setting<TEncoder>(body: (any Encodable)?, encoder: TEncoder) throws -> RequestBuilder where TEncoder: TopLevelEncoder, TEncoder.Output == Data {
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
        
        return urlRequest
    }
}

extension RequestBuilder {
    @discardableResult
    public func dataTask() -> URLSessionDataTask {
        session.dataTask(with: createRequest())
    }
    
    @discardableResult
    public func dataTask(completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        session.dataTask(with: createRequest(), completionHandler: completionHandler)
    }
    
    @discardableResult
    public func downloadTask() -> URLSessionDownloadTask {
        session.downloadTask(with: createRequest())
    }
    
    @discardableResult
    public func downloadTask(completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void) -> URLSessionDownloadTask {
        session.downloadTask(with: createRequest(), completionHandler: completionHandler)
    }
    
    @discardableResult
    public func uploadTask(from data: Data) -> URLSessionUploadTask {
        session.uploadTask(with: createRequest(), from: data)
    }
    
    @discardableResult
    public func uploadTask(from data: Data?, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionUploadTask {
        session.uploadTask(with: createRequest(), from: data, completionHandler: completionHandler)
    }
    
    @discardableResult
    public func uploadTask(fromFile url: URL) -> URLSessionUploadTask {
        session.uploadTask(with: createRequest(), fromFile: url)
    }
    
    @discardableResult
    public func uploadTask(fromFile url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionUploadTask {
        session.uploadTask(with: createRequest(), fromFile: url, completionHandler: completionHandler)
    }
}

extension RequestBuilder {
    @available(macOS 13.0, *)
    @available(iOS 15.0, *)
    public func data() async throws -> (Data, URLResponse) {
        try await session.data(for: createRequest())
    }
    
    @available(macOS 13.0, *)
    @available(iOS 15.0, *)
    public func download() async throws -> (URL, URLResponse) {
        try await session.download(for: createRequest())
    }
    
    @available(macOS 13.0, *)
    @available(iOS 15.0, *)
    public func upload(from data: Data) async throws -> (Data, URLResponse) {
        try await session.upload(for: createRequest(), from: data)
    }
    
    @available(macOS 13.0, *)
    @available(iOS 15.0, *)
    public func upload(fromFile url: URL) async throws -> (Data, URLResponse) {
        try await session.upload(for: createRequest(), fromFile: url)
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
