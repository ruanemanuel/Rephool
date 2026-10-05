import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageStore extends ChangeNotifier {
  static const _recentImageKey = 'recentImage';

  String image = '';

  Future<void> loadRecent() async {
    final prefs = await SharedPreferences.getInstance();
    image = prefs.getString(_recentImageKey) ?? '';
    notifyListeners();
  }

  Future<void> changeImage(String newImage) async {
    image = newImage;
    notifyListeners();
    if (newImage.isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_recentImageKey, newImage);
  }
}
