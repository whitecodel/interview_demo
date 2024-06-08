import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;

class SSLPinningClient extends http.BaseClient {
  _loadPublicKey() async {
    return await rootBundle.loadString('assets/certificate.pem');
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    // Load the public key from assets
    final publicKey = await _loadPublicKey();

    final SecurityContext context = SecurityContext(withTrustedRoots: true);
    context.setTrustedCertificatesBytes(publicKey.codeUnits);

    final HttpClient httpClient = HttpClient(context: context);
    final Uri uri = request.url;
    final HttpClientRequest clientRequest =
        await httpClient.openUrl(request.method, uri);

    request.headers.forEach((key, value) {
      clientRequest.headers.set(key, value);
    });

    if (request is http.Request) {
      clientRequest.add(request.bodyBytes);
    }

    final HttpClientResponse clientResponse = await clientRequest.close();

    // Convert HttpHeaders to Map<String, String>
    final headers = <String, String>{};
    clientResponse.headers.forEach((name, values) {
      headers[name] = values.join(', ');
    });

    final http.StreamedResponse response = http.StreamedResponse(
      clientResponse,
      clientResponse.statusCode,
      contentLength: clientResponse.contentLength,
      request: request,
      headers: headers,
      isRedirect: clientResponse.isRedirect,
      persistentConnection: clientResponse.persistentConnection,
      reasonPhrase: clientResponse.reasonPhrase,
    );

    return response;
  }
}
