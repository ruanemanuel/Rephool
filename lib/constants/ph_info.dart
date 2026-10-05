import 'package:flutter/material.dart';

class ColorValue {
  const ColorValue({
    required this.red,
    required this.green,
    required this.blue,
    required this.phValue,
    required this.phDescription,
  });

  final int red;
  final int green;
  final int blue;
  final int phValue;
  final String phDescription;
}

class PhInfo {
  const PhInfo({required this.phValue, required this.phDescription});

  final int phValue;
  final String phDescription;
}

const colorValues = <ColorValue>[
  ColorValue(red: 174, green: 74, blue: 78, phValue: 1, phDescription: 'Extremamente ácido'),
  ColorValue(red: 162, green: 73, blue: 88, phValue: 2, phDescription: 'Muito ácido'),
  ColorValue(red: 172, green: 112, blue: 211, phValue: 3, phDescription: 'Bastante ácido'),
  ColorValue(red: 115, green: 88, blue: 123, phValue: 4, phDescription: 'Bem ácido'),
  ColorValue(red: 162, green: 73, blue: 86, phValue: 5, phDescription: 'Ácido'),
  ColorValue(red: 122, green: 88, blue: 131, phValue: 6, phDescription: 'Pouco neutro'),
  ColorValue(red: 137, green: 113, blue: 145, phValue: 7, phDescription: 'Neutro'),
  ColorValue(red: 117, green: 87, blue: 137, phValue: 8, phDescription: 'Pouco básico'),
  ColorValue(red: 120, green: 94, blue: 128, phValue: 9, phDescription: 'Básico'),
  ColorValue(red: 116, green: 97, blue: 119, phValue: 10, phDescription: 'Bastante básico'),
  ColorValue(red: 120, green: 97, blue: 133, phValue: 11, phDescription: 'Muito básico'),
  ColorValue(red: 60, green: 80, blue: 108, phValue: 12, phDescription: 'Alcalinidade intensa'),
  ColorValue(red: 6, green: 109, blue: 27, phValue: 13, phDescription: 'Alcalinidade extrema'),
  ColorValue(red: 205, green: 155, blue: 4, phValue: 14, phDescription: 'Extremamente básico'),
];

List<double> hexToHsv(String hex) {
  var value = hex.replaceFirst('#', '');
  if (value.length == 8) value = value.substring(0, 6);
  final r = int.parse(value.substring(0, 2), radix: 16) / 255;
  final g = int.parse(value.substring(2, 4), radix: 16) / 255;
  final b = int.parse(value.substring(4, 6), radix: 16) / 255;

  final max = [r, g, b].reduce((a, c) => a > c ? a : c);
  final min = [r, g, b].reduce((a, c) => a < c ? a : c);
  final delta = max - min;

  var h = 0.0;
  if (delta != 0) {
    if (max == r) {
      h = 60 * (((g - b) / delta) % 6);
    } else if (max == g) {
      h = 60 * ((b - r) / delta + 2);
    } else {
      h = 60 * ((r - g) / delta + 4);
    }
    if (h < 0) h += 360;
  }

  final s = max == 0 ? 0.0 : delta / max;
  return [h, s, max];
}

String rgbToHex(int r, int g, int b) {
  return '#${r.toRadixString(16).padLeft(2, '0')}'
      '${g.toRadixString(16).padLeft(2, '0')}'
      '${b.toRadixString(16).padLeft(2, '0')}';
}

PhInfo extractPhFromColor(String hex) {
  final hue = hexToHsv(hex).first;
  var phValue = 0;

  if (hue >= 355.5 || hue <= 21.5) {
    phValue = 1;
  } else if (hue < 355.5 && hue >= 344.6) {
    phValue = 2;
  } else if (hue < 344.6 && hue >= 325.5) {
    phValue = 3;
  } else if (hue < 325.5 && hue >= 304.1) {
    phValue = 4;
  } else if (hue < 304.1 && hue >= 289.8) {
    phValue = 5;
  } else if (hue < 289.8 && hue >= 279.6) {
    phValue = 6;
  } else if (hue < 279.6 && hue >= 266.9) {
    phValue = 7;
  } else if (hue < 266.9 && hue >= 260.1) {
    phValue = 8;
  } else if (hue < 260.1 && hue >= 251.6) {
    phValue = 9;
  } else if (hue < 251.6 && hue >= 227.7) {
    phValue = 10;
  } else if (hue < 227.7 && hue >= 146.7) {
    phValue = 12;
  } else if (hue < 146.7 && hue >= 88.3) {
    phValue = 13;
  } else if (hue < 88.3 && hue >= 22.7) {
    phValue = 14;
  }

  final match = colorValues.where((c) => c.phValue == phValue);
  return PhInfo(
    phValue: phValue,
    phDescription: match.isEmpty ? '' : match.first.phDescription,
  );
}

String srgbToHex(double r, double g, double b, {bool leadingHashSign = true}) {
  int to255(double v) => (v * 255.0).round().clamp(0, 255);
  return rgbToHex(to255(r), to255(g), to255(b));
}
