import 'package:flutter/material.dart';

String serverAddress =
    'https://smccnasipit.edu.ph/sys22/flutter_php_crud'; // production
// String serverAddress = 'http://127.0.0.1/flutter_php_crud'; // debug
String CREATE_URL =
    'https://smccnasipit.edu.ph/sys22/flutter_php_crud/api/create.php';
String READ_URL =
    'https://smccnasipit.edu.ph/sys22/flutter_php_crud/api/read.php';
String UPDATE_URL =
    'https://smccnasipit.edu.ph/sys22/flutter_php_crud/api/update.php';
String DELETE_URL =
    'https://smccnasipit.edu.ph/sys22/flutter_php_crud/api/delete.php';

FontStyle fsItalic = FontStyle.italic;
FontStyle fsNormal = FontStyle.normal;

FontWeight fwBold = FontWeight.bold;
FontWeight fwNormal = FontWeight.normal;

TextAlign taCenter = TextAlign.center;
TextAlign taJustify = TextAlign.justify;
TextAlign taLeft = TextAlign.left;
TextAlign taRight = TextAlign.right;

Widget poppins(String text, Color color, double fontSize, FontStyle fontStyle,
        FontWeight fontWeight, TextAlign textAlign) =>
    Text(text,
        style: TextStyle(
            color: color,
            fontSize: fontSize,
            fontStyle: fontStyle,
            fontWeight: fontWeight),
        textAlign: textAlign);

String generateID() => DateTime.now().microsecondsSinceEpoch.toString();
