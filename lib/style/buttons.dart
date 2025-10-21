import 'package:flutter/material.dart';
import 'colors.dart';
import 'typography.dart';

class AppButtonStyles {
  static final ButtonStyle primary = ElevatedButton.styleFrom(
    backgroundColor: AppColors.oceanBlue,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 2,
    textStyle: AppTypography.body,
  );

  static final ButtonStyle secondary = ElevatedButton.styleFrom(
    backgroundColor: AppColors.blue,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 0,
    textStyle: AppTypography.body,
  );

  static final ButtonStyle tertiary = OutlinedButton.styleFrom(
    side: const BorderSide(color: AppColors.navy, width: 1.5),
    foregroundColor: AppColors.navy,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    textStyle: AppTypography.body,
  );
}
