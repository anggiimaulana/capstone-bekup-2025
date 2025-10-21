import 'package:capstone/model/destination.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavoriteService {
  String _getFavoritesKey(String userId) {
    return 'user_favorites_$userId';
  }

  Future<List<Destination>> getFavorites(String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // Gunakan key unik
      final favoritesKey = _getFavoritesKey(userId);
      final favoritesJson = prefs.getStringList(favoritesKey) ?? [];

      return favoritesJson.map((json) {
        final Map<String, dynamic> data = jsonDecode(json);
        return Destination.fromMap(data);
      }).toList();
    } catch (e) {
      print('Error getting favorites: $e');
      return [];
    }
  }

  Future<bool> addToFavorites(String userId, Destination item) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // Gunakan kunci unik
      final favoritesKey = _getFavoritesKey(userId);
      final favoritesJson = prefs.getStringList(favoritesKey) ?? [];

      // Check if item already exists
      final existingIndex = favoritesJson.indexWhere((json) {
        final Map<String, dynamic> data = jsonDecode(json);
        return data['name'] == item.name;
      });

      if (existingIndex != -1) {
        return true;
      }

      // Add new item
      final itemJson = jsonEncode(item.toMap());
      favoritesJson.add(itemJson);

      return await prefs.setStringList(
        favoritesKey,
        favoritesJson,
      ); 
    } catch (e) {
      print('Error adding to favorites: $e');
      return false;
    }
  }

  Future<bool> removeFromFavorites(String userId, String itemName) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // Gunakan kunci unik
      final favoritesKey = _getFavoritesKey(userId);
      final favoritesJson = prefs.getStringList(favoritesKey) ?? [];

      // Remove item by name
      favoritesJson.removeWhere((json) {
        final Map<String, dynamic> data = jsonDecode(json);
        return data['name'] == itemName;
      });

      return await prefs.setStringList(
        favoritesKey,
        favoritesJson,
      ); 
    } catch (e) {
      print('Error removing from favorites: $e');
      return false;
    }
  }

  Future<bool> clearAllFavorites(String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // Hapus hanya kunci unik user ini
      final favoritesKey = _getFavoritesKey(userId);
      return await prefs.remove(favoritesKey);
    } catch (e) {
      print('Error clearing favorites: $e');
      return false;
    }
  }

  Future<bool> isFavorite(String userId, String itemName) async {
    try {
      final favorites = await getFavorites(
        userId,
      ); // Memanggil fungsi yang sudah diubah
      return favorites.any((item) => item.name == itemName);
    } catch (e) {
      print('Error checking favorite status: $e');
      return false;
    }
  }
}
