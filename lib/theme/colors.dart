import 'dart:math';
import 'package:flutter/material.dart';

List<Color> colors = [
  Color(0xff7F86FF),
  Color(0xffff4171),
  Color(0xffffbd69),
  Color(0xff5dd59e)
];

Color randomColor() {
  Random random = Random();
  int randomIndex = random.nextInt(colors.length);
  return colors[randomIndex];
}

Color darkenColor(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

  return hslDark.toColor();
}