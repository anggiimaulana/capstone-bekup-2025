import 'package:flutter/material.dart';

// Model untuk Fasilitas
class Facility {
  final IconData icon;
  final String label;
  final bool available;

  Facility({required this.icon, required this.label, required this.available});
}

// Model untuk Review
class Review {
  final String name;
  final int rating;
  final String date;
  final String comment;
  final String avatar;
  final bool verified;

  Review({
    required this.name,
    required this.rating,
    required this.date,
    required this.comment,
    required this.avatar,
    required this.verified,
  });
}

// Model untuk UMKM
class UmkmProduct {
  final String name;
  final String category;
  final String price;
  final String owner;
  final double rating;

  UmkmProduct({
    required this.name,
    required this.category,
    required this.price,
    required this.owner,
    required this.rating,
  });
}

class TourismDetailData {
  static List<Facility> getFacilitiesByDestinationId(int id) {
    final facilitiesMap = {
      1: [
        // Pantai Karangsong
        Facility(icon: Icons.local_parking, label: 'Parkir', available: true),
        Facility(icon: Icons.restaurant, label: 'Restoran', available: true),
        Facility(icon: Icons.wc, label: 'Toilet', available: true),
        Facility(icon: Icons.local_atm, label: 'ATM', available: false),
        Facility(icon: Icons.wifi, label: 'WiFi', available: false),
        Facility(icon: Icons.camera_alt, label: 'Foto Spot', available: true),
        Facility(
          icon: Icons.accessible,
          label: 'Akses Difabel',
          available: false,
        ),
        Facility(
          icon: Icons.family_restroom,
          label: 'Area Keluarga',
          available: true,
        ),
      ],
      2: [
        // Museum Linggarjati
        Facility(icon: Icons.local_parking, label: 'Parkir', available: true),
        Facility(icon: Icons.restaurant, label: 'Restoran', available: false),
        Facility(icon: Icons.wc, label: 'Toilet', available: true),
        Facility(icon: Icons.local_atm, label: 'ATM', available: false),
        Facility(icon: Icons.wifi, label: 'WiFi', available: true),
        Facility(icon: Icons.camera_alt, label: 'Foto Spot', available: true),
        Facility(
          icon: Icons.accessible,
          label: 'Akses Difabel',
          available: true,
        ),
        Facility(icon: Icons.museum, label: 'Guide Wisata', available: true),
      ],
      3: [
        // Taman Sari Gua Sunyaragi
        Facility(icon: Icons.local_parking, label: 'Parkir', available: true),
        Facility(icon: Icons.restaurant, label: 'Restoran', available: true),
        Facility(icon: Icons.wc, label: 'Toilet', available: true),
        Facility(icon: Icons.local_atm, label: 'ATM', available: true),
        Facility(icon: Icons.wifi, label: 'WiFi', available: true),
        Facility(icon: Icons.camera_alt, label: 'Foto Spot', available: true),
        Facility(
          icon: Icons.accessible,
          label: 'Akses Difabel',
          available: false,
        ),
        Facility(
          icon: Icons.shopping_bag,
          label: 'Toko Souvenir',
          available: true,
        ),
      ],
      4: [
        // Gunung Ciremai
        Facility(icon: Icons.local_parking, label: 'Parkir', available: true),
        Facility(icon: Icons.restaurant, label: 'Warung', available: true),
        Facility(icon: Icons.wc, label: 'Toilet', available: true),
        Facility(icon: Icons.local_atm, label: 'ATM', available: false),
        Facility(icon: Icons.wifi, label: 'WiFi', available: false),
        Facility(icon: Icons.hiking, label: 'Pos Pendakian', available: true),
        Facility(icon: Icons.local_hospital, label: 'P3K', available: true),
        Facility(icon: Icons.hotel, label: 'Camping Ground', available: true),
      ],
      5: [
        // Candi Borobudur
        Facility(icon: Icons.local_parking, label: 'Parkir', available: true),
        Facility(icon: Icons.restaurant, label: 'Restoran', available: true),
        Facility(icon: Icons.wc, label: 'Toilet', available: true),
        Facility(icon: Icons.local_atm, label: 'ATM', available: true),
        Facility(icon: Icons.wifi, label: 'WiFi', available: true),
        Facility(icon: Icons.camera_alt, label: 'Foto Spot', available: true),
        Facility(
          icon: Icons.accessible,
          label: 'Akses Difabel',
          available: true,
        ),
        Facility(icon: Icons.tour, label: 'Tour Guide', available: true),
      ],
      6: [
        // Jalan Malioboro
        Facility(icon: Icons.local_parking, label: 'Parkir', available: true),
        Facility(icon: Icons.restaurant, label: 'Restoran', available: true),
        Facility(icon: Icons.wc, label: 'Toilet Umum', available: true),
        Facility(icon: Icons.local_atm, label: 'ATM', available: true),
        Facility(icon: Icons.wifi, label: 'WiFi Gratis', available: true),
        Facility(
          icon: Icons.shopping_cart,
          label: 'Pusat Belanja',
          available: true,
        ),
        Facility(
          icon: Icons.accessible,
          label: 'Akses Difabel',
          available: true,
        ),
        Facility(
          icon: Icons.directions_bus,
          label: 'Transportasi',
          available: true,
        ),
      ],
      7: [
        // Danau Toba
        Facility(icon: Icons.local_parking, label: 'Parkir', available: true),
        Facility(icon: Icons.restaurant, label: 'Restoran', available: true),
        Facility(icon: Icons.wc, label: 'Toilet', available: true),
        Facility(icon: Icons.local_atm, label: 'ATM', available: true),
        Facility(icon: Icons.wifi, label: 'WiFi', available: true),
        Facility(
          icon: Icons.directions_boat,
          label: 'Dermaga',
          available: true,
        ),
        Facility(icon: Icons.hotel, label: 'Penginapan', available: true),
        Facility(icon: Icons.pool, label: 'Area Berenang', available: true),
      ],
      8: [
        // Kawah Putih Ciwidey
        Facility(icon: Icons.local_parking, label: 'Parkir', available: true),
        Facility(icon: Icons.restaurant, label: 'Kantin', available: true),
        Facility(icon: Icons.wc, label: 'Toilet', available: true),
        Facility(icon: Icons.local_atm, label: 'ATM', available: false),
        Facility(icon: Icons.wifi, label: 'WiFi', available: false),
        Facility(icon: Icons.camera_alt, label: 'Foto Spot', available: true),
        Facility(
          icon: Icons.shopping_bag,
          label: 'Toko Souvenir',
          available: true,
        ),
        Facility(
          icon: Icons.directions_car,
          label: 'Shuttle Bus',
          available: true,
        ),
      ],
      9: [
        // Istana Maimun
        Facility(icon: Icons.local_parking, label: 'Parkir', available: true),
        Facility(icon: Icons.restaurant, label: 'Kafe', available: true),
        Facility(icon: Icons.wc, label: 'Toilet', available: true),
        Facility(icon: Icons.local_atm, label: 'ATM', available: true),
        Facility(icon: Icons.wifi, label: 'WiFi', available: true),
        Facility(icon: Icons.camera_alt, label: 'Foto Spot', available: true),
        Facility(
          icon: Icons.accessible,
          label: 'Akses Difabel',
          available: true,
        ),
        Facility(icon: Icons.history_edu, label: 'Museum', available: true),
      ],
      10: [
        // Pura Tanah Lot
        Facility(icon: Icons.local_parking, label: 'Parkir', available: true),
        Facility(icon: Icons.restaurant, label: 'Restoran', available: true),
        Facility(icon: Icons.wc, label: 'Toilet', available: true),
        Facility(icon: Icons.local_atm, label: 'ATM', available: true),
        Facility(icon: Icons.wifi, label: 'WiFi', available: true),
        Facility(icon: Icons.camera_alt, label: 'Foto Spot', available: true),
        Facility(
          icon: Icons.shopping_bag,
          label: 'Art Market',
          available: true,
        ),
        Facility(
          icon: Icons.theater_comedy,
          label: 'Cultural Show',
          available: true,
        ),
      ],
      11: [
        // Museum Fatahillah
        Facility(icon: Icons.local_parking, label: 'Parkir', available: true),
        Facility(icon: Icons.restaurant, label: 'Kafe', available: true),
        Facility(icon: Icons.wc, label: 'Toilet', available: true),
        Facility(icon: Icons.local_atm, label: 'ATM', available: true),
        Facility(icon: Icons.wifi, label: 'WiFi', available: true),
        Facility(icon: Icons.camera_alt, label: 'Foto Spot', available: true),
        Facility(
          icon: Icons.accessible,
          label: 'Akses Difabel',
          available: true,
        ),
        Facility(
          icon: Icons.library_books,
          label: 'Perpustakaan',
          available: true,
        ),
      ],
      12: [
        // Uluwatu
        Facility(icon: Icons.local_parking, label: 'Parkir', available: true),
        Facility(icon: Icons.restaurant, label: 'Restoran', available: true),
        Facility(icon: Icons.wc, label: 'Toilet', available: true),
        Facility(icon: Icons.local_atm, label: 'ATM', available: true),
        Facility(icon: Icons.wifi, label: 'WiFi', available: true),
        Facility(icon: Icons.camera_alt, label: 'Foto Spot', available: true),
        Facility(
          icon: Icons.theater_comedy,
          label: 'Tari Kecak',
          available: true,
        ),
        Facility(
          icon: Icons.shopping_bag,
          label: 'Souvenir Shop',
          available: true,
        ),
      ],
      13: [
        // Gunung Bromo
        Facility(icon: Icons.local_parking, label: 'Parkir', available: true),
        Facility(icon: Icons.restaurant, label: 'Warung', available: true),
        Facility(icon: Icons.wc, label: 'Toilet', available: true),
        Facility(icon: Icons.local_atm, label: 'ATM', available: false),
        Facility(icon: Icons.wifi, label: 'WiFi', available: false),
        Facility(
          icon: Icons.directions_car,
          label: 'Sewa Jeep',
          available: true,
        ),
        Facility(icon: Icons.hotel, label: 'Homestay', available: true),
        Facility(icon: Icons.hiking, label: 'View Point', available: true),
      ],
      14: [
        // Coban Rondo Waterfall
        Facility(icon: Icons.local_parking, label: 'Parkir', available: true),
        Facility(icon: Icons.restaurant, label: 'Kantin', available: true),
        Facility(icon: Icons.wc, label: 'Toilet', available: true),
        Facility(icon: Icons.local_atm, label: 'ATM', available: false),
        Facility(icon: Icons.wifi, label: 'WiFi', available: true),
        Facility(icon: Icons.camera_alt, label: 'Foto Spot', available: true),
        Facility(icon: Icons.park, label: 'Area Piknik', available: true),
        Facility(icon: Icons.forest, label: 'Hutan Pinus', available: true),
      ],
      15: [
        // Kota Tua Jakarta
        Facility(icon: Icons.local_parking, label: 'Parkir', available: true),
        Facility(
          icon: Icons.restaurant,
          label: 'Kafe & Resto',
          available: true,
        ),
        Facility(icon: Icons.wc, label: 'Toilet', available: true),
        Facility(icon: Icons.local_atm, label: 'ATM', available: true),
        Facility(icon: Icons.wifi, label: 'WiFi', available: true),
        Facility(
          icon: Icons.directions_bike,
          label: 'Sewa Sepeda',
          available: true,
        ),
        Facility(icon: Icons.museum, label: 'Museum', available: true),
        Facility(icon: Icons.shopping_bag, label: 'Toko Seni', available: true),
      ],
      16: [
        // Lawang Sewu
        Facility(icon: Icons.local_parking, label: 'Parkir', available: true),
        Facility(icon: Icons.restaurant, label: 'Kantin', available: true),
        Facility(icon: Icons.wc, label: 'Toilet', available: true),
        Facility(icon: Icons.local_atm, label: 'ATM', available: true),
        Facility(icon: Icons.wifi, label: 'WiFi', available: true),
        Facility(icon: Icons.camera_alt, label: 'Foto Spot', available: true),
        Facility(
          icon: Icons.accessible,
          label: 'Akses Difabel',
          available: false,
        ),
        Facility(icon: Icons.tour, label: 'Tour Guide', available: true),
      ],
      17: [
        // Gereja Blenduk
        Facility(icon: Icons.local_parking, label: 'Parkir', available: true),
        Facility(icon: Icons.restaurant, label: 'Kafe', available: true),
        Facility(icon: Icons.wc, label: 'Toilet', available: true),
        Facility(icon: Icons.local_atm, label: 'ATM', available: true),
        Facility(icon: Icons.wifi, label: 'WiFi', available: true),
        Facility(icon: Icons.camera_alt, label: 'Foto Spot', available: true),
        Facility(
          icon: Icons.accessible,
          label: 'Akses Difabel',
          available: true,
        ),
        Facility(icon: Icons.info, label: 'Info Center', available: true),
      ],
      18: [
        // Jatiluwih Rice Terraces
        Facility(icon: Icons.local_parking, label: 'Parkir', available: true),
        Facility(icon: Icons.restaurant, label: 'Restoran', available: true),
        Facility(icon: Icons.wc, label: 'Toilet', available: true),
        Facility(icon: Icons.local_atm, label: 'ATM', available: false),
        Facility(icon: Icons.wifi, label: 'WiFi', available: true),
        Facility(icon: Icons.camera_alt, label: 'Foto Spot', available: true),
        Facility(
          icon: Icons.directions_walk,
          label: 'Trekking Path',
          available: true,
        ),
        Facility(
          icon: Icons.shopping_bag,
          label: 'Toko Lokal',
          available: true,
        ),
      ],
      19: [
        // Pantai Pink
        Facility(
          icon: Icons.directions_boat,
          label: 'Dermaga',
          available: true,
        ),
        Facility(icon: Icons.restaurant, label: 'Warung', available: true),
        Facility(icon: Icons.wc, label: 'Toilet', available: true),
        Facility(icon: Icons.local_atm, label: 'ATM', available: false),
        Facility(icon: Icons.wifi, label: 'WiFi', available: false),
        Facility(icon: Icons.pool, label: 'Snorkeling', available: true),
        Facility(icon: Icons.camera_alt, label: 'Foto Spot', available: true),
        Facility(icon: Icons.tour, label: 'Tour Guide', available: true),
      ],
      20: [
        // Tangkuban Perahu
        Facility(icon: Icons.local_parking, label: 'Parkir', available: true),
        Facility(icon: Icons.restaurant, label: 'Warung', available: true),
        Facility(icon: Icons.wc, label: 'Toilet', available: true),
        Facility(icon: Icons.local_atm, label: 'ATM', available: false),
        Facility(icon: Icons.wifi, label: 'WiFi', available: false),
        Facility(icon: Icons.camera_alt, label: 'Foto Spot', available: true),
        Facility(
          icon: Icons.shopping_bag,
          label: 'Toko Souvenir',
          available: true,
        ),
        Facility(
          icon: Icons.directions_car,
          label: 'Jalur Kendaraan',
          available: true,
        ),
      ],
    };

    // Default facilities
    return facilitiesMap[id] ??
        [
          Facility(icon: Icons.local_parking, label: 'Parkir', available: true),
          Facility(icon: Icons.restaurant, label: 'Restoran', available: true),
          Facility(icon: Icons.wc, label: 'Toilet', available: true),
          Facility(icon: Icons.camera_alt, label: 'Foto Spot', available: true),
        ];
  }

  // ============ MAPPING UMKM LENGKAP (20 DESTINASI) ============
  static List<UmkmProduct> getUmkmByDestinationId(int id) {
    final umkmMap = {
      1: [
        // Pantai Karangsong - UMKM Indramayu
        UmkmProduct(
          name: 'Kerupuk Ikan Karangsong',
          category: 'Makanan',
          price: 'Rp 25.000/kg',
          owner: 'Ibu Lastri',
          rating: 4.7,
        ),
        UmkmProduct(
          name: 'Kerajinan Rajut Pantai',
          category: 'Kerajinan',
          price: 'Rp 35.000 - 150.000',
          owner: 'Kelompok Rajut Karangsong',
          rating: 4.5,
        ),
        UmkmProduct(
          name: 'Abon Ikan',
          category: 'Makanan',
          price: 'Rp 40.000/250gr',
          owner: 'Ibu Siti',
          rating: 4.8,
        ),
        UmkmProduct(
          name: 'Gantungan Kunci Mangrove',
          category: 'Souvenir',
          price: 'Rp 15.000',
          owner: 'Pak Dedi',
          rating: 4.3,
        ),
      ],
      2: [
        // Museum Linggarjati - UMKM Kuningan
        UmkmProduct(
          name: 'Kopi Linggarjati',
          category: 'Minuman',
          price: 'Rp 35.000/250gr',
          owner: 'Kelompok Tani Cilimus',
          rating: 4.6,
        ),
        UmkmProduct(
          name: 'Batik Tulis Kuningan',
          category: 'Fashion',
          price: 'Rp 250.000 - 500.000',
          owner: 'Sanggar Batik Cigugur',
          rating: 4.8,
        ),
        UmkmProduct(
          name: 'Madu Hutan Ciremai',
          category: 'Makanan',
          price: 'Rp 85.000/500ml',
          owner: 'Pak Ahmad',
          rating: 4.9,
        ),
        UmkmProduct(
          name: 'Keripik Singkong Pedas',
          category: 'Makanan',
          price: 'Rp 18.000/pack',
          owner: 'Ibu Ria',
          rating: 4.5,
        ),
      ],
      3: [
        // Taman Sari Gua Sunyaragi - UMKM Cirebon
        UmkmProduct(
          name: 'Batik Trusmi',
          category: 'Fashion',
          price: 'Rp 150.000 - 1.000.000',
          owner: 'Sanggar Batik Trusmi',
          rating: 4.9,
        ),
        UmkmProduct(
          name: 'Empal Gentong Instant',
          category: 'Makanan',
          price: 'Rp 45.000/pack',
          owner: 'Ibu Yuni',
          rating: 4.6,
        ),
        UmkmProduct(
          name: 'Kerajinan Rotan Cirebon',
          category: 'Kerajinan',
          price: 'Rp 75.000 - 500.000',
          owner: 'UD Rotan Jaya',
          rating: 4.7,
        ),
        UmkmProduct(
          name: 'Terasi Udang Premium',
          category: 'Bumbu',
          price: 'Rp 30.000/250gr',
          owner: 'Pak Hendra',
          rating: 4.5,
        ),
      ],
      4: [
        // Gunung Ciremai - UMKM Kuningan
        UmkmProduct(
          name: 'Kopi Arabica Ciremai',
          category: 'Minuman',
          price: 'Rp 55.000/250gr',
          owner: 'Kelompok Tani Ciremai',
          rating: 4.8,
        ),
        UmkmProduct(
          name: 'Jahe Merah Instan',
          category: 'Minuman',
          price: 'Rp 25.000/box',
          owner: 'Ibu Neneng',
          rating: 4.6,
        ),
        UmkmProduct(
          name: 'Stick Talas Kuningan',
          category: 'Makanan',
          price: 'Rp 20.000/pack',
          owner: 'UD Talas Makmur',
          rating: 4.4,
        ),
        UmkmProduct(
          name: 'Kaos Pendaki Ciremai',
          category: 'Fashion',
          price: 'Rp 75.000',
          owner: 'Ciremai Outdoor',
          rating: 4.5,
        ),
      ],
      5: [
        // Candi Borobudur - UMKM Magelang
        UmkmProduct(
          name: 'Miniatur Candi Borobudur',
          category: 'Souvenir',
          price: 'Rp 50.000 - 500.000',
          owner: 'UD Souvenir Borobudur',
          rating: 4.8,
        ),
        UmkmProduct(
          name: 'Batik Borobudur',
          category: 'Fashion',
          price: 'Rp 200.000 - 750.000',
          owner: 'Galeri Batik Mendut',
          rating: 4.7,
        ),
        UmkmProduct(
          name: 'Getuk Trio Magelang',
          category: 'Makanan',
          price: 'Rp 35.000/box',
          owner: 'Ibu Sri',
          rating: 4.6,
        ),
        UmkmProduct(
          name: 'Kerajinan Perak',
          category: 'Aksesoris',
          price: 'Rp 150.000 - 2.000.000',
          owner: 'Toko Perak Muntilan',
          rating: 4.9,
        ),
      ],
      6: [
        // Jalan Malioboro - UMKM Yogyakarta
        UmkmProduct(
          name: 'Batik Tulis Yogyakarta',
          category: 'Fashion',
          price: 'Rp 250.000 - 2.000.000',
          owner: 'Batik Winotosastro',
          rating: 4.9,
        ),
        UmkmProduct(
          name: 'Bakpia Pathok',
          category: 'Makanan',
          price: 'Rp 35.000/box',
          owner: 'Bakpia Kurnia Sari',
          rating: 4.8,
        ),
        UmkmProduct(
          name: 'Gudeg Kaleng',
          category: 'Makanan',
          price: 'Rp 25.000/kaleng',
          owner: 'Bu Tjitro',
          rating: 4.7,
        ),
        UmkmProduct(
          name: 'Kerajinan Kulit',
          category: 'Kerajinan',
          price: 'Rp 100.000 - 800.000',
          owner: 'Manding Leather',
          rating: 4.6,
        ),
      ],
      7: [
        // Danau Toba - UMKM Samosir
        UmkmProduct(
          name: 'Ulos Batak',
          category: 'Fashion',
          price: 'Rp 300.000 - 3.000.000',
          owner: 'Tenun Sigale-gale',
          rating: 4.9,
        ),
        UmkmProduct(
          name: 'Kopi Lintong',
          category: 'Minuman',
          price: 'Rp 75.000/250gr',
          owner: 'Koperasi Toba',
          rating: 4.8,
        ),
        UmkmProduct(
          name: 'Miniatur Rumah Bolon',
          category: 'Souvenir',
          price: 'Rp 85.000 - 350.000',
          owner: 'Pak Mangasi',
          rating: 4.6,
        ),
        UmkmProduct(
          name: 'Arsik Instant',
          category: 'Makanan',
          price: 'Rp 45.000/pack',
          owner: 'Ibu Hotmaida',
          rating: 4.5,
        ),
      ],
      8: [
        // Kawah Putih Ciwidey - UMKM Bandung
        UmkmProduct(
          name: 'Strawberry Segar',
          category: 'Buah',
          price: 'Rp 25.000/kg',
          owner: 'Petik Strawberry Ciwidey',
          rating: 4.7,
        ),
        UmkmProduct(
          name: 'Susu Murni Ciwidey',
          category: 'Minuman',
          price: 'Rp 15.000/botol',
          owner: 'KUD Rancabali',
          rating: 4.8,
        ),
        UmkmProduct(
          name: 'Selai Strawberry',
          category: 'Makanan',
          price: 'Rp 35.000/jar',
          owner: 'Ibu Lilis',
          rating: 4.6,
        ),
        UmkmProduct(
          name: 'Kaos Kawah Putih',
          category: 'Fashion',
          price: 'Rp 65.000',
          owner: 'Souvenir Rancabali',
          rating: 4.5,
        ),
      ],
      9: [
        // Istana Maimun - UMKM Medan
        UmkmProduct(
          name: 'Bika Ambon Medan',
          category: 'Makanan',
          price: 'Rp 45.000/box',
          owner: 'Bika Ambon Zulaikha',
          rating: 4.9,
        ),
        UmkmProduct(
          name: 'Kain Songket Melayu',
          category: 'Fashion',
          price: 'Rp 400.000 - 2.500.000',
          owner: 'Songket Deli',
          rating: 4.8,
        ),
        UmkmProduct(
          name: 'Kopi Sidikalang',
          category: 'Minuman',
          price: 'Rp 60.000/250gr',
          owner: 'Kopi Klasik Medan',
          rating: 4.7,
        ),
        UmkmProduct(
          name: 'Miniatur Istana',
          category: 'Souvenir',
          price: 'Rp 75.000',
          owner: 'Pak Rahman',
          rating: 4.5,
        ),
      ],
      10: [
        // Pura Tanah Lot - UMKM Tabanan
        UmkmProduct(
          name: 'Lukisan Tanah Lot',
          category: 'Seni',
          price: 'Rp 200.000 - 1.500.000',
          owner: 'Galeri Seni Tabanan',
          rating: 4.8,
        ),
        UmkmProduct(
          name: 'Patung Kayu Bali',
          category: 'Kerajinan',
          price: 'Rp 150.000 - 2.000.000',
          owner: 'Pengrajin Mas Ubud',
          rating: 4.9,
        ),
        UmkmProduct(
          name: 'Kopi Luwak Bali',
          category: 'Minuman',
          price: 'Rp 150.000/100gr',
          owner: 'Kopi Bali Asli',
          rating: 4.7,
        ),
        UmkmProduct(
          name: 'Gelang Perak Bali',
          category: 'Aksesoris',
          price: 'Rp 85.000 - 500.000',
          owner: 'Celuk Silver',
          rating: 4.6,
        ),
      ],
      11: [
        // Museum Fatahillah - UMKM Jakarta
        UmkmProduct(
          name: 'Kerak Telor Khas Betawi',
          category: 'Makanan',
          price: 'Rp 30.000/porsi',
          owner: 'Kerak Telor H. Amin',
          rating: 4.7,
        ),
        UmkmProduct(
          name: 'Ondel-ondel Miniatur',
          category: 'Souvenir',
          price: 'Rp 50.000 - 200.000',
          owner: 'Seni Betawi',
          rating: 4.6,
        ),
        UmkmProduct(
          name: 'Dodol Betawi',
          category: 'Makanan',
          price: 'Rp 35.000/pack',
          owner: 'Ibu Murni',
          rating: 4.5,
        ),
        UmkmProduct(
          name: 'Tas Batik Betawi',
          category: 'Fashion',
          price: 'Rp 120.000 - 350.000',
          owner: 'Batik Kota Tua',
          rating: 4.4,
        ),
      ],
      12: [
        // Uluwatu - UMKM Badung
        UmkmProduct(
          name: 'Sarung Pantai Bali',
          category: 'Fashion',
          price: 'Rp 75.000 - 250.000',
          owner: 'Bali Textile Art',
          rating: 4.7,
        ),
        UmkmProduct(
          name: 'Topeng Bali',
          category: 'Kerajinan',
          price: 'Rp 100.000 - 800.000',
          owner: 'Pak Wayan',
          rating: 4.8,
        ),
        UmkmProduct(
          name: 'Minyak Aromaterapi',
          category: 'Kesehatan',
          price: 'Rp 45.000/botol',
          owner: 'Bali Essential Oil',
          rating: 4.6,
        ),
        UmkmProduct(
          name: 'Gantungan Kunci Kecak',
          category: 'Souvenir',
          price: 'Rp 20.000',
          owner: 'Uluwatu Gift Shop',
          rating: 4.5,
        ),
      ],
      13: [
        // Gunung Bromo - UMKM Probolinggo
        UmkmProduct(
          name: 'Jaket Gunung Bromo',
          category: 'Fashion',
          price: 'Rp 150.000 - 300.000',
          owner: 'Bromo Adventure',
          rating: 4.7,
        ),
        UmkmProduct(
          name: 'Kopi Tengger',
          category: 'Minuman',
          price: 'Rp 40.000/250gr',
          owner: 'Petani Tengger',
          rating: 4.8,
        ),
        UmkmProduct(
          name: 'Pasir Berbotol Bromo',
          category: 'Souvenir',
          price: 'Rp 25.000',
          owner: 'Souvenir Cemoro Lawang',
          rating: 4.5,
        ),
        UmkmProduct(
          name: 'Madu Hutan Tengger',
          category: 'Makanan',
          price: 'Rp 75.000/500ml',
          owner: 'Bu Sumi',
          rating: 4.9,
        ),
      ],
      14: [
        // Coban Rondo - UMKM Malang
        UmkmProduct(
          name: 'Apel Malang',
          category: 'Buah',
          price: 'Rp 30.000/kg',
          owner: 'Petani Pujon',
          rating: 4.7,
        ),
        UmkmProduct(
          name: 'Keripik Apel',
          category: 'Makanan',
          price: 'Rp 25.000/pack',
          owner: 'UD Malang Raya',
          rating: 4.6,
        ),
        UmkmProduct(
          name: 'Kaos Coban Rondo',
          category: 'Fashion',
          price: 'Rp 60.000',
          owner: 'Souvenir Air Terjun',
          rating: 4.4,
        ),
        UmkmProduct(
          name: 'Madu Klanceng',
          category: 'Makanan',
          price: 'Rp 100.000/250ml',
          owner: 'Pak Joko',
          rating: 4.8,
        ),
      ],
      15: [
        // Kota Tua Jakarta - UMKM Jakarta
        UmkmProduct(
          name: 'Bir Pletok Betawi',
          category: 'Minuman',
          price: 'Rp 15.000/botol',
          owner: 'Bir Pletok H. Ridwan',
          rating: 4.6,
        ),
        UmkmProduct(
          name: 'Sepatu Betawi',
          category: 'Fashion',
          price: 'Rp 200.000 - 500.000',
          owner: 'Pengrajin Tanah Abang',
          rating: 4.5,
        ),
        UmkmProduct(
          name: 'Postcard Vintage',
          category: 'Souvenir',
          price: 'Rp 10.000/lembar',
          owner: 'Toko Kenangan',
          rating: 4.4,
        ),
        UmkmProduct(
          name: 'Kue Pancong',
          category: 'Makanan',
          price: 'Rp 20.000/box',
          owner: 'Ibu Yayah',
          rating: 4.7,
        ),
      ],
      16: [
        // Lawang Sewu - UMKM Semarang
        UmkmProduct(
          name: 'Lumpia Semarang',
          category: 'Makanan',
          price: 'Rp 35.000/box',
          owner: 'Lumpia Gang Lombok',
          rating: 4.8,
        ),
        UmkmProduct(
          name: 'Wingko Babat',
          category: 'Makanan',
          price: 'Rp 25.000/pack',
          owner: 'Wingko Cap Kereta Api',
          rating: 4.7,
        ),
        UmkmProduct(
          name: 'Miniatur Lawang Sewu',
          category: 'Souvenir',
          price: 'Rp 55.000',
          owner: 'Souvenir Semarang',
          rating: 4.5,
        ),
        UmkmProduct(
          name: 'Bandeng Presto',
          category: 'Makanan',
          price: 'Rp 40.000/ekor',
          owner: 'Bandeng Juwana Elrina',
          rating: 4.9,
        ),
      ],
      17: [
        // Gereja Blenduk - UMKM Semarang
        UmkmProduct(
          name: 'Tahu Gimbal',
          category: 'Makanan',
          price: 'Rp 20.000/porsi',
          owner: 'Tahu Gimbal Pak Rebo',
          rating: 4.7,
        ),
        UmkmProduct(
          name: 'Batik Semarangan',
          category: 'Fashion',
          price: 'Rp 180.000 - 600.000',
          owner: 'Batik Kota Lama',
          rating: 4.6,
        ),
        UmkmProduct(
          name: 'Gantungan Blenduk',
          category: 'Souvenir',
          price: 'Rp 18.000',
          owner: 'Toko Oleh-oleh',
          rating: 4.4,
        ),
        UmkmProduct(
          name: 'Kue Moci',
          category: 'Makanan',
          price: 'Rp 30.000/box',
          owner: 'Ibu Ningsih',
          rating: 4.5,
        ),
      ],
      18: [
        // Jatiluwih - UMKM Tabanan
        UmkmProduct(
          name: 'Beras Organik Jatiluwih',
          category: 'Makanan',
          price: 'Rp 25.000/kg',
          owner: 'Subak Jatiluwih',
          rating: 4.9,
        ),
        UmkmProduct(
          name: 'Kopi Bali Arabica',
          category: 'Minuman',
          price: 'Rp 65.000/250gr',
          owner: 'Petani Kintamani',
          rating: 4.8,
        ),
        UmkmProduct(
          name: 'Tas Anyaman Bambu',
          category: 'Kerajinan',
          price: 'Rp 85.000 - 300.000',
          owner: 'Pengrajin Desa',
          rating: 4.6,
        ),
        UmkmProduct(
          name: 'Topi Caping Petani',
          category: 'Fashion',
          price: 'Rp 45.000',
          owner: 'Pak Ketut',
          rating: 4.5,
        ),
      ],
      19: [
        // Pantai Pink - UMKM Labuan Bajo
        UmkmProduct(
          name: 'Kain Tenun Flores',
          category: 'Fashion',
          price: 'Rp 250.000 - 1.500.000',
          owner: 'Tenun Manggarai',
          rating: 4.9,
        ),
        UmkmProduct(
          name: 'Kalung Mutiara Laut',
          category: 'Aksesoris',
          price: 'Rp 150.000 - 800.000',
          owner: 'Mutiara Komodo',
          rating: 4.8,
        ),
        UmkmProduct(
          name: 'Miniatur Komodo',
          category: 'Souvenir',
          price: 'Rp 75.000 - 250.000',
          owner: 'Pak Antonius',
          rating: 4.7,
        ),
        UmkmProduct(
          name: 'Ikan Asin Kering',
          category: 'Makanan',
          price: 'Rp 50.000/250gr',
          owner: 'Nelayan Bajo',
          rating: 4.6,
        ),
      ],
      20: [
        // Tangkuban Perahu - UMKM Bandung
        UmkmProduct(
          name: 'Telur Puyuh Rebus',
          category: 'Makanan',
          price: 'Rp 10.000/10pcs',
          owner: 'Warung Kawah',
          rating: 4.5,
        ),
        UmkmProduct(
          name: 'Boneka Tangkuban',
          category: 'Souvenir',
          price: 'Rp 35.000',
          owner: 'Toko Lembang',
          rating: 4.3,
        ),
        UmkmProduct(
          name: 'Susu Murni Lembang',
          category: 'Minuman',
          price: 'Rp 18.000/botol',
          owner: 'KUD Lembang',
          rating: 4.7,
        ),
        UmkmProduct(
          name: 'Sweater Rajut',
          category: 'Fashion',
          price: 'Rp 120.000 - 250.000',
          owner: 'Rajut Lembang',
          rating: 4.6,
        ),
      ],
    };

    // Default UMKM jika ID tidak ditemukan
    return umkmMap[id] ??
        [
          UmkmProduct(
            name: 'Keripik Singkong',
            category: 'Makanan',
            price: 'Rp 15.000/pack',
            owner: 'UD Berkah',
            rating: 4.5,
          ),
          UmkmProduct(
            name: 'Tas Rajut Tradisional',
            category: 'Kerajinan',
            price: 'Rp 75.000',
            owner: 'Kelompok Rajut Desa',
            rating: 4.4,
          ),
        ];
  }

  // ============ MAPPING REVIEWS (Disingkat untuk 20 destinasi) ============
  static List<Review> getReviewsByDestinationId(int id) {
    final reviewsMap = {
      1: [
        Review(
          name: 'Andi Setiawan',
          rating: 5,
          date: '3 hari lalu',
          comment:
              'Pantainya bagus banget! Hutan mangrovenya keren buat foto-foto.',
          avatar: 'AS',
          verified: true,
        ),
      ],
      2: [
        Review(
          name: 'Siti Nurhaliza',
          rating: 4,
          date: '5 hari lalu',
          comment: 'Tempat bersejarah yang terawat baik. Cocok untuk edukasi.',
          avatar: 'SN',
          verified: true,
        ),
      ],
      3: [
        Review(
          name: 'Dedi Prasetyo',
          rating: 5,
          date: '4 hari lalu',
          comment: 'Arsitekturnya unik banget! Banyak spot foto instagramable.',
          avatar: 'DP',
          verified: true,
        ),
      ],
      4: [
        Review(
          name: 'Fahmi Rahman',
          rating: 5,
          date: '1 minggu lalu',
          comment: 'Pendakian menantang tapi pemandangannya worth it banget!',
          avatar: 'FR',
          verified: true,
        ),
      ],
      5: [
        Review(
          name: 'Dewi Lestari',
          rating: 5,
          date: '2 hari lalu',
          comment: 'Candi Buddha terbesar di dunia memang tidak mengecewakan!',
          avatar: 'DL',
          verified: true,
        ),
      ],
      6: [
        Review(
          name: 'Rama Wijaya',
          rating: 5,
          date: '3 hari lalu',
          comment:
              'Pusat belanja dan kuliner Jogja! Suasana malam hari sangat meriah.',
          avatar: 'RW',
          verified: true,
        ),
      ],
      7: [
        Review(
          name: 'Lina Simanjuntak',
          rating: 5,
          date: '1 minggu lalu',
          comment:
              'Danau terbesar di Indonesia! Pemandangan alamnya luar biasa indah.',
          avatar: 'LS',
          verified: true,
        ),
      ],
      8: [
        Review(
          name: 'Yoga Pratama',
          rating: 5,
          date: '4 hari lalu',
          comment:
              'Kawah dengan air putih kehijauan yang unik. Suasananya sejuk!',
          avatar: 'YP',
          verified: true,
        ),
      ],
      9: [
        Review(
          name: 'Bella Syahputri',
          rating: 4,
          date: '5 hari lalu',
          comment:
              'Istana yang megah dengan arsitektur campuran. Sangat fotogenik!',
          avatar: 'BS',
          verified: true,
        ),
      ],
      10: [
        Review(
          name: 'Made Sudirman',
          rating: 5,
          date: '2 hari lalu',
          comment:
              'Sunset di Tanah Lot tidak ada duanya! Tempat yang sakral dan indah.',
          avatar: 'MS',
          verified: true,
        ),
      ],
      11: [
        Review(
          name: 'Andra Kusuma',
          rating: 4,
          date: '6 hari lalu',
          comment: 'Museum bersejarah di tengah Kota Tua. Bangunannya klasik!',
          avatar: 'AK',
          verified: true,
        ),
      ],
      12: [
        Review(
          name: 'Komang Arya',
          rating: 5,
          date: '3 hari lalu',
          comment:
              'Tari Kecak sunset nya memukau! View tebing lautnya dramatis.',
          avatar: 'KA',
          verified: true,
        ),
      ],
      13: [
        Review(
          name: 'Fikri Hakim',
          rating: 5,
          date: '1 minggu lalu',
          comment:
              'Sunrise Bromo legendary! Lautan pasirnya spektakuler sekali.',
          avatar: 'FH',
          verified: true,
        ),
      ],
      14: [
        Review(
          name: 'Dina Puspita',
          rating: 4,
          date: '5 hari lalu',
          comment:
              'Air terjun tinggi dikelilingi hutan pinus. Udara sejuk dan segar!',
          avatar: 'DP',
          verified: true,
        ),
      ],
      15: [
        Review(
          name: 'Bimo Saputra',
          rating: 5,
          date: '4 hari lalu',
          comment:
              'Kawasan heritage Jakarta! Bangunan kolonial yang terawat bagus.',
          avatar: 'BS',
          verified: true,
        ),
      ],
      16: [
        Review(
          name: 'Sari Wulandari',
          rating: 4,
          date: '1 minggu lalu',
          comment:
              'Bangunan bersejarah dengan ribuan jendela. Atmosfernya mistis!',
          avatar: 'SW',
          verified: true,
        ),
      ],
      17: [
        Review(
          name: 'Toni Hermawan',
          rating: 5,
          date: '3 hari lalu',
          comment:
              'Gereja tertua di Jateng! Kubah besar dan arsitektur Eropa klasik.',
          avatar: 'TH',
          verified: true,
        ),
      ],
      18: [
        Review(
          name: 'Putu Angga',
          rating: 5,
          date: '2 hari lalu',
          comment:
              'Sawah terasering UNESCO! Sistem subak yang masih tradisional.',
          avatar: 'PA',
          verified: true,
        ),
      ],
      19: [
        Review(
          name: 'Clara Natalia',
          rating: 5,
          date: '1 minggu lalu',
          comment:
              'Pantai pink yang langka! Air lautnya jernih sempurna untuk snorkeling.',
          avatar: 'CN',
          verified: true,
        ),
      ],
      20: [
        Review(
          name: 'Ridwan Kamil',
          rating: 4,
          date: '6 hari lalu',
          comment:
              'Kawah aktif yang bisa didekati! Legenda Sangkuriang nya terkenal.',
          avatar: 'RK',
          verified: true,
        ),
      ],
    };

    return reviewsMap[id] ??
        [
          Review(
            name: 'Pengunjung',
            rating: 5,
            date: '1 minggu lalu',
            comment: 'Tempat yang indah dan recommended untuk dikunjungi!',
            avatar: 'P',
            verified: true,
          ),
        ];
  }
}
