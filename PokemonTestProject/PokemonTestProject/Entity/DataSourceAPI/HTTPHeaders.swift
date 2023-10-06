/// Representation of HTTP headers according to [RFC 7231](https://datatracker.ietf.org/doc/html/rfc7231#section-8.3).
/// The headers does not preserve the order.
typealias HTTPHeaders = [HTTPHeaderName: HTTPHeaderValue]
/// Represents the HTTP header name. The name is a case-sensitive.
typealias HTTPHeaderName = String
/// Represents HTTP header value.
/// The value is a case-sensitive string where only US-ASCII characters are allowed.
typealias HTTPHeaderValue = String
