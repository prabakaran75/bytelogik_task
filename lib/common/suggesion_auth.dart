import 'package:flutter/material.dart';

GestureDetector suggestAuth(VoidCallback onPress, String text, String sug) {
  return GestureDetector(
    onTap: onPress,
    child: RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: sug,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 18, 63, 141),
            ),
          ),
        ],
      ),
    ),
  );
}
