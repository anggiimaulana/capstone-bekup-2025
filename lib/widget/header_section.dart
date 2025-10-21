import 'package:capstone/model/tourism_detail_data.dart';
import 'package:capstone/widget/info_card.dart';
import 'package:capstone/style/colors.dart';
import 'package:capstone/style/typography.dart';
import 'package:flutter/material.dart';

Widget buildHeaderSection(
  Map<String, dynamic> destination, {
  required ThemeData theme,
}) {
  final isDark = theme.brightness == Brightness.dark;

  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              destination['name'],
              style: AppTypography.heading.copyWith(
                color: isDark ? AppColors.whiteSoft : AppColors.navy,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.location_on, size: 18, color: Colors.grey.shade600),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    destination['location'],
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade400, Colors.orange.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.star, color: Colors.white, size: 22),
                const SizedBox(width: 6),
                Text(
                  '${destination['rating']}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            const Text(
              "Rating",
              style: TextStyle(fontSize: 12, color: Colors.white70),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildQuickInfoGrid(
  Map<String, dynamic> destination, {
  required ThemeData theme,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      buildInfoCard(
        Icons.access_time,
        destination['hours'],
        "Jam Operasional",
        theme,
      ),
      buildInfoCard(Icons.payments, destination['price'], "Harga", theme),
      buildInfoCard(Icons.location_on, destination['distance'], "Jarak", theme),
    ],
  );
}

Widget buildDescriptionSection(
  Map<String, dynamic> destination, {
  required ThemeData theme,
}) {
  final isDark = theme.brightness == Brightness.dark;
  final additionalInfo =
      "\n\nSelain itu, tempat wisata ini juga menyediakan fasilitas toko souvenir yang menawarkan berbagai produk UMKM lokal, sehingga pengunjung dapat membawa pulang kenang-kenangan unik sekaligus mendukung perekonomian masyarakat setempat.";
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Deskripsi",
        style: AppTypography.heading2.copyWith(
          fontWeight: FontWeight.bold,
          color: isDark ? AppColors.whiteSoft : AppColors.navy,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        destination['description'] + additionalInfo,
        style: AppTypography.caption.copyWith(
          color: isDark ? AppColors.whiteSoft : AppColors.navy,
        ),
      ),
    ],
  );
}

Widget buildFacilitiesSection({
  required List<Facility> facilities,
  required ThemeData theme,
}) {
  final isDark = theme.brightness == Brightness.dark;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Fasilitas",
        style: AppTypography.heading2.copyWith(
          fontWeight: FontWeight.bold,
          color: isDark ? AppColors.whiteSoft : AppColors.navy,
        ),
      ),
      const SizedBox(height: 12),
      Wrap(
        spacing: 14,
        runSpacing: 12,
        children: facilities.map((facility) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? AppColors.whiteSoft : theme.cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark
                    ? AppColors.whiteSoft.withOpacity(0.5)
                    : Colors.grey.shade300,
                width: 0.5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  facility.icon,
                  color: facility.available ? AppColors.oceanBlue : Colors.grey,
                  size: 20,
                ),
                const SizedBox(width: 6),
                Text(
                  facility.label,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: facility.available ? AppColors.navy : Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    ],
  );
}
