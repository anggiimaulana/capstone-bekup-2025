import 'package:flutter/material.dart';

enum RecommendationType { wisata, hotel, kuliner, transportasi, budaya }

RecommendationType _getRecommendationTypeFromCategory(String category) {
  final lowerCase = category.toLowerCase();
  if (lowerCase.contains('pantai') ||
      lowerCase.contains('gunung') ||
      lowerCase.contains('alam')) {
    return RecommendationType.wisata;
  }
  if (lowerCase.contains('museum') ||
      lowerCase.contains('sejarah') ||
      lowerCase.contains('budaya') ||
      lowerCase.contains('religi')) {
    return RecommendationType.budaya;
  }
  if (lowerCase.contains('kuliner')) {
    return RecommendationType.kuliner;
  }
  return RecommendationType.wisata;
}

class Destination {
  final int id;
  final RecommendationType type;
  final String name;
  final String location;
  final String province;
  final String city;
  final double rating;
  final String hours;
  final String price;
  final String distance;
  final String category;
  final String description;
  final String image;

  Destination({
    required this.id,
    required this.type,
    required this.name,
    required this.location,
    required this.province,
    required this.city,
    required this.rating,
    required this.hours,
    required this.price,
    required this.distance,
    required this.category,
    required this.description,
    required this.image,
  });

  factory Destination.fromMap(Map<String, dynamic> map) {
    // Penanganan Rating (Karena bisa Int/Double/Null)
    final dynamic rawRating = map['rating'];
    final double ratingValue = (rawRating is int)
        ? rawRating.toDouble()
        : (rawRating is double
              ? rawRating
              : 0.0); 

    final categoryString = (map['category'] as String?) ?? 'Wisata';

    return Destination(
      id: (map['id'] as int?) ?? -1,

      type: _getRecommendationTypeFromCategory(categoryString),

      name: (map['name'] as String?) ?? 'Destinasi Misterius',
      location: (map['location'] as String?) ?? '',
      province: (map['province'] as String?) ?? '',
      city: (map['city'] as String?) ?? '',

      rating: ratingValue, 
      hours: (map['hours'] as String?) ?? 'N/A',
      price: (map['price'] as String?) ?? 'Gratis',
      distance: (map['distance'] as String?) ?? '0 km',

      category: categoryString, 
      description:
          (map['description'] as String?) ?? 'Deskripsi tidak tersedia.',
      image:
          (map['image'] as String?) ??
          'assets/images/default_placeholder.jpg', 
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'province': province,
      'city': city,
      'rating': rating,
      'hours': hours,
      'price': price,
      'distance': distance,
      'category': category,
      'description': description,
      'image': image,
    };
  }

  String get typeDisplayName {
    switch (type) {
      case RecommendationType.wisata:
        return 'Wisata';
      case RecommendationType.hotel:
        return 'Hotel';
      case RecommendationType.kuliner:
        return 'Kuliner';
      case RecommendationType.transportasi:
        return 'Transportasi';
      case RecommendationType.budaya:
        return 'Budaya';
    }
  }

  String get typeIcon {
    switch (type) {
      case RecommendationType.wisata:
        return '🏞️';
      case RecommendationType.hotel:
        return '🏨';
      case RecommendationType.kuliner:
        return '🍽️';
      case RecommendationType.transportasi:
        return '🚗';
      case RecommendationType.budaya:
        return '🏛️';
    }
  }

  IconData get iconData {
    switch (type) {
      case RecommendationType.wisata:
        return Icons.place;
      case RecommendationType.hotel:
        return Icons.hotel;
      case RecommendationType.kuliner:
        return Icons.restaurant;
      case RecommendationType.transportasi:
        return Icons.directions_car;
      case RecommendationType.budaya:
        return Icons.account_balance;
    }
  }

  Color get primaryColor {
    switch (type) {
      case RecommendationType.wisata:
        return const Color(0xFF0077BE); // Ocean Blue
      case RecommendationType.hotel:
        return const Color(0xFF9C27B0); // Purple
      case RecommendationType.kuliner:
        return const Color(0xFFFF9800); // Orange
      case RecommendationType.transportasi:
        return const Color(0xFF4CAF50); // Green
      case RecommendationType.budaya:
        return const Color(0xFF795548); // Brown
    }
  }

  List<Color> get gradientColors {
    switch (type) {
      case RecommendationType.wisata:
        return [const Color(0xFF0077BE), const Color(0xFF00A8E8)];
      case RecommendationType.hotel:
        return [const Color(0xFF9C27B0), const Color(0xFFE1BEE7)];
      case RecommendationType.kuliner:
        return [const Color(0xFFFF9800), const Color(0xFFFFCC02)];
      case RecommendationType.transportasi:
        return [const Color(0xFF4CAF50), const Color(0xFF8BC34A)];
      case RecommendationType.budaya:
        return [const Color(0xFF795548), const Color(0xFFBCAAA4)];
    }
  }
}

const List<Map<String, dynamic>> kAllDestinations = [
  {
    'id': 1,
    'name': 'Pantai Karangsong',
    'location': 'Karangsong, Indramayu',
    'province': 'Jawa Barat',
    'city': 'Indramayu',
    'rating': 4.5,
    'hours': '24 Jam',
    'price': 'Gratis',
    'distance': '2.3 km',
    'category': 'Pantai',
    'description':
        'Pantai indah dengan hutan mangrove dan ombak yang tenang, cocok untuk keluarga.',
    'image': 'assets/images/karangsong.webp',
  },
  {
    'id': 2,
    'name': 'Museum Linggarjati',
    'location': 'Cilimus, Kuningan',
    'province': 'Jawa Barat',
    'city': 'Kuningan',
    'rating': 4.2,
    'hours': '08.00 - 16.00',
    'price': 'Rp 5.000',
    'distance': '15.2 km',
    'category': 'Museum',
    'description':
        'Museum bersejarah yang menyimpan peninggalan perjanjian Linggarjati.',
    'image': 'assets/images/museum_linggarjati.jpg',
  },
  {
    'id': 3,
    'name': 'Taman Sari Gua Sunyaragi',
    'location': 'Kesambi, Cirebon',
    'province': 'Jawa Barat',
    'city': 'Cirebon',
    'rating': 4.7,
    'hours': '08.00 - 17.00',
    'price': 'Rp 15.000',
    'distance': '8.5 km',
    'category': 'Sejarah',
    'description':
        'Kompleks gua buatan dengan arsitektur unik peninggalan Kesultanan Cirebon.',
    'image': 'assets/images/gua-sunyaragi.jpg',
  },
  {
    'id': 4,
    'name': 'Gunung Ciremai',
    'location': 'Kuningan, Jawa Barat',
    'province': 'Jawa Barat',
    'city': 'Kuningan',
    'rating': 4.8,
    'hours': '24 Jam',
    'price': 'Rp 10.000',
    'distance': '25.0 km',
    'category': 'Gunung',
    'description':
        'Gunung tertinggi di Jawa Barat dengan pemandangan spektakuler untuk pendakian.',
    'image': 'assets/images/ciremai.jpg',
  },
  {
    'id': 5,
    'name': 'Candi Borobudur',
    'location': 'Magelang, Jawa Tengah',
    'province': 'Jawa Tengah',
    'city': 'Magelang',
    'rating': 4.9,
    'hours': '06.00 - 17.00',
    'price': 'Rp 50.000',
    'distance': '150.0 km',
    'category': 'Religi',
    'description':
        'Candi Buddha terbesar di dunia, situs warisan dunia UNESCO, pusat ziarah umat Buddha.',
    'image': 'assets/images/candi-borobudur.jpg',
  },
  {
    'id': 6,
    'name': 'Jalan Malioboro',
    'location': 'Yogyakarta',
    'province': 'DI Yogyakarta',
    'city': 'Yogyakarta',
    'rating': 4.3,
    'hours': '24 Jam',
    'price': 'Gratis',
    'distance': '200.0 km',
    'category': 'Kuliner',
    'description':
        'Jalan utama dengan pusat perbelanjaan, seni, dan beragam kuliner khas Yogyakarta.',
    'image': 'assets/images/malioboro.jpg',
  },
  {
    'id': 7,
    'name': 'Danau Toba',
    'location': 'Samosir, Sumatera Utara',
    'province': 'Sumatera Utara',
    'city': 'Samosir',
    'rating': 4.7,
    'hours': '24 Jam',
    'price': 'Gratis',
    'distance': '1500.0 km',
    'category': 'Alam',
    'description':
        'Danau vulkanik terbesar di dunia dengan pemandangan perbukitan yang indah.',
    'image': 'assets/images/danau-toba.jpg',
  },
  {
    'id': 8,
    'name': 'Kawah Putih Ciwidey',
    'location': 'Rancabali, Bandung',
    'province': 'Jawa Barat',
    'city': 'Bandung',
    'rating': 4.6,
    'hours': '07.00 - 17.00',
    'price': 'Rp 28.000',
    'distance': '90.5 km',
    'category': 'Alam',
    'description':
        'Danau kawah dengan air berwarna putih kehijauan dan aroma belerang yang unik.',
    'image': 'assets/images/kawah-putih.jpg',
  },
  {
    'id': 9,
    'name': 'Istana Maimun',
    'location': 'Medan Maimun, Medan',
    'province': 'Sumatera Utara',
    'city': 'Medan',
    'rating': 4.4,
    'hours': '08.00 - 17.00',
    'price': 'Rp 10.000',
    'distance': '1600.0 km',
    'category': 'Sejarah',
    'description':
        'Istana peninggalan Kesultanan Deli, memadukan arsitektur Melayu, Mughal, dan Eropa.',
    'image': 'assets/images/istana-maimun.webp',
  },
  {
    'id': 10,
    'name': 'Pura Tanah Lot',
    'location': 'Tabanan, Bali',
    'province': 'Bali',
    'city': 'Tabanan',
    'rating': 4.8,
    'hours': '06.00 - 19.00',
    'price': 'Rp 30.000',
    'distance': '1200.0 km',
    'category': 'Religi',
    'description':
        'Pura ikonik di atas batu karang, tempat suci umat Hindu yang indah saat matahari terbenam.',
    'image': 'assets/images/pura-tanah-lot.jpg',
  },
  {
    'id': 11,
    'name': 'Museum Fatahillah',
    'location': 'Kota Tua, Jakarta',
    'province': 'DKI Jakarta',
    'city': 'Jakarta',
    'rating': 4.2,
    'hours': '09.00 - 15.00',
    'price': 'Rp 5.000',
    'distance': '300.0 km',
    'category': 'Museum',
    'description':
        'Museum sejarah Jakarta yang berlokasi di bangunan peninggalan era kolonial Belanda.',
    'image': 'assets/images/museum-fatahillah.jpg',
  },
  {
    'id': 12,
    'name': 'Uluwatu',
    'location': 'Pecatu, Badung, Bali',
    'province': 'Bali',
    'city': 'Badung',
    'rating': 4.7,
    'hours': '09.00 - 18.00',
    'price': 'Rp 40.000',
    'distance': '1250.0 km',
    'category': 'Budaya',
    'description':
        'Kawasan tebing tinggi dengan Pura Luhur Uluwatu yang terkenal dengan pertunjukan Tari Kecak.',
    'image': 'assets/images/uluwatu.jpg',
  },
  {
    'id': 13,
    'name': 'Gunung Bromo',
    'location': 'Taman Nasional Bromo Tengger Semeru',
    'province': 'Jawa Timur',
    'city': 'Probolinggo/Malang',
    'rating': 4.9,
    'hours': '24 Jam',
    'price': 'Rp 35.000',
    'distance': '750.0 km',
    'category': 'Gunung',
    'description':
        'Gunung berapi aktif dengan pemandangan sunrise yang legendaris di atas lautan pasir.',
    'image': 'assets/images/bromo.jpeg',
  },
  {
    'id': 14,
    'name': 'Coban Rondo Waterfall',
    'location': 'Pujon, Malang',
    'province': 'Jawa Timur',
    'city': 'Malang',
    'rating': 4.5,
    'hours': '08.00 - 17.00',
    'price': 'Rp 15.000',
    'distance': '600.0 km',
    'category': 'Alam',
    'description':
        'Air terjun dengan ketinggian sekitar 84 meter, dikelilingi hutan pinus yang sejuk.',
    'image': 'assets/images/coban-rondo.jpg',
  },
  {
    'id': 15,
    'name': 'Kota Tua Jakarta',
    'location': 'Pinangsia, Jakarta Barat',
    'province': 'DKI Jakarta',
    'city': 'Jakarta',
    'rating': 4.6,
    'hours': '24 Jam',
    'price': 'Gratis',
    'distance': '300.0 km',
    'category': 'Budaya',
    'description':
        'Kawasan pusat sejarah Jakarta dengan bangunan-bangunan kolonial yang terawat baik.',
    'image': 'assets/images/kota-tua.jpg',
  },
  {
    'id': 16,
    'name': 'Lawang Sewu',
    'location': 'Semarang Tengah',
    'province': 'Jawa Tengah',
    'city': 'Semarang',
    'rating': 4.3,
    'hours': '07.00 - 21.00',
    'price': 'Rp 10.000',
    'distance': '450.0 km',
    'category': 'Sejarah',
    'description':
        'Bangunan bersejarah peninggalan Belanda dengan arsitektur unik dan ribuan jendela.',
    'image': 'assets/images/lawang-sewu.webp',
  },
  {
    'id': 17,
    'name': 'Gereja Blenduk',
    'location': 'Kota Lama, Semarang',
    'province': 'Jawa Tengah',
    'city': 'Semarang',
    'rating': 4.5,
    'hours': '09.00 - 17.00',
    'price': 'Gratis',
    'distance': '455.0 km',
    'category': 'Religi',
    'description':
        'Gereja Kristen tertua di Jawa Tengah dengan arsitektur khas Eropa dan kubah besar (blenduk).',
    'image': 'assets/images/gereja-blenduk.jpg',
  },
  {
    'id': 18,
    'name': 'Jatiluwih Rice Terraces',
    'location': 'Tabanan, Bali',
    'province': 'Bali',
    'city': 'Tabanan',
    'rating': 4.8,
    'hours': '08.00 - 18.00',
    'price': 'Rp 40.000',
    'distance': '1190.0 km',
    'category': 'Budaya',
    'description':
        'Sawah terasering subak yang diakui UNESCO, melambangkan sistem irigasi tradisional Bali.',
    'image': 'assets/images/rice-terraces.jpg',
  },
  {
    'id': 19,
    'name': 'Pantai Pink (Pink Beach)',
    'location': 'Pulau Komodo, NTT',
    'province': 'Nusa Tenggara Timur',
    'city': 'Labuan Bajo',
    'rating': 4.9,
    'hours': '24 Jam',
    'price': 'Bervariasi',
    'distance': '2550.0 km',
    'category': 'Pantai',
    'description':
        'Salah satu dari tujuh pantai berpasir merah muda di dunia, ideal untuk *snorkeling*.',
    'image': 'assets/images/pink-beach.jpg',
  },
  {
    'id': 20,
    'name': 'Tangkuban Perahu',
    'location': 'Lembang, Bandung',
    'province': 'Jawa Barat',
    'city': 'Bandung',
    'rating': 4.5,
    'hours': '07.00 - 17.00',
    'price': 'Rp 20.000',
    'distance': '110.0 km',
    'category': 'Gunung',
    'description':
        'Gunung berapi aktif dengan kawah yang bisa dikunjungi, terkenal dengan legenda Sangkuriang.',
    'image': 'assets/images/tangkuban-perahu.jpg',
  },
];
