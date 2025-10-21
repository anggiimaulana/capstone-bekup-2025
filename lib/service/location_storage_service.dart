// lib/service/location_storage_service.dart
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationStorageService {
  static const String _keyLatitude = 'cached_latitude';
  static const String _keyLongitude = 'cached_longitude';
  static const String _keyTimestamp = 'cached_timestamp';
  static const String _keyCityName = 'cached_city_name';

  // Cache validity 
  static const Duration _cacheValidity = Duration(hours: 24);

  // Save location to SharedPreferences
  Future<void> saveLocation(Position position, {String? cityName}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(_keyLatitude, position.latitude);
      await prefs.setDouble(_keyLongitude, position.longitude);
      await prefs.setInt(_keyTimestamp, DateTime.now().millisecondsSinceEpoch);

      if (cityName != null) {
        await prefs.setString(_keyCityName, cityName);
      }

      print('✅ Lokasi berhasil disimpan ke storage');
    } catch (e) {
      print('❌ Error saving location: $e');
    }
  }

  // Get cached location from SharedPreferences
  Future<Position?> getCachedLocation() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final lat = prefs.getDouble(_keyLatitude);
      final lon = prefs.getDouble(_keyLongitude);
      final timestamp = prefs.getInt(_keyTimestamp);

      if (lat == null || lon == null || timestamp == null) {
        print('ℹ️ Belum ada lokasi yang disimpan');
        return null;
      }

      // Check if cache is still valid
      final cachedTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      final now = DateTime.now();
      final difference = now.difference(cachedTime);

      if (difference > _cacheValidity) {
        print('⚠️ Cache lokasi sudah kadaluarsa (${difference.inHours} jam)');
        return null;
      }

      print('✅ Lokasi loaded dari cache (${difference.inHours} jam yang lalu)');

      // Create Position object from cached data
      return Position(
        latitude: lat,
        longitude: lon,
        timestamp: cachedTime,
        accuracy: 0,
        altitude: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0,
        altitudeAccuracy: 0,
        headingAccuracy: 0,
      );
    } catch (e) {
      print('❌ Error getting cached location: $e');
      return null;
    }
  }

  // Get cached city name
  Future<String?> getCachedCityName() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_keyCityName);
    } catch (e) {
      print('❌ Error getting cached city name: $e');
      return null;
    }
  }

  // Check if cache exists and is valid
  Future<bool> hasCachedLocation() async {
    final location = await getCachedLocation();
    return location != null;
  }

  // Clear cached location
  Future<void> clearCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_keyLatitude);
      await prefs.remove(_keyLongitude);
      await prefs.remove(_keyTimestamp);
      await prefs.remove(_keyCityName);
      print('🗑️ Cache lokasi berhasil dihapus');
    } catch (e) {
      print('❌ Error clearing cache: $e');
    }
  }

  // Get cache age in hours
  Future<int?> getCacheAgeInHours() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final timestamp = prefs.getInt(_keyTimestamp);

      if (timestamp == null) return null;

      final cachedTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      final now = DateTime.now();
      return now.difference(cachedTime).inHours;
    } catch (e) {
      return null;
    }
  }
}
