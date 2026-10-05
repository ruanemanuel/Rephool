import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:rephool_test/constants/color_detector.dart';
import 'package:rephool_test/constants/ph_info.dart';
import 'package:rephool_test/screens/home_screen.dart';
import 'package:rephool_test/state/image_store.dart';
import 'package:rephool_test/theme/theme_controller.dart';

void main() {
  test('hexToHsv returns hue in 0-360', () {
    final hsv = hexToHsv('#AE4A4E');
    expect(hsv[0], inInclusiveRange(0, 360));
    expect(hsv[1], inInclusiveRange(0, 1));
    expect(hsv[2], inInclusiveRange(0, 1));
  });

  test('extractPhFromColor maps red hues to acidic PH 1', () {
    final info = extractPhFromColor('#AE4A4E');
    expect(info.phValue, 1);
    expect(info.phDescription, 'Extremamente ácido');
  });

  test('rgbToHsl and classifyRgb stay consistent', () {
    final hsl = rgbToHsl(174, 74, 78);
    expect(hsl.h, greaterThan(0));
    final classified = classifyRgb(174, 74, 78);
    expect(classified.baseColor, isNotNull);
    expect(classified.key, contains('-'));
  });

  testWidgets('home screen shows Rephool actions', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeController()),
          ChangeNotifierProvider(create: (_) => ImageStore()),
        ],
        child: const MaterialApp(home: HomeScreen()),
      ),
    );

    expect(find.text('Rephool'), findsOneWidget);
    expect(find.text('Tirar foto'), findsOneWidget);
    expect(find.text('Escolher foto da galeria'), findsOneWidget);
  });
}
