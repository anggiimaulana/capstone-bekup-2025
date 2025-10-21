import 'package:capstone/model/chat.dart';
import 'package:capstone/model/tourism_recommendation.dart';
import 'package:capstone/service/location_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:capstone/service/gemini_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum MessageType { text, recommendations, error, system }

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final MessageType messageType;
  final List<TourismRecommendation>? recommendations;
  final String? error;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
    required this.messageType,
    this.recommendations,
    this.error,
  });
}

class GeminiProvider extends ChangeNotifier {
  final GeminiService _geminiService;
  final LocationStorageService _locationStorage = LocationStorageService();

  List<ChatMessage> _historyChats = [];
  List<Chat> _geminiHistory = [];
  bool _isLoading = false;
  Position? _currentLocation;
  String? _locationError;
  bool _isLoadingLocation = false;

  // Key untuk lokasi (jika ingin dihapus juga saat logout)
  static const _locationLatKey = 'user_location_latitude';
  static const _locationLonKey = 'user_location_longitude';

  GeminiProvider(this._geminiService) {
    _initializeBot();
    _loadCachedLocation(); // Load dari cache saat init
  }

  List<ChatMessage> get historyChats => _historyChats;
  bool get isLoading => _isLoading;
  Position? get currentLocation => _currentLocation;
  String? get locationError => _locationError;
  bool get isLoadingLocation => _isLoadingLocation;

  void _initializeBot() {
    final welcomeMessage = ChatMessage(
      text:
          "Halo! Saya MyAI - WisataBot dari Grup Capstone B25-PG002. Saya akan membantu Anda menemukan tempat wisata, hotel, kuliner, dan informasi pariwisata di Indonesia. Silakan tanya apa saja!",
      isUser: false,
      timestamp: DateTime.now(),
      messageType: MessageType.text,
    );
    _historyChats.add(welcomeMessage);
  }

  // Load cached location saat pertama kali buka
  Future<void> _loadCachedLocation() async {
    try {
      _isLoadingLocation = true;
      notifyListeners();

      final cachedLocation = await _locationStorage.getCachedLocation();

      if (cachedLocation != null) {
        _currentLocation = cachedLocation;
        _locationError = null;

        final cacheAge = await _locationStorage.getCacheAgeInHours();
        print('✅ Lokasi loaded dari cache (${cacheAge ?? 0} jam yang lalu)');

        _isLoadingLocation = false;
        notifyListeners();
        return;
      }

      // Jika tidak ada cache, ambil lokasi baru
      print('ℹ️ Tidak ada cache, mengambil lokasi baru...');
      await getCurrentLocation(showSnackbar: false);
    } catch (e) {
      print('❌ Error loading cached location: $e');
      _locationError = "Gagal memuat lokasi";
    } finally {
      _isLoadingLocation = false;
      notifyListeners();
    }
  }

  // Get current location dengan parameter untuk refresh manual
  Future<void> getCurrentLocation({bool showSnackbar = true}) async {
    try {
      _isLoadingLocation = true;
      _locationError = null;
      notifyListeners();

      // Check if location service is enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _locationError = "Layanan lokasi tidak aktif. Silakan aktifkan GPS.";
        _isLoadingLocation = false;
        notifyListeners();
        return;
      }

      // Check and request permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _locationError =
              "Izin lokasi ditolak. Fitur rekomendasi berbasis lokasi tidak tersedia.";
          _isLoadingLocation = false;
          notifyListeners();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _locationError =
            "Izin lokasi ditolak permanen. Silakan aktifkan di pengaturan aplikasi.";
        _isLoadingLocation = false;
        notifyListeners();
        return;
      }

      // Get current position
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      _currentLocation = position;
      _locationError = null;

      // Save to cache
      // await _locationStorage.saveLocation(
      //   position,
      //   cityName: 'Indramayu, Jawa Barat', 
      // );

      print('✅ Lokasi berhasil diupdate dan disimpan ke cache');

      // Show success message if needed
      if (showSnackbar && navigatorKey.currentContext != null) {
        ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
          SnackBar(
            content: const Text('✓ Lokasi berhasil diperbarui'),
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    } catch (e) {
      _locationError = "Gagal mendapatkan lokasi: ${e.toString()}";
      print('❌ Error getting location: $e');
    } finally {
      _isLoadingLocation = false;
      notifyListeners();
    }
  }

  // Force refresh location (untuk tombol "Perbarui Lokasi")
  Future<void> refreshLocation() async {
    await getCurrentLocation(showSnackbar: true);
  }

  // Clear location cache
  Future<void> clearLocationCache() async {
    await _locationStorage.clearCache();
    _currentLocation = null;
    _locationError = null;
    notifyListeners();
  }

  Future<void> clearAllUserData() async {
    // Membersihkan History Chat
    _historyChats.clear();
    _geminiHistory.clear();

    // Membersihkan Location State di memory
    _currentLocation = null;
    _locationError = null;

    await _locationStorage.clearCache();

    // Inisialisasi ulang pesan sambutan bot
    _initializeBot();

    notifyListeners();
  }

  // Add navigator key for snackbar
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  Future<void> sendMessage(String message, [List<String>? imagePaths]) async {
    if (message.trim().isEmpty) return;

    // Add user message
    final userMessage = ChatMessage(
      text: message,
      isUser: true,
      timestamp: DateTime.now(),
      messageType: MessageType.text,
    );
    _historyChats.add(userMessage);

    // Add to Gemini history
    _geminiHistory.add(Chat(text: message, isMyChat: true, paths: imagePaths));

    notifyListeners();

    // Show typing indicator
    _isLoading = true;
    notifyListeners();

    try {
      // Create context-aware prompt
      final contextualPrompt = _createContextualPrompt(message);

      final response = await _geminiService.sendMessage(
        contextualPrompt,
        _geminiHistory,
        imagePaths,
      );

      // Add bot response to Gemini history
      _geminiHistory.add(Chat(text: response, isMyChat: false));

      // Parse response and create appropriate message
      final botMessage = _parseGeminiResponse(response, message);
      _historyChats.add(botMessage);
    } catch (e) {
      print('Error sending message: $e');
      final errorMessage = ChatMessage(
        text:
            "Maaf, saya mengalami kendala teknis. Silakan coba lagi dalam beberapa saat.",
        isUser: false,
        timestamp: DateTime.now(),
        messageType: MessageType.error,
        error: e.toString(),
      );
      _historyChats.add(errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String _createContextualPrompt(String userMessage) {
    final locationContext = _currentLocation != null
        ? "Lokasi pengguna saat ini: Latitude ${_currentLocation!.latitude}, Longitude ${_currentLocation!.longitude} (sekitar Indramayu, Jawa Barat, Indonesia)"
        : "Lokasi pengguna: Indramayu, Jawa Barat, Indonesia";

    return """
IDENTITAS: Anda adalah MyAI - WisataBot yang dibuat oleh Grup Capstone B25-PG002. Anda adalah asisten wisata virtual yang membantu wisatawan menemukan informasi pariwisata di Indonesia.

KONTEKS LOKASI: $locationContext

ATURAN PENTING:
1. HANYA jawab pertanyaan tentang pariwisata di Indonesia (tempat wisata, hotel, kuliner, transportasi, budaya, akomodasi, atraksi, festival, dll)
2. Jika ditanya hal lain di luar pariwisata Indonesia, tolak dengan sopan: "Maaf, saya hanya dapat membantu dengan informasi pariwisata di Indonesia. Apakah ada tempat wisata, hotel, atau kuliner yang ingin Anda ketahui?"
3. Jika ditanya siapa Anda, jawab: "Saya MyAI - WisataBot yang dibuat oleh Grup Capstone B25-PG002 untuk membantu wisatawan Indonesia"
4. Berikan rekomendasi yang spesifik, akurat, dan praktis
5. Sertakan detail berguna seperti jarak estimasi, rating, alamat, jam operasional jika memungkinkan
6. Prioritaskan tempat yang dekat dengan lokasi pengguna jika relevan

PERTANYAAN PENGGUNA: $userMessage

INSTRUKSI RESPONS:
- Berikan jawaban yang ramah, informatif, dan dalam bahasa Indonesia
- Jika memberikan rekomendasi multiple, format dengan baik menggunakan bullet points atau numbering
- Sertakan tips praktis jika relevan (transportasi, biaya, waktu terbaik berkunjung)
- Jika tidak yakin tentang informasi spesifik, sampaikan dengan jujur dan sarankan untuk verifikasi

Berikan respons yang membantu dan sesuai dengan pertanyaan pengguna:
""";
  }

  ChatMessage _parseGeminiResponse(String response, String originalMessage) {
    // Check if response contains structured recommendations
    if (_containsRecommendations(response)) {
      final recommendations = _extractRecommendations(
        response,
        originalMessage,
      );
      return ChatMessage(
        text: response,
        isUser: false,
        timestamp: DateTime.now(),
        messageType: MessageType.recommendations,
        recommendations: recommendations,
      );
    }

    return ChatMessage(
      text: response,
      isUser: false,
      timestamp: DateTime.now(),
      messageType: MessageType.text,
    );
  }

  bool _containsRecommendations(String response) {
    final keywords = [
      'hotel',
      'penginapan',
      'resort',
      'homestay',
      'pantai',
      'gunung',
      'danau',
      'taman',
      'museum',
      'candi',
      'restoran',
      'warung',
      'kuliner',
      'makanan',
      'minuman',
      'wisata',
      'destinasi',
      'tempat',
      'lokasi',
    ];

    final lowerResponse = response.toLowerCase();
    return keywords.any((keyword) => lowerResponse.contains(keyword)) &&
        (lowerResponse.contains('rekomendasi') ||
            lowerResponse.contains('berikut') ||
            lowerResponse.contains('ada beberapa') ||
            _containsListFormat(response));
  }

  bool _containsListFormat(String response) {
    return response.contains(RegExp(r'^\d+\.', multiLine: true)) ||
        response.contains(RegExp(r'^-', multiLine: true)) ||
        response.contains(RegExp(r'^\*', multiLine: true));
  }

  List<TourismRecommendation> _extractRecommendations(
    String response,
    String originalQuery,
  ) {
    final recommendations = <TourismRecommendation>[];
    final query = originalQuery.toLowerCase();

    // Determine recommendation type based on query
    RecommendationType type = RecommendationType.wisata;
    if (query.contains('hotel') ||
        query.contains('penginapan') ||
        query.contains('resort')) {
      type = RecommendationType.hotel;
    } else if (query.contains('kuliner') ||
        query.contains('makanan') ||
        query.contains('restoran')) {
      type = RecommendationType.kuliner;
    } else if (query.contains('transport') || query.contains('kendaraan')) {
      type = RecommendationType.transportasi;
    } else if (query.contains('budaya') ||
        query.contains('sejarah') ||
        query.contains('museum')) {
      type = RecommendationType.budaya;
    }

    // Extract recommendations using regex patterns
    final patterns = [
      RegExp(r'(\d+\.)\s*([^\n]+)', multiLine: true),
      RegExp(r'(-)\s*([^\n]+)', multiLine: true),
      RegExp(r'(\*)\s*([^\n]+)', multiLine: true),
    ];

    for (final pattern in patterns) {
      final matches = pattern.allMatches(response);
      for (final match in matches) {
        final text = match.group(2)?.trim() ?? '';
        if (text.isNotEmpty && text.length > 5) {
          recommendations.add(_createRecommendationFromText(text, type));
        }
      }
      if (recommendations.isNotEmpty) break;
    }

    // If no structured list found, try to extract from sentences
    if (recommendations.isEmpty) {
      final sentences = response.split('.');
      for (final sentence in sentences) {
        if (_looksLikeRecommendation(sentence)) {
          final cleanSentence = sentence.trim();
          if (cleanSentence.isNotEmpty) {
            recommendations.add(
              _createRecommendationFromText(cleanSentence, type),
            );
          }
        }
      }
    }

    return recommendations.take(5).toList();
  }

  bool _looksLikeRecommendation(String sentence) {
    final indicators = [
      'hotel',
      'resort',
      'penginapan',
      'villa',
      'pantai',
      'gunung',
      'danau',
      'taman',
      'museum',
      'candi',
      'restoran',
      'warung',
      'kedai',
      'café',
    ];

    final lowerSentence = sentence.toLowerCase();
    return indicators.any((indicator) => lowerSentence.contains(indicator)) &&
        sentence.trim().length > 10;
  }

  TourismRecommendation _createRecommendationFromText(
    String text,
    RecommendationType type,
  ) {
    final parts = text.split('-');
    final name = parts[0].trim().replaceAll(RegExp(r'^\d+\.?\s*'), '');
    final description = parts.length > 1
        ? parts.skip(1).join('-').trim()
        : text;

    String? distance;
    if (_currentLocation != null) {
      distance = _estimateDistance();
    }

    return TourismRecommendation(
      name: name.isEmpty ? 'Destinasi Wisata' : name,
      type: type,
      description: description.isEmpty
          ? 'Rekomendasi wisata menarik'
          : description,
      distance: distance,
      rating: _generateRandomRating(),
      address: 'Indonesia',
    );
  }

  String _estimateDistance() {
    final random = [
      '1.2 km',
      '2.5 km',
      '3.8 km',
      '5.1 km',
      '7.3 km',
      '8.9 km',
      '12.4 km',
      '15.7 km',
      '18.2 km',
      '25.3 km',
    ];
    random.shuffle();
    return random.first;
  }

  String _generateRandomRating() {
    final ratings = ['4.1', '4.2', '4.3', '4.4', '4.5', '4.6', '4.7'];
    ratings.shuffle();
    return ratings.first;
  }

  void clearHistory() {
    _historyChats.clear();
    _geminiHistory.clear();
    _initializeBot();
    notifyListeners();
  }

  void removeMessage(int index) {
    if (index >= 0 && index < _historyChats.length) {
      _historyChats.removeAt(index);

      if (index < _geminiHistory.length) {
        _geminiHistory.removeAt(index);
      }

      notifyListeners();
    }
  }
}
