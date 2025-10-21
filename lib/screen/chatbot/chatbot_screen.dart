import 'package:capstone/provider/gemini_provider.dart';
import 'package:capstone/widget/chat_message_bubble.dart';
import 'package:capstone/widget/quick_suggestions.dart';
import 'package:capstone/widget/typing_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/style/colors.dart';

class ChatbotScreen extends StatefulWidget {
  static const path = "/enhanced-chat";

  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen>
    with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  late AnimationController _fabAnimationController;
  late Animation<double> _fabAnimation;

  @override // <-- Hapus duplikasi @override di sini
  void initState() {
    super.initState();
    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fabAnimation = CurvedAnimation(
      parent: _fabAnimationController,
      curve: Curves.easeInOut,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Ambil lokasi jika belum ada yang di-load dari SharedPrefs
      final provider = context.read<GeminiProvider>();
      if (provider.currentLocation == null && provider.locationError == null) {
        _requestLocationPermission();
      }
      _fabAnimationController.forward();
    });

    _scrollController.addListener(() {
      if (_scrollController.offset > 100) {
        _fabAnimationController.forward();
      } else {
        _fabAnimationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    _fabAnimationController.dispose();
    super.dispose();
  }

  void _requestLocationPermission() {
    final provider = context.read<GeminiProvider>();
    // mendapatkan lokasi baru
    provider.getCurrentLocation();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  void _sendMessage([String? customMessage]) {
    final message = customMessage ?? _messageController.text.trim();
    if (message.isEmpty) return;

    _messageController.clear();
    _focusNode.unfocus();

    context.read<GeminiProvider>().sendMessage(message);
    _scrollToBottom();
  }

  void _showOptionsBottomSheet() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[900] : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            _buildBottomSheetItem(
              context,
              Icons.location_on,
              'Perbarui Lokasi',
              'Aktifkan lokasi untuk rekomendasi yang lebih akurat',
              () {
                Navigator.pop(context);
                _requestLocationPermission();
              },
              isDark,
            ),
            _buildBottomSheetItem(
              context,
              Icons.delete_outline,
              'Hapus Riwayat Chat',
              'Bersihkan semua percakapan',
              () {
                Navigator.pop(context);
                _showClearHistoryDialog();
              },
              isDark,
            ),
            _buildBottomSheetItem(
              context,
              Icons.info_outline,
              'Tentang WisataBot',
              'Informasi tentang asisten virtual',
              () {
                Navigator.pop(context);
                _showAboutDialog();
              },
              isDark,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSheetItem(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
    bool isDark,
  ) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (isDark ? Colors.grey[700] : Colors.grey[100]),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: isDark ? Colors.white : Colors.black87,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDark ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: isDark ? Colors.grey[400] : Colors.grey[600],
          fontSize: 12,
        ),
      ),
      onTap: onTap,
    );
  }

  void _showClearHistoryDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Hapus Riwayat Chat'),
        content: const Text(
          'Apakah Anda yakin ingin menghapus semua riwayat percakapan? Tindakan ini tidak dapat dibatalkan.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal', style: TextStyle(color: Colors.grey[600])),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<GeminiProvider>().clearHistory();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Riwayat chat berhasil dihapus'),
                  duration: const Duration(seconds: 2),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: AppColors.oceanGradient),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.smart_toy, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            const Text('MyAI - WisataBot'),
          ],
        ),
        content: const Text(
          'MyAI - WisataBot adalah asisten virtual yang dibuat oleh Grup Capstone B25-PG002 untuk membantu wisatawan menemukan informasi pariwisata terbaik di Indonesia.\n\n'
          '✨ Fitur Unggulan:\n'
          '• Rekomendasi tempat wisata berdasarkan lokasi\n'
          '• Informasi hotel dan penginapan terpercaya\n'
          '• Kuliner khas daerah Indonesia\n'
          '• Rute transportasi dan panduan perjalanan\n'
          '• Informasi budaya dan sejarah lokal\n\n'
          '🤖 Didukung oleh teknologi Google Gemini AI untuk memberikan rekomendasi yang akurat dan personal.',
          style: TextStyle(height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: isDark ? Colors.grey[900] : Colors.white,
        title: Row(
          children: [
            Hero(
              tag: "chatbot-avatar",
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: AppColors.oceanGradient),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.oceanBlue.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.smart_toy,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MyAI - WisataBot',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : AppColors.navy,
                    ),
                  ),
                  Consumer<GeminiProvider>(
                    builder: (context, provider, _) {
                      if (provider.isLoading) {
                        return Row(
                          children: [
                            SizedBox(
                              width: 12,
                              height: 12,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.green[600]!,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Sedang mengetik...',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.green[600],
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        );
                      }
                      return Text(
                        'Asisten Wisata Virtual',
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? Colors.grey[400] : Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : AppColors.navy,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Consumer<GeminiProvider>(
            builder: (context, provider, _) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                child: IconButton(
                  onPressed: provider.isLoading
                      ? null
                      : _requestLocationPermission,
                  tooltip: provider.currentLocation != null
                      ? 'Lokasi aktif'
                      : 'Aktifkan lokasi',
                  icon: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        provider.currentLocation != null
                            ? Icons.location_on
                            : Icons.location_off,
                        color: provider.currentLocation != null
                            ? Colors.green
                            : (isDark ? Colors.grey[400] : Colors.grey[600]),
                      ),
                      // Tampilkan loading hanya jika provider sedang mengambil lokasi
                      if (provider.isLoading)
                        Positioned.fill(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.oceanBlue,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: isDark ? Colors.grey[400] : Colors.grey[600],
            ),
            onPressed: _showOptionsBottomSheet,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Consumer<GeminiProvider>(
              builder: (context, provider, _) {
                if (provider.locationError != null) {
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    color: Colors.orange[100],
                    child: Row(
                      children: [
                        Icon(
                          Icons.warning_rounded,
                          color: Colors.orange[800],
                          size: 18,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Lokasi Tidak Tersedia',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.orange[800],
                                ),
                              ),
                              Text(
                                provider.locationError!,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.orange[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: _requestLocationPermission,
                          child: Text(
                            'Coba Lagi',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.orange[800],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),

            // Chat Messages
            Expanded(
              child: Consumer<GeminiProvider>(
                builder: (context, provider, _) {
                  return ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount:
                        provider.historyChats.length +
                        (provider.isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == provider.historyChats.length &&
                          provider.isLoading) {
                        return const TypingIndicator();
                      }

                      final message = provider.historyChats[index];
                      return ChatMessageBubble(
                        message: message,
                        onRecommendationTap: () {
                          // Handle recommendation tap - you can implement detailed view here
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                'Fitur detail akan segera hadir!',
                              ),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),

            // Quick Suggestions
            Consumer<GeminiProvider>(
              builder: (context, provider, _) {
                final hasUserMessages = provider.historyChats.any(
                  (message) => message.isUser,
                );

                if (hasUserMessages || provider.isLoading) {
                  return const SizedBox.shrink();
                }

                return Flexible(
                  child: SingleChildScrollView(
                    child: QuickSuggestions(onSuggestionTap: _sendMessage),
                  ),
                );
              },
            ),

            // Input Area
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[900] : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: isDark
                        ? Colors.black.withOpacity(0.3)
                        : Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: isDark ? Colors.grey[800] : Colors.grey[100],
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: isDark
                                ? Colors.grey[600]!
                                : Colors.grey[300]!,
                          ),
                        ),
                        child: TextField(
                          controller: _messageController,
                          focusNode: _focusNode,
                          maxLines: null,
                          textInputAction: TextInputAction.send,
                          onSubmitted: (_) => _sendMessage(),
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Tanya tentang wisata Indonesia...',
                            hintStyle: TextStyle(
                              color: isDark ? Colors.grey[400] : Colors.grey,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            prefixIcon: Icon(
                              Icons.chat_bubble_outline,
                              color: isDark ? Colors.grey[400] : Colors.grey,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Consumer<GeminiProvider>(
                      builder: (context, provider, _) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: provider.isLoading
                                  ? [Colors.grey, Colors.grey.shade400]
                                  : AppColors.oceanGradient,
                            ),
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    (provider.isLoading
                                            ? Colors.grey
                                            : AppColors.oceanBlue)
                                        .withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: IconButton(
                            onPressed: provider.isLoading
                                ? null
                                : () => _sendMessage(),
                            icon: provider.isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                : const Icon(
                                    Icons.send_rounded,
                                    color: Colors.white,
                                  ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Consumer<GeminiProvider>(
        builder: (context, provider, _) {
          if (MediaQuery.of(context).viewInsets.bottom > 0 ||
              provider.historyChats.length <= 1) {
            return const SizedBox.shrink();
          }

          return Padding(
            // ⬆️ Atur jarak dari bawah biar gak nutup tombol kirim
            padding: const EdgeInsets.only(bottom: 70.0),
            child: ScaleTransition(
              scale: _fabAnimation,
              child: FloatingActionButton.small(
                onPressed: _scrollToBottom,
                backgroundColor: AppColors.oceanBlue,
                child: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
