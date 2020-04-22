import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todos/android/android.app.dart';

// Esta classe permite acesso ao LocalHost com certificados HTTPS inválidos
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    HttpClient client = super.createHttpClient(context);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  }
}

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(AndroidApp());
}
