import 'package:flutter/material.dart';

Color colorFromCssHex(String hex) {
  var value = hex.replaceFirst('#', '');
  if (value.length == 6) {
    value = 'FF$value';
  } else if (value.length == 8) {
    final rgb = value.substring(0, 6);
    final alpha = value.substring(6, 8);
    value = '$alpha$rgb';
  }
  return Color(int.parse(value, radix: 16));
}

class AppColors {
  const AppColors({
    required this.text,
    required this.themedText,
    required this.iconText,
    required this.title,
    required this.background,
    required this.background2,
    required this.background3,
    required this.tabBackground,
    required this.tabIcon,
    required this.backgroundSelected,
    required this.textSecondary,
    required this.settingsSwitch,
    required this.settingsConfigurationBackground,
    required this.backgroundPrimary,
    required this.guideBackground,
    required this.backgroundSecondary,
    required this.backgroundTernary,
    required this.backgroundQuaternary,
    required this.imageBackground,
    required this.borderPrimary,
    required this.tabActiveBackground,
    required this.tabInactiveBackground,
  });

  final Color text;
  final Color themedText;
  final Color iconText;
  final Color title;
  final Color background;
  final Color background2;
  final Color background3;
  final Color tabBackground;
  final Color tabIcon;
  final Color backgroundSelected;
  final Color textSecondary;
  final Color settingsSwitch;
  final Color settingsConfigurationBackground;
  final Color backgroundPrimary;
  final Color guideBackground;
  final Color backgroundSecondary;
  final Color backgroundTernary;
  final Color backgroundQuaternary;
  final Color imageBackground;
  final Color borderPrimary;
  final Color tabActiveBackground;
  final Color tabInactiveBackground;

  static final light = AppColors(
    text: colorFromCssHex('#000000'),
    themedText: colorFromCssHex("#8A2A8C"),
    iconText: colorFromCssHex('#4c2061'),
    title: colorFromCssHex('#d25ced'),
    background: colorFromCssHex('#ECE7EF'),
    background2: colorFromCssHex('#a5a5a5'),
    background3: colorFromCssHex('#e9e5e5'),
    tabBackground: colorFromCssHex('#C4B5C7'),
    tabIcon: colorFromCssHex('#E5C8FF'),
    backgroundSelected: colorFromCssHex('#E0E1E6'),
    textSecondary: colorFromCssHex('#60646C'),
    settingsSwitch: colorFromCssHex('#c344f5'),
    settingsConfigurationBackground: colorFromCssHex('#7d679c6d'),
    backgroundPrimary: colorFromCssHex('#9A7DC889'),
    guideBackground: colorFromCssHex('#d484ffc1'),
    backgroundSecondary: colorFromCssHex('#b676eac1'),
    backgroundTernary: colorFromCssHex('#9984f9c1'),
    backgroundQuaternary: colorFromCssHex('#dd95e9c1'),
    imageBackground: colorFromCssHex('#9984f973'),
    borderPrimary: colorFromCssHex('#7C31F4B5'),
    tabActiveBackground: colorFromCssHex('#9485ACB5'),
    tabInactiveBackground: colorFromCssHex('#4c4c4c5d'),
  );

  static final dark = AppColors( 
    text: colorFromCssHex('#ffffff'),
    themedText: colorFromCssHex("#D288FF"),
    iconText: colorFromCssHex('#c37fe3'),
    title: colorFromCssHex('#e2a4ff8e'),
    background: colorFromCssHex('#27132F'),
    background2: colorFromCssHex('#221e1e'),
    background3: colorFromCssHex('#433552'),
    tabBackground: colorFromCssHex('#2D1E36'),
    tabIcon: colorFromCssHex('#b379ff'),
    backgroundSelected: colorFromCssHex('#2E3135'),
    textSecondary: colorFromCssHex('#B0B4BA'),
    settingsSwitch: colorFromCssHex('#8648bf'),
    settingsConfigurationBackground: colorFromCssHex('#7d679cf0'),
    backgroundPrimary: colorFromCssHex('#321839'),
    guideBackground: colorFromCssHex('#6b3b84'),
    backgroundSecondary: colorFromCssHex('#B67AFFC1'),
    backgroundTernary: colorFromCssHex('#725dcdc1'),
    backgroundQuaternary: colorFromCssHex('#612b75aa'),
    imageBackground: colorFromCssHex('#ca84f973'),
    borderPrimary: colorFromCssHex('#AA76DADD'),
    tabActiveBackground: colorFromCssHex('#7A4AC6B5'),
    tabInactiveBackground: colorFromCssHex('#422C58B5'),
  );
}
