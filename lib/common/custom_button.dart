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
      height: ht * 0.05,
      width: wd * 0.6,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 16, 73, 172),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(name, style: TextStyle(color: Colors.white)),
      ),
    ),
  );
}
