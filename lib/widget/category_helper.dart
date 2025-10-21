import 'package:flutter/material.dart';
import 'package:capstone/model/tourism_detail_data.dart';
import 'package:capstone/style/colors.dart';

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
  final isDarkMode = theme.brightness == Brightness.dark;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.oceanBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.store, color: AppColors.oceanBlue, size: 24),
          ),
          const SizedBox(width: 12),
          Text(
            'Produk UMKM Lokal',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : AppColors.navy,
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),
      Text(
        'Dukung ekonomi lokal dengan produk khas daerah',
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
        ),
      ),
      const SizedBox(height: 20),
      GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return _buildUmkmCard(products[index], theme);
        },
      ),
    ],
  );
}

Widget _buildUmkmCard(UmkmProduct product, ThemeData theme) {
  final isDarkMode = theme.brightness == Brightness.dark;
  final categoryColor = CategoryHelper.getColor(product.category);
  final categoryIcon = CategoryHelper.getIcon(product.category);

  return Container(
    decoration: BoxDecoration(
      color: isDarkMode ? theme.cardColor : Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
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
          height: 120,
          decoration: BoxDecoration(
            gradient: CategoryHelper.getGradient(product.category),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Stack(
            children: [
              // Pattern Background
              Positioned.fill(
                child: Opacity(
                  opacity: 0.1,
                  child: CustomPaint(painter: PatternPainter()),
                ),
              ),
              // Icon
              Center(child: Icon(categoryIcon, size: 56, color: Colors.white)),
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
                    borderRadius: BorderRadius.circular(12),
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
        // Content
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : AppColors.navy,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.person_outline,
                          size: 12,
                          color: theme.textTheme.bodySmall?.color?.withOpacity(
                            0.6,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            product.owner,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.textTheme.bodySmall?.color
                                  ?.withOpacity(0.6),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star, size: 14, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          product.rating.toString(),
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.price,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.oceanBlue,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// Custom Painter untuk pattern background
class PatternPainter extends CustomPainter {
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
