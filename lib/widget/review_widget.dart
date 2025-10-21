import 'package:capstone/style/colors.dart';
import 'package:capstone/style/typography.dart';
import 'package:flutter/material.dart';

final List<String> sampleImages = [
  "assets/images/wisata.webp",
  "assets/images/wisata.webp",
  "assets/images/wisata.webp",
  "assets/images/wisata.webp",
];

final List<Map<String, dynamic>> reviews = [
  {
    'name': 'Andi Pratama',
    'rating': 5,
    'date': '2 hari lalu',
    'comment':
        'Tempat yang sangat indah dan Instagram-able! Pemandangannya luar biasa, cocok untuk liburan keluarga.',
    'avatar': 'AP',
    'verified': true,
  },
  {
    'name': 'Sari Dewi',
    'rating': 4,
    'date': '1 minggu lalu',
    'comment':
        'Lokasinya mudah dijangkau dan fasilitas cukup lengkap. Harga tiket masuknya juga terjangkau.',
    'avatar': 'SD',
    'verified': false,
  },
  {
    'name': 'Budi Santoso',
    'rating': 5,
    'date': '2 minggu lalu',
    'comment':
        'Highly recommended! Staff yang ramah dan tempat yang bersih. Pasti akan datang lagi.',
    'avatar': 'BS',
    'verified': true,
  },
];

final List<Map<String, dynamic>> facilities = [
  {'icon': Icons.local_parking, 'label': 'Parkir', 'available': true},
  {'icon': Icons.restaurant, 'label': 'Restoran', 'available': true},
  {'icon': Icons.wc, 'label': 'Toilet', 'available': true},
  {'icon': Icons.local_atm, 'label': 'ATM', 'available': false},
  {'icon': Icons.wifi, 'label': 'WiFi', 'available': true},
  {'icon': Icons.camera_alt, 'label': 'Foto Spot', 'available': true},
  {'icon': Icons.accessible, 'label': 'Akses Difabel', 'available': false},
  {'icon': Icons.family_restroom, 'label': 'Area Keluarga', 'available': true},
];

Widget buildReviewsSection({required ThemeData theme}) {
  final isDark = theme.brightness == Brightness.dark;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Ulasan Pengunjung",
        style: AppTypography.heading2.copyWith(
          fontWeight: FontWeight.bold,
          color: isDark ? AppColors.whiteSoft : AppColors.navy,
        ),
      ),
      const SizedBox(height: 18),
      ...reviews
          .map((review) => buildReviewCard(review, theme: theme))
          .toList(),
    ],
  );
}

Widget buildReviewCard(
  Map<String, dynamic> review, {
  required ThemeData theme,
}) {
  final isDark = theme.brightness == Brightness.dark;

  return Container(
    margin: const EdgeInsets.only(bottom: 20),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: isDark ? theme.cardColor : AppColors.whiteSoft,
      borderRadius: BorderRadius.circular(16),
      border: isDark
          ? Border.all(color: AppColors.whiteSoft.withOpacity(0.5), width: 0.5)
          : null,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar Circle
        CircleAvatar(
          radius: 23,
          backgroundColor: AppColors.oceanBlue.withOpacity(0.2),
          child: Text(
            review['avatar'],
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.oceanBlue,
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    review['name'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.whiteSoft : AppColors.navy,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (review['verified'])
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Terverifikasi",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.orange, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    "${review['rating']}",
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    review['date'],
                    style: TextStyle(
                      fontSize: 11,
                      color: isDark
                          ? AppColors.whiteSoft.withOpacity(0.7)
                          : Colors.grey.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                review['comment'],
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? AppColors.whiteSoft : Colors.grey.shade700,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
