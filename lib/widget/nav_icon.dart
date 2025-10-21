import 'package:capstone/style/colors.dart';
import 'package:flutter/material.dart';

Widget buildNavIcon(IconData icon, String label, {required ThemeData theme}) {
  return Column(
    children: [
      CircleAvatar(
        radius: 22,
        backgroundColor: AppColors.oceanBlue.withOpacity(0.08),
        child: Icon(icon, color: AppColors.oceanBlue),
      ),
      const SizedBox(height: 6),
      Text(label, style: TextStyle(fontSize: 12, color: AppColors.navy)),
    ],
  );
}

Widget buildShareIcon(IconData icon, String label, {required ThemeData theme}) {
  return Column(
    children: [
      CircleAvatar(
        radius: 22,
        backgroundColor: AppColors.oceanBlue.withOpacity(0.08),
        child: Icon(icon, color: AppColors.oceanBlue),
      ),
      const SizedBox(height: 6),
      Text(label, style: TextStyle(fontSize: 12, color: AppColors.navy)),
    ],
  );
}
