import 'package:flutter/material.dart';
import 'package:capstone/style/colors.dart';

class SearchFilterHeader extends SliverPersistentHeaderDelegate {
  final TextEditingController searchController;
  final VoidCallback onFilterTap;
  final ThemeData theme;
  final double scrollOffset;

  SearchFilterHeader({
    required this.searchController,
    required this.onFilterTap,
    required this.theme,
    required this.scrollOffset,
  });

  @override
  double get minExtent => 72;
  @override
  double get maxExtent => 72;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final bool isDark = theme.brightness == Brightness.dark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: isDark ? theme.scaffoldBackgroundColor : AppColors.whiteSoft,
        border: Border(
          bottom: BorderSide(
            color: isDark ? AppColors.whiteSoft : AppColors.oceanBlue,
            width: 0.5,
          ),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      child: Row(
        children: [
          // 🔍 Search bar
          Expanded(
            child: SizedBox(
              height: 50,
              child: TextField(
                controller: searchController,
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white, // tetap putih untuk input
                  hintText: "Cari destinasi...",
                  hintStyle: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 14,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.oceanBlue,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: isDark
                          ? Colors.grey.shade700
                          : AppColors.oceanBlue,
                      width: 0.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: AppColors.oceanBlue,
                      width: 2, // lebih tebal pas fokus
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // 🎛 Filter Icon Button
          Material(
            color: AppColors.oceanBlue,
            shape: const CircleBorder(),
            elevation: 3,
            child: IconButton(
              icon: const Icon(Icons.filter_list, color: Colors.white),
              onPressed: onFilterTap,
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SearchFilterHeader oldDelegate) =>
      oldDelegate.scrollOffset != scrollOffset || oldDelegate.theme != theme;
}
