import 'package:flutter/material.dart';
import 'package:flutter_php_crud/pages/home.dart';

void main() {
  runApp(const FlutterPhpCrudApp());
}

class FlutterPhpCrudApp extends StatefulWidget {
  const FlutterPhpCrudApp({super.key});

  @override
  State<FlutterPhpCrudApp> createState() => _FlutterPhpCrudAppState();
}

class _FlutterPhpCrudAppState extends State<FlutterPhpCrudApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: const HomePage(),
    );
  }
}


// modify html
// <base href="/path/"> (do not include domain name)
// <meta http-equiv="Content-Security-Policy" content="upgrade-insecure-requests" />