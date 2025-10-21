import 'package:capstone/widget/review_widget.dart';
import 'package:capstone/style/colors.dart';
import 'package:capstone/style/typography.dart';
import 'package:flutter/material.dart';

Widget buildInfoCard(
  IconData icon,
  String value,
  String label,
  ThemeData theme,
) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: theme.cardColor, // ⬅️ ikut theme card
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.oceanBlue, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.navy,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
            ),
          ),
        ],
      ),
    ),
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

Widget buildFacilitiesSection({required ThemeData theme}) {
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
          final available = facility['available'] as bool;
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
                  facility['icon'],
                  color: available ? AppColors.oceanBlue : Colors.grey,
                ),
                const SizedBox(width: 6),
                Text(
                  facility['label'],
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: available ? AppColors.navy : Colors.grey,
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
