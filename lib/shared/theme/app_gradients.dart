import 'package:flutter/material.dart';

class AppGradients {
  static const LinearGradient primary = LinearGradient(
    colors: [Color(0xFF5E548E), Color(0xFFFFAFCC)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient success = LinearGradient(
    colors: [Color(0xFFB5E48C), Color(0xFF99D98C)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient error = LinearGradient(
    colors: [Color(0xFFFF758F), Color(0xFFFF8FA3)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient splashGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF0F2027),
      Color(0xFF203A43),
    ],
  );
}
