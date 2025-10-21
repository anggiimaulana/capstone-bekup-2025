import 'package:capstone/widget/markdown_text_widget.dart';
import 'package:flutter/material.dart';

class ChatText extends StatelessWidget {
  final String text;
  final Color? textColor;
  final bool isUser;

  const ChatText({
    super.key,
    required this.text,
    this.textColor,
    this.isUser = false,
  });

  @override
  Widget build(BuildContext context) {
    // For user messages, just show plain text
    if (isUser) {
      return Text(
        text,
        style: TextStyle(
          color: textColor ?? Colors.white,
          fontSize: 14,
          height: 1.4,
        ),
      );
    }

    // For bot messages, parse markdown
    return MarkdownTextWidget(text: text, textColor: textColor);
  }
}
