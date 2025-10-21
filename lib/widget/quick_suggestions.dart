import 'package:flutter/material.dart';
import 'package:capstone/style/colors.dart';

class QuickSuggestions extends StatelessWidget {
  final Function(String) onSuggestionTap;

  const QuickSuggestions({super.key, required this.onSuggestionTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final suggestions = [
      {"icon": "🏖️", "text": "Pantai terdekat dari sini"},
      {"icon": "🏨", "text": "Hotel recommended di Indramayu"},
      {"icon": "🍽️", "text": "Kuliner khas Jawa Barat"},
      {"icon": "🏛️", "text": "Wisata sejarah dan budaya"},
      {"icon": "🚗", "text": "Transportasi ke Jakarta"},
      {"icon": "🎭", "text": "Festival budaya lokal"},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.tips_and_updates_outlined,
                size: 16,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
              const SizedBox(width: 8),
              Text(
                'Coba tanyakan:',
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: suggestions.map((suggestion) {
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => onSuggestionTap(suggestion["text"]!),
                  borderRadius: BorderRadius.circular(20),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey[800] : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isDark
                            ? Colors.grey[600]!
                            : AppColors.oceanBlue.withOpacity(0.3),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: isDark
                              ? Colors.black.withOpacity(0.2)
                              : Colors.black.withOpacity(0.03),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          suggestion["icon"]!,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            suggestion["text"]!,
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark
                                  ? Colors.white
                                  : AppColors.oceanBlue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
