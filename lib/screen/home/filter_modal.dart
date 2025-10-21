import 'package:capstone/style/colors.dart';
import 'package:flutter/material.dart';

class FilterModal extends StatefulWidget {
  final Map<String, dynamic> activeFilters;
  final String currentSort;
  final Function(Map<String, dynamic>, String?) onFiltersChanged;

  const FilterModal({
    super.key,
    required this.activeFilters,
    required this.currentSort,
    required this.onFiltersChanged,
  });

  @override
  State<FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  late Map<String, dynamic> _tempFilters;
  late String _selectedSort;

  final List<String> _sortOptions = [
    'Terpopuler',
    'Terdekat',
    'Rating Tertinggi',
    'Harga Termurah',
    'Harga Termahal',
  ];

  final List<String> _provinces = [
    'Jawa Barat',
    'Jawa Tengah',
    'Jawa Timur',
    'DI Yogyakarta',
    'DKI Jakarta',
    'Banten',
  ];

  final List<String> _cities = [
    'Indramayu',
    'Cirebon',
    'Kuningan',
    'Majalengka',
    'Sumedang',
    'Bandung',
  ];

  final List<String> _categories = [
    'Pantai',
    'Gunung',
    'Museum',
    'Sejarah',
    'Kuliner',
    'Alam',
    'Budaya',
    'Religi',
  ];

  final List<String> _priceRanges = [
    'Gratis',
    'Rp 10.000 - Rp 50.000',
    'Rp 50.000 - Rp 100.000',
    '> Rp 100.000',
  ];

  @override
  void initState() {
    super.initState();
    _tempFilters = Map.from(widget.activeFilters);
    _selectedSort = widget.currentSort;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _tempFilters.clear();
                    _selectedSort = _sortOptions.first;
                  });
                },
                child: const Text(
                  'Reset',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Text(
                'Filter Destinasi',
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

          // Filter Content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sort section
                  _buildSortSection(),

                  const SizedBox(height: 24),

                  _buildFilterSection(
                    'Provinsi',
                    Icons.location_city,
                    _provinces,
                    'province',
                  ),

                  const SizedBox(height: 24),

                  _buildFilterSection('Kota', Icons.place, _cities, 'city'),

                  const SizedBox(height: 24),

                  _buildFilterSection(
                    'Kategori',
                    Icons.category,
                    _categories,
                    'category',
                  ),

                  const SizedBox(height: 24),

                  _buildRatingFilter(),

                  const SizedBox(height: 24),

                  _buildFilterSection(
                    'Rentang Harga',
                    Icons.payments,
                    _priceRanges,
                    'price_range',
                  ),

                  const SizedBox(height: 24),

                  _buildDistanceFilter(),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),

          // Apply Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                widget.onFiltersChanged(_tempFilters, _selectedSort);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.oceanBlue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                'Terapkan Filter (${_getActiveFilterCount()})',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSortSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.sort, size: 20, color: AppColors.oceanBlue),
            const SizedBox(width: 8),
            const Text(
              'Urutkan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.navy,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _sortOptions.map((option) {
            final isSelected = _selectedSort == option;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedSort = option;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.oceanBlue
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.oceanBlue
                        : Colors.grey.shade300,
                  ),
                ),
                child: Text(
                  option,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey.shade700,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildFilterSection(
    String title,
    IconData icon,
    List<String> options,
    String filterKey,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: AppColors.oceanBlue),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.navy,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((option) {
            final isSelected = _tempFilters[filterKey] == option;
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _tempFilters.remove(filterKey);
                  } else {
                    _tempFilters[filterKey] = option;
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.oceanBlue
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.oceanBlue
                        : Colors.grey.shade300,
                  ),
                ),
                child: Text(
                  option,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey.shade700,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildRatingFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.star, size: 20, color: AppColors.oceanBlue),
            const SizedBox(width: 8),
            const Text(
              'Rating Minimum',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.navy,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: [1, 2, 3, 4].map((rating) {
            final isSelected = _tempFilters['min_rating'] == rating.toDouble();
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _tempFilters.remove('min_rating');
                  } else {
                    _tempFilters['min_rating'] = rating.toDouble();
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.oceanBlue
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.oceanBlue
                        : Colors.grey.shade300,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star,
                      size: 14,
                      color: isSelected ? Colors.white : Colors.orange.shade600,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$rating+',
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.grey.shade700,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDistanceFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.location_on, size: 20, color: AppColors.oceanBlue),
            const SizedBox(width: 8),
            const Text(
              'Jarak Maksimal',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.navy,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: AppColors.oceanBlue,
            inactiveTrackColor: Colors.grey.shade300,
            thumbColor: AppColors.oceanBlue,
            overlayColor: AppColors.oceanBlue.withOpacity(0.2),
            trackHeight: 4,
          ),
          child: Slider(
            value: (_tempFilters['max_distance'] ?? 50.0).toDouble(),
            min: 1.0,
            max: 100.0,
            divisions: 99,
            label: '${(_tempFilters['max_distance'] ?? 50.0).toInt()} km',
            onChanged: (value) {
              setState(() {
                _tempFilters['max_distance'] = value;
              });
            },
          ),
        ),
        Text(
          'Maksimal ${(_tempFilters['max_distance'] ?? 50.0).toInt()} km dari lokasi Anda',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  int _getActiveFilterCount() {
    return _tempFilters.length + (_selectedSort.isNotEmpty ? 1 : 0);
  }
}
