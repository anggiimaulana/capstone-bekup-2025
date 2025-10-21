// models/tourism_recommendation.dart
import 'package:flutter/material.dart';

enum RecommendationType { wisata, hotel, kuliner, transportasi, budaya }

class TourismRecommendation {
  final String name;
  final RecommendationType type;
  final String description;
  final String? distance;
  final String? rating;
  final String? address;
  final String? phoneNumber;
  final String? website;
  final double? latitude;
  final double? longitude;
  final List<String>? images;
  final List<String>? facilities;
  final String? priceRange;
  final String? openHours;

  TourismRecommendation({
    required this.name,
    required this.type,
    required this.description,
    this.distance,
    this.rating,
    this.address,
    this.phoneNumber,
    this.website,
    this.latitude,
    this.longitude,
    this.images,
    this.facilities,
    this.priceRange,
    this.openHours,
  });

  factory TourismRecommendation.fromJson(Map<String, dynamic> json) {
    return TourismRecommendation(
      name: json['name'] ?? '',
      type: RecommendationType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
        orElse: () => RecommendationType.wisata,
      ),
      description: json['description'] ?? '',
      distance: json['distance'],
      rating: json['rating'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      website: json['website'],
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      images: json['images']?.cast<String>(),
      facilities: json['facilities']?.cast<String>(),
      priceRange: json['priceRange'],
      openHours: json['openHours'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type.toString().split('.').last,
      'description': description,
      'distance': distance,
      'rating': rating,
      'address': address,
      'phoneNumber': phoneNumber,
      'website': website,
      'latitude': latitude,
      'longitude': longitude,
      'images': images,
      'facilities': facilities,
      'priceRange': priceRange,
      'openHours': openHours,
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

// Helper class for creating sample recommendations
class TourismSamples {
  static List<TourismRecommendation> getWisataSamples() {
    return [
      TourismRecommendation(
        name: "Pantai Karangsong",
        type: RecommendationType.wisata,
        description: "Pantai indah dengan sunset menawan dan ombak tenang",
        distance: "5.2 km",
        rating: "4.3",
        address: "Karangsong, Indramayu, Jawa Barat",
      ),
      TourismRecommendation(
        name: "Pantai Tirtamaya",
        type: RecommendationType.wisata,
        description:
            "Pantai dengan fasilitas lengkap dan area bermain keluarga",
        distance: "8.1 km",
        rating: "4.1",
        address: "Tirtamaya, Indramayu, Jawa Barat",
      ),
    ];
  }

  static List<TourismRecommendation> getHotelSamples() {
    return [
      TourismRecommendation(
        name: "Hotel Horison Indramayu",
        type: RecommendationType.hotel,
        description: "Hotel bintang 4 dengan fasilitas lengkap di pusat kota",
        distance: "3.5 km",
        rating: "4.2",
        address: "Jl. Yos Sudarso, Indramayu",
        priceRange: "Rp 500.000 - 800.000",
        facilities: ["WiFi", "AC", "Kolam Renang", "Restaurant", "Gym"],
      ),
      TourismRecommendation(
        name: "Aston Indramayu Hotel",
        type: RecommendationType.hotel,
        description: "Hotel modern dengan pelayanan berkualitas international",
        distance: "4.2 km",
        rating: "4.0",
        address: "Jl. Jend. Ahmad Yani, Indramayu",
        priceRange: "Rp 400.000 - 650.000",
        facilities: ["WiFi", "AC", "Restaurant", "Meeting Room"],
      ),
    ];
  }

  static List<TourismRecommendation> getKulinerSamples() {
    return [
      TourismRecommendation(
        name: "Nasi Lengko Bu Tari",
        type: RecommendationType.kuliner,
        description:
            "Nasi lengko autentik khas Cirebon dengan bumbu rempah pilihan",
        distance: "2.1 km",
        rating: "4.5",
        address: "Jl. Siliwangi, Indramayu",
        priceRange: "Rp 15.000 - 25.000",
        openHours: "07:00 - 15:00",
      ),
      TourismRecommendation(
        name: "Empal Gentong H. Apud",
        type: RecommendationType.kuliner,
        description:
            "Empal gentong legendaris dengan kuah gurih dan daging empuk",
        distance: "3.8 km",
        rating: "4.4",
        address: "Jl. Pemuda, Indramayu",
        priceRange: "Rp 20.000 - 35.000",
        openHours: "08:00 - 20:00",
      ),
    ];
  }
}
