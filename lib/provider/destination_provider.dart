import 'package:capstone/model/destination.dart';
import 'package:flutter/material.dart';

class DestinationProvider extends ChangeNotifier {
  // Semua destinasi yang tersedia
  final List<Destination> _allDestinations = kAllDestinations
      .map((e) => Destination.fromMap(e))
      .toList();

  // Destinasi setelah di filter dan sort (semua)
  List<Destination> _currentFilteredAndSorted = [];

  // Destinasi yang akan ditampilkan di UI (pagination)
  List<Destination> _displayedDestinations = [];

  // Muat 5 data pertama dan berikutnya
  static const int _initialLimit = 5;
  static const int _loadMoreLimit = 5;

  int _currentLimit = _initialLimit;
  bool _isLoadingMore = false;
  String _currentSort = 'Terpopuler';
  Map<String, dynamic> _activeFilters = {};

  // Getters untuk UI
  List<Destination> get displayedDestinations => _displayedDestinations;
  bool get isLoadingMore => _isLoadingMore;
  bool get hasMoreData =>
      _displayedDestinations.length < _currentFilteredAndSorted.length;
  String get currentSort => _currentSort;
  Map<String, dynamic> get activeFilters => _activeFilters;

  DestinationProvider() {
    // Inisialisasi awal saat provider dibuat
    _applyFiltersAndSort();
    _loadInitialDestinations();
  }

  // Logic Infinite Scrolling
  void _loadInitialDestinations() {
    _currentLimit = _initialLimit;
    _displayedDestinations = _currentFilteredAndSorted
        .take(_currentLimit)
        .toList();
    notifyListeners();
  }

  Future<void> loadMoreDestinations() async {
    if (_isLoadingMore || !hasMoreData) return;

    _isLoadingMore = true;
    notifyListeners();

    // Simulasi jeda loading data dari API/DB
    await Future.delayed(const Duration(milliseconds: 500));

    // Tambah limit
    _currentLimit += _loadMoreLimit;
    if (_currentLimit > _currentFilteredAndSorted.length) {
      _currentLimit = _currentFilteredAndSorted.length;
    }

    _displayedDestinations = _currentFilteredAndSorted
        .take(_currentLimit)
        .toList();
    _isLoadingMore = false;
    notifyListeners();
  }

  // Logic Filter, Sort & Parsing 
  void setFilters(Map<String, dynamic> filters) {
    _activeFilters = filters;
    _applyFiltersAndSort();
  }

  void setSort(String sort) {
    _currentSort = sort;
    _applyFiltersAndSort();
  }

  void _applyFiltersAndSort({String? searchKeyword}) {
    List<Destination> filtered = _allDestinations.where((destination) {
      // Logic Search
      if (searchKeyword != null && searchKeyword.isNotEmpty) {
        String lowerCaseSearch = searchKeyword.toLowerCase();
        if (!destination.name.toLowerCase().contains(lowerCaseSearch) &&
            !destination.location.toLowerCase().contains(lowerCaseSearch) &&
            !destination.category.toLowerCase().contains(lowerCaseSearch) &&
            !destination.description.toLowerCase().contains(lowerCaseSearch)) {
          return false;
        }
      }

      // Logic Filter
      if (_activeFilters.isNotEmpty) {
        // Province filter
        if (_activeFilters.containsKey('province') &&
            destination.province != _activeFilters['province']) {
          return false;
        }
        // Category filter
        if (_activeFilters.containsKey('category') &&
            destination.category != _activeFilters['category']) {
          return false;
        }
        // Minimum rating filter
        if (_activeFilters.containsKey('min_rating')) {
          double minRating = _activeFilters['min_rating'];
          if (destination.rating < minRating) {
            return false;
          }
        }
        // Price range filter
        if (_activeFilters.containsKey('price_range')) {
          String priceRange = _activeFilters['price_range'];
          if (!_priceRangeMatches(destination.price, priceRange)) {
            return false;
          }
        }
        // Max distance filter
        if (_activeFilters.containsKey('max_distance')) {
          double maxDistance = _activeFilters['max_distance'];
          double distance = _parseDistance(destination.distance);
          if (distance > maxDistance) {
            return false;
          }
        }
      }
      return true;
    }).toList();

    // Apply sorting
    filtered.sort(_sortComparator);

    _currentFilteredAndSorted = filtered;
    // Reset pagination setelah filter/sort
    _loadInitialDestinations(); 
  }

  // Metode untuk Search
  void searchDestinations(String keyword) {
    _applyFiltersAndSort(searchKeyword: keyword);
  }

  // Utility Parsing Methods
  bool _priceRangeMatches(String price, String range) {
    if (range == 'Gratis') {
      return price.toLowerCase() == 'gratis';
    }
    double? priceValue = _parsePrice(price);
    if (priceValue == null) return false;

    if (range == '< Rp 10.000') {
      return priceValue < 10000;
    } else if (range == 'Rp 10.000 - Rp 50.000') {
      return priceValue >= 10000 && priceValue <= 50000;
    } else if (range == 'Rp 50.000 - Rp 100.000') {
      return priceValue > 50000 && priceValue <= 100000;
    } else if (range == '> Rp 100.000') {
      return priceValue > 100000;
    }
    return true;
  }

  double? _parsePrice(String price) {
    try {
      if (price.toLowerCase() == 'gratis' ||
          price.toLowerCase() == 'bervariasi')
        return 0;
      String cleaned = price.replaceAll(RegExp(r'[^0-9]'), '');
      return double.tryParse(cleaned);
    } catch (e) {
      return null;
    }
  }

  double _parseDistance(String distance) {
    try {
      String cleaned = distance.toLowerCase().replaceAll(
        RegExp(r'[^0-9.]'),
        '',
      );
      return double.parse(cleaned);
    } catch (e) {
      return double.infinity;
    }
  }

  int _sortComparator(Destination a, Destination b) {
    switch (_currentSort) {
      case 'Terpopuler':
      case 'Rating Tertinggi':
        return b.rating.compareTo(a.rating);
      case 'Terdekat':
        return _parseDistance(a.distance).compareTo(_parseDistance(b.distance));
      case 'Harga Termurah':
        double aPrice = _parsePrice(a.price) ?? double.infinity;
        double bPrice = _parsePrice(b.price) ?? double.infinity;
        return aPrice.compareTo(bPrice);
      case 'Harga Termahal':
        double aPrice = _parsePrice(a.price) ?? 0;
        double bPrice = _parsePrice(b.price) ?? 0;
        return bPrice.compareTo(aPrice);
      default:
        return 0;
    }
  }
}
