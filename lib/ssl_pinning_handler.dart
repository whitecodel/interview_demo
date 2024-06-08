import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

Future<SecurityContext> getSecurityContext() async {
  // final sslCert = await rootBundle.load('assets/certificate_fail.pem');
  final sslCert = await rootBundle.load('assets/certificate.pem');
  SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
  securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
  return securityContext;
}

Future<http.Client> getSSLPinningClient() async {
  final SecurityContext securityContext = await getSecurityContext();
  HttpClient httpClient = HttpClient(context: securityContext);
  IOClient ioClient = IOClient(httpClient);
  return ioClient;
}
