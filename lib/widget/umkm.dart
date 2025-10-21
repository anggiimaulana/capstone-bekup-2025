import 'package:capstone/model/tourism_detail_data.dart';
import 'package:capstone/style/colors.dart';
import 'package:capstone/style/typography.dart';
import 'package:flutter/material.dart';

// Helper untuk mendapatkan warna dan icon berdasarkan kategori
class CategoryHelper {
  static Color getColor(String category) {
    switch (category.toLowerCase()) {
      case 'makanan':
        return Colors.orange;
      case 'fashion':
        return Colors.pink;
      case 'kerajinan':
        return Colors.blue;
      case 'minuman':
        return Colors.green;
      case 'souvenir':
        return Colors.purple;
      case 'aksesoris':
        return Colors.amber;
      case 'bumbu':
        return Colors.red;
      case 'buah':
        return Colors.lightGreen;
      case 'kesehatan':
        return Colors.teal;
      case 'seni':
        return Colors.deepPurple;
      default:
        return Colors.grey;
    }
  }

  static IconData getIcon(String category) {
    switch (category.toLowerCase()) {
      case 'makanan':
        return Icons.restaurant;
      case 'fashion':
        return Icons.checkroom;
      case 'kerajinan':
        return Icons.handyman;
      case 'minuman':
        return Icons.local_cafe;
      case 'souvenir':
        return Icons.card_giftcard;
      case 'aksesoris':
        return Icons.watch;
      case 'bumbu':
        return Icons.kitchen;
      case 'buah':
        return Icons.eco;
      case 'kesehatan':
        return Icons.healing;
      case 'seni':
        return Icons.palette;
      default:
        return Icons.shopping_bag;
    }
  }

  static LinearGradient getGradient(String category) {
    final color = getColor(category);
    return LinearGradient(
      colors: [color, color.withOpacity(0.7)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
}

Widget buildUmkmSection({
  required List<UmkmProduct> products,
  required ThemeData theme,
}) {
  final isDark = theme.brightness == Brightness.dark;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(width: 8),
      Text(
        "Produk UMKM Lokal",
        style: AppTypography.heading2.copyWith(
          fontWeight: FontWeight.bold,
          color: isDark ? AppColors.whiteSoft : AppColors.navy,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        "Dukung ekonomi lokal dengan membeli produk khas daerah",
        style: AppTypography.caption.copyWith(
          color: isDark ? AppColors.whiteSoft : AppColors.navy,
        ),
      ),
      const SizedBox(height: 16),
      SizedBox(
        height: 240,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: products.length,
          itemBuilder: (context, index) {
            return buildUmkmCard(products[index], theme: theme);
          },
        ),
      ),
    ],
  );
}

Widget buildUmkmCard(UmkmProduct product, {required ThemeData theme}) {
  final isDark = theme.brightness == Brightness.dark;
  final categoryColor = CategoryHelper.getColor(product.category);
  final categoryIcon = CategoryHelper.getIcon(product.category);

  return Container(
    width: 180,
    margin: const EdgeInsets.only(right: 16),
    decoration: BoxDecoration(
      color: isDark ? theme.cardColor : Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: isDark
          ? Border.all(color: AppColors.whiteSoft.withOpacity(0.3), width: 0.5)
          : null,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon Container dengan Gradient
        Container(
          height: 130,
          decoration: BoxDecoration(
            gradient: CategoryHelper.getGradient(product.category),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Stack(
            children: [
              // Pattern Background (optional decorative)
              Positioned.fill(
                child: Opacity(
                  opacity: 0.1,
                  child: CustomPaint(painter: _PatternPainter()),
                ),
              ),
              // Icon
              Center(child: Icon(categoryIcon, size: 50, color: Colors.white)),
              // Category Badge
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    product.category,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: categoryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Name
                Text(
                  product.name,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.whiteSoft : AppColors.navy,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                // Owner with Rating
                Row(
                  children: [
                    Icon(Icons.person, size: 12, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        product.owner,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(Icons.star, size: 12, color: Colors.orange),
                    const SizedBox(width: 2),
                    Text(
                      product.rating.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  product.price,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.oceanBlue,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// Custom Painter untuk pattern background (decorative)
class _PatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Draw circles pattern
    for (double i = 0; i < size.width; i += 30) {
      for (double j = 0; j < size.height; j += 30) {
        canvas.drawCircle(Offset(i, j), 8, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
