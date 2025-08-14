import 'package:flutter/material.dart';

  GestureDetector customButton(
    double ht,
    double wd,
    String name,
    VoidCallback onPress,
  ) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: ht * 0.06,
        width: wd * 0.6,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 18, 63, 141),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(name, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }