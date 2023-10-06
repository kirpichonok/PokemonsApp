/// The method to use in the HTTP requests.
/// Indicates what actions to be performed by the remote host.
enum HTTPMethod: String {
    /// The `GET` method according to the [RFC 7231](https://datatracker.ietf.org/doc/html/rfc7231#section-4.3.1).
    case get = "GET"
}
