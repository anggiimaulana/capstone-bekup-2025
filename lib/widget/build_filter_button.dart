import 'package:capstone/style/colors.dart';
import 'package:flutter/material.dart';

Widget buildFilterButton({
  required IconData icon,
  required String label,
  required VoidCallback onTap,
  required bool hasActiveFilter,
  double width = 100,
  ThemeData? theme,
}) {
  return SizedBox(
    width: width,
    height: 36,
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: hasActiveFilter ? AppColors.oceanBlue : Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: hasActiveFilter
                ? null
                : Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: hasActiveFilter ? Colors.white : AppColors.oceanBlue,
                size: 16,
              ),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: hasActiveFilter ? Colors.white : AppColors.oceanBlue,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
