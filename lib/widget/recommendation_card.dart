import 'package:flutter/material.dart';
import 'package:capstone/model/tourism_recommendation.dart';

class RecommendationCard extends StatelessWidget {
  final TourismRecommendation recommendation;
  final VoidCallback? onTap;

  const RecommendationCard({
    super.key,
    required this.recommendation,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: _getGradientColors(isDark),
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _getBorderColor(isDark), width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                _buildIconContainer(),
                const SizedBox(width: 12),
                Expanded(child: _buildContentColumn()),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Color> _getGradientColors(bool isDark) {
    if (isDark) {
      return [
        recommendation.primaryColor.withOpacity(0.2),
        Colors.grey.shade800,
      ];
    } else {
      return [recommendation.primaryColor.withOpacity(0.05), Colors.white];
    }
  }

  Color _getBorderColor(bool isDark) {
    if (isDark) {
      return Colors.grey.shade600;
    } else {
      return recommendation.primaryColor.withOpacity(0.2);
    }
  }

  Widget _buildIconContainer() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: recommendation.primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(recommendation.iconData, color: Colors.white, size: 16),
    );
  }

  Widget _buildContentColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          recommendation.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 2),
        Text(
          recommendation.description,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            if (recommendation.distance != null) ...[
              Icon(Icons.location_on, size: 12, color: Colors.grey.shade600),
              const SizedBox(width: 4),
              Text(
                recommendation.distance!,
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
            if (recommendation.rating != null) ...[
              if (recommendation.distance != null) ...[
                const SizedBox(width: 8),
                const Text(
                  '•',
                  style: TextStyle(color: Colors.grey, fontSize: 11),
                ),
                const SizedBox(width: 8),
              ],
              Icon(Icons.star, size: 12, color: Colors.amber.shade600),
              const SizedBox(width: 4),
              Text(
                recommendation.rating!,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
            if (recommendation.priceRange != null) ...[
              const SizedBox(width: 8),
              const Text(
                '•',
                style: TextStyle(color: Colors.grey, fontSize: 11),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  recommendation.priceRange!,
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
