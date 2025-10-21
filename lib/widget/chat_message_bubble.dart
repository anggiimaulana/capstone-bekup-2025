import 'package:capstone/provider/gemini_provider.dart';
import 'package:capstone/widget/chat_text.dart';
import 'package:capstone/widget/recommendation_card.dart';
import 'package:flutter/material.dart';
import 'package:capstone/style/colors.dart';

class ChatMessageBubble extends StatelessWidget {
  final ChatMessage message;
  final VoidCallback? onRecommendationTap;

  const ChatMessageBubble({
    super.key,
    required this.message,
    this.onRecommendationTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: message.isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            _buildBotAvatar(isDark),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: message.isUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                _buildMessageContainer(context, isDark),
                if (message.recommendations != null &&
                    message.recommendations!.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  ...message.recommendations!.map(
                    (rec) => RecommendationCard(
                      recommendation: rec,
                      onTap: onRecommendationTap,
                    ),
                  ),
                ],
                const SizedBox(height: 4),
                _buildTimestamp(isDark),
              ],
            ),
          ),
          if (message.isUser) ...[
            const SizedBox(width: 8),
            _buildUserAvatar(isDark),
          ],
        ],
      ),
    );
  }

  Widget _buildBotAvatar(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.oceanBlue, AppColors.oceanBlue.withOpacity(0.8)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.oceanBlue.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Icon(Icons.smart_toy, color: Colors.white, size: 16),
    );
  }

  Widget _buildUserAvatar(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[700] : Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(
        Icons.person,
        color: isDark ? Colors.grey[300] : Colors.grey[600],
        size: 16,
      ),
    );
  }

  Widget _buildMessageContainer(BuildContext context, bool isDark) {
    Color backgroundColor;
    Color textColor;

    if (message.isUser) {
      backgroundColor = AppColors.oceanBlue;
      textColor = Colors.white;
    } else {
      backgroundColor = isDark ? Colors.grey[800]! : Colors.white;
      textColor = isDark ? Colors.white : Colors.black87;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
          bottomLeft: Radius.circular(message.isUser ? 20 : 4),
          bottomRight: Radius.circular(message.isUser ? 4 : 20),
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.3)
                : Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (message.messageType == MessageType.error) ...[
            Row(
              children: [
                Icon(Icons.error_outline, color: textColor, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Terjadi Kesalahan',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: textColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
          ],
          ChatText(
            text: message.text,
            textColor: textColor,
            isUser: message.isUser,
          ),
        ],
      ),
    );
  }

  Widget _buildTimestamp(bool isDark) {
    return Text(
      _formatTime(message.timestamp),
      style: TextStyle(
        fontSize: 11,
        color: isDark ? Colors.grey[400] : Colors.grey[500],
      ),
    );
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
