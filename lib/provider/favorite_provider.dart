import 'package:capstone/model/destination.dart';
import 'package:capstone/service/auth_service.dart';
import 'package:capstone/service/favorite_service.dart';
import 'package:flutter/foundation.dart';

class FavoriteProvider extends ChangeNotifier {
  final FavoriteService _favoriteService;
  final AuthService _authService;

  List<Destination> _favorites = [];
  bool _isLoading = false;
  String? _currentUserId;

  List<Destination> get favorites => _favorites;
  bool get isLoading => _isLoading;

  FavoriteProvider(this._authService, this._favoriteService) {
    _initializeProvider();

    // Listener untuk menangani pergantian/login user
    _authService.authStateChanges.listen((user) {
      if (user != null && user.uid != _currentUserId) {
        _currentUserId = user.uid;
        _loadFavorites();
      } else if (user == null) {
        _currentUserId = null;
        _clearFavoritesInMemory();
      }
    });
  }

  void _initializeProvider() {
    // Ambil user ID saat Provider pertama kali dibuat (app start)
    _currentUserId = _authService.currentUser?.uid;
    _loadFavorites();
  }

  void _clearFavoritesInMemory() {
    _favorites.clear();
    notifyListeners();
  }

  Future<void> _loadFavorites() async {
    final userId = _currentUserId;
    if (userId == null) {
      _clearFavoritesInMemory();
      return;
    }
    _isLoading = true;
    notifyListeners();
    try {
      _favorites = await _favoriteService.getFavorites(userId);
    } catch (e) {
      // ...
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addToFavorites(Destination item) async {
    final userId = _currentUserId;
    if (userId == null) return false;

    try {
      final success = await _favoriteService.addToFavorites(userId, item);

      if (success) {
        _favorites.add(item);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Error adding to favorites: $e');
      return false;
    }
  }

  Future<bool> removeFromFavorites(String itemName) async {
    final userId = _currentUserId;
    if (userId == null) return false;

    try {
      final success = await _favoriteService.removeFromFavorites(
        userId,
        itemName,
      );

      if (success) {
        // Hapus dari list Destination
        _favorites.removeWhere((item) => item.name == itemName);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Error removing from favorites: $e');
      return false;
    }
  }

  bool isFavorite(String itemName) {
    return _favorites.any((item) => item.name == itemName);
  }

  Future<void> toggleFavorite(Destination item) async {
    if (isFavorite(item.name)) {
      await removeFromFavorites(item.name);
    } else {
      await addToFavorites(item);
    }
  }

  Future<void> clearAllFavorites() async {
    final userId = _currentUserId;
    // Tidak ada yang dihapus jika tidak ada user
    if (userId == null) return;

    try {
      // Panggil Service dengan User ID
      final success = await _favoriteService.clearAllFavorites(userId);
      if (success) {
        _favorites.clear();
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error clearing favorites: $e');
    }
  }

  int get favoriteCount => _favorites.length;
}
