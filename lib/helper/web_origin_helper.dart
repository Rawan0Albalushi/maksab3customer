import 'package:universal_html/html.dart' as html;

/// Origin of the page the customer is on, including a non-default port.
///
/// `location.hostname` drops the port, so an app opened at
/// `http://127.0.0.1:8000` was sent back to `http://127.0.0.1` after payment
/// and the browser refused the connection.
String webOrigin() {
  final String? origin = html.window.location.origin;
  if (origin != null && origin.isNotEmpty && origin != 'null') {
    return origin;
  }
  final String protocol = html.window.location.protocol;
  final String? host = html.window.location.host;
  if (host != null && host.isNotEmpty && host != 'null') {
    return '$protocol//$host';
  }
  return '$protocol//${html.window.location.hostname ?? ''}';
}

/// Return URL for a gateway callback, encoded so its query stays intact.
String webPaymentCallback(String pathAndQuery) {
  return Uri.encodeComponent('${webOrigin()}$pathAndQuery');
}
