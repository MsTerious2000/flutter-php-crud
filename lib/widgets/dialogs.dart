import 'package:flutter/material.dart';
import 'package:flutter_php_crud/widgets/colors.dart';
import 'package:flutter_php_crud/widgets/texts.dart';

Widget errorDialog(BuildContext context, String title, String message) =>
    AlertDialog(
        title: poppins(title, darkRed, 20, fsNormal, fwBold, taLeft),
        content: SizedBox(
            width: MediaQuery.of(context).size.width / 4,
            child: poppins(message, black, 15, fsNormal, fwNormal, taLeft)),
        actions: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.done, color: darkGreen))
        ]);

Widget successDialog(BuildContext context, String title, String message) =>
    AlertDialog(
        title: poppins(title, darkBlue, 20, fsNormal, fwBold, taLeft),
        content: SizedBox(
            width: MediaQuery.of(context).size.width / 4,
            child: poppins(message, black, 15, fsNormal, fwNormal, taLeft)),
        actions: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.done, color: darkGreen))
        ]);
