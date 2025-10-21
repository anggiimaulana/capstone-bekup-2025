import 'package:capstone/provider/destination_provider.dart';
import 'package:capstone/screen/chatbot/chatbot_screen.dart';
import 'package:capstone/screen/home/chatbot_icon.dart';
import 'package:capstone/screen/home/filter_modal.dart';
import 'package:capstone/widget/build_card.dart';
import 'package:capstone/widget/search_filter_header.dart';
import 'package:capstone/style/colors.dart';
import 'package:capstone/style/typography.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _showTitle = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // Panggil search listener di initState
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    const threshold = 200.0;
    if (_scrollController.hasClients) {
      final showTitle = _scrollController.offset > threshold;
      if (showTitle != _showTitle) {
        setState(() {
          _showTitle = showTitle;
        });
      }

      // Logic Infinite Scrolling
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.offset;
      if (currentScroll >= maxScroll * 0.9) {
        // Load data baru saat 90% scroll telah tercapai
        Provider.of<DestinationProvider>(
          context,
          listen: false,
        ).loadMoreDestinations();
      }
    }
  }

  void _onSearchChanged() {
    Provider.of<DestinationProvider>(
      context,
      listen: false,
    ).searchDestinations(_searchController.text);
  }

  void _showFilterModal() {
    final provider = Provider.of<DestinationProvider>(context, listen: false);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => FilterModal(
        activeFilters: provider.activeFilters,
        currentSort: provider.currentSort,
        onFiltersChanged: (filters, sort) {
          // Update state di provider
          if (sort != null) {
            provider.setSort(sort);
          }
          provider.setFilters(filters);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DestinationProvider>(
      builder: (context, provider, child) {
        final theme = Theme.of(context);
        final isDarkMode = theme.brightness == Brightness.dark;
        final destinations = provider.displayedDestinations;

        return Scaffold(
          backgroundColor: isDarkMode
              ? theme.scaffoldBackgroundColor
              : AppColors.whiteSoft,
          body: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                pinned: true,
                floating: false,
                snap: false,
                backgroundColor: AppColors.oceanBlue,
                expandedHeight: 175.0,
                title: AnimatedOpacity(
                  opacity: _showTitle ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: Text(
                    "WisataKu",
                    style: AppTypography.heading2.copyWith(color: Colors.white),
                  ),
                ),
                centerTitle: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        "assets/images/beautiful-diamond-beach-penida-island-bali-indonesia.jpg",
                        fit: BoxFit.cover,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.4),
                              Colors.black.withOpacity(0.1),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        bottom: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Temukan Rekomendasi",
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Destinasi Wisata di Sekitarmu",
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(
                        isDarkMode ? Icons.light_mode : Icons.dark_mode,
                        color: AppColors.navy,
                        size: 20,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/settings');
                      },
                    ),
                  ),
                ],
              ),

              // Search & Filter
              SliverPersistentHeader(
                pinned: true,
                delegate: SearchFilterHeader(
                  searchController: _searchController,
                  onFilterTap: _showFilterModal,
                  theme: theme,
                  scrollOffset: _scrollController.hasClients
                      ? _scrollController.offset
                      : 0.0,
                ),
              ),

              // Tourism Cards List
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      // Cek apakah ini item terakhir DAN sedang memuat
                      if (index == destinations.length) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: provider.hasMoreData
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                ) // Loader
                              : const Center(
                                  child: Text("Semua data telah dimuat."),
                                ), // Teks akhir
                        );
                      }

                      // Tampilkan Card Wisata
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: buildCard(
                          context,
                          destinations[index].toMap(),
                          theme: theme,
                        ),
                      );
                    },
                    childCount:
                        destinations.length + (provider.hasMoreData ? 1 : 0),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: ChatBotIcon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChatbotScreen()),
              );
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
      },
    );
  }
}
