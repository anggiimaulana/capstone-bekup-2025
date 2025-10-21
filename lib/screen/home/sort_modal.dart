// sort_modal.dart
import 'package:capstone/style/colors.dart';
import 'package:flutter/material.dart';

class SortModal extends StatelessWidget {
  final String currentSort;
  final Function(String) onSortChanged;

  const SortModal({
    super.key,
    required this.currentSort,
    required this.onSortChanged,
  });

  final List<Map<String, dynamic>> _sortOptions = const [
    {
      'label': 'Terpopuler',
      'subtitle': 'Berdasarkan jumlah kunjungan',
      'icon': Icons.trending_up,
    },
    {
      'label': 'Rating Tertinggi',
      'subtitle': 'Rating 5 hingga 1 bintang',
      'icon': Icons.star,
    },
    {
      'label': 'Terdekat',
      'subtitle': 'Jarak paling dekat dari Anda',
      'icon': Icons.location_on,
    },
    {
      'label': 'Harga Terendah',
      'subtitle': 'Dari harga paling murah',
      'icon': Icons.attach_money,
    },
    {
      'label': 'Harga Tertinggi',
      'subtitle': 'Dari harga paling mahal',
      'icon': Icons.monetization_on,
    },
    {
      'label': 'A - Z',
      'subtitle': 'Nama destinasi secara alfabetis',
      'icon': Icons.sort_by_alpha,
    },
    {
      'label': 'Terbaru',
      'subtitle': 'Destinasi yang baru ditambahkan',
      'icon': Icons.new_releases,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 40),
              const Text(
                'Urutkan Berdasarkan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.navy,
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Icon(Icons.close, color: Colors.grey.shade600),
              ),
            ],
          ),

          const Divider(height: 32),

          // Sort Options
          Expanded(
            child: ListView.separated(
              itemCount: _sortOptions.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final option = _sortOptions[index];
                final isSelected = currentSort == option['label'];

                return ListTile(
                  onTap: () {
                    onSortChanged(option['label']);
                    Navigator.pop(context);
                  },
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 4,
                  ),
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.oceanBlue.withOpacity(0.1)
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      option['icon'],
                      color: isSelected
                          ? AppColors.oceanBlue
                          : Colors.grey.shade600,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    option['label'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w600,
                      color: isSelected ? AppColors.oceanBlue : AppColors.navy,
                    ),
                  ),
                  subtitle: Text(
                    option['subtitle'],
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                  trailing: isSelected
                      ? Icon(
                          Icons.check_circle,
                          color: AppColors.oceanBlue,
                          size: 20,
                        )
                      : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
