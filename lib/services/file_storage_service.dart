import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class FileStorageService {
  static Future<void> saveFavorites(List<String> favoriteIds) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String jsonString = jsonEncode(favoriteIds);
      await prefs.setString('favorites_storage', jsonString);
      print(
        '=== [Tech Hub Storage] تم حفظ المفضلة في ذاكرة المتصفح بنجاح! ===',
      );
    } catch (error) {
      print('حدث خطأ أثناء حفظ البيانات: $error');
    }
  }

  static Future<List<String>> readFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      if (!prefs.containsKey('favorites_storage')) {
        print('=== [Tech Hub Storage] لا توجد بيانات محفوظة مسبقاً ===');
        return [];
      }

      final String? jsonString = prefs.getString('favorites_storage');
      if (jsonString == null) return [];

      final List<dynamic> decodedData = jsonDecode(jsonString);
      return decodedData.map((id) => id.toString()).toList();
    } catch (error) {
      print('حدث خطأ أثناء قراءة البيانات: $error');
      return [];
    }
  }
}
