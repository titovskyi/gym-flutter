import 'dart:convert';

String _decodeBase64(String str) {
  //'-', '+' 62nd char of encoding,  '_', '/' 63rd char of encoding
  String output = str.replaceAll('-', '+').replaceAll('_', '/');
  switch (output.length % 4) {
    // Pad with trailing '='
    case 0: // No pad chars in this case
      break;
    case 2: // Two pad chars
      output += '==';
      break;
    case 3: // One pad char
      output += '=';
      break;
    default:
      throw Exception('Illegal base64url string!"');
  }

  return utf8.decode(base64Url.decode(output));
}

Map _parseJwt(String token) {
  final parts = token.split('.');
  final payload = _decodeBase64(parts[1]);
  // final String decoded = base64Url.normalize(payload);
  final payloadMap = json.decode(payload);

  return payloadMap;
}

int decodeJwt(String token) {
  Map tokenDecoded = _parseJwt(token);

  return tokenDecoded['sub'];
}
