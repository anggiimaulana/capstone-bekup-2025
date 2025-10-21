import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

class MessageBubble extends StatelessWidget {
  final String content;
  final bool isMyChat;
  final List<String>? imagePath;

  const MessageBubble({
    super.key,
    required this.content,
    this.isMyChat = false,
    this.imagePath,
  });

  final textStyle = const TextStyle(color: Colors.black54, fontSize: 12.0);

  final senderBorderRadius = const BorderRadius.only(
    topLeft: Radius.circular(20),
    bottomLeft: Radius.circular(20),
    topRight: Radius.circular(20),
  );

  final otherBorderRadius = const BorderRadius.only(
    topRight: Radius.circular(20),
    topLeft: Radius.circular(20),
    bottomRight: Radius.circular(20),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: isMyChat
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          if (imagePath != null)
            ...imagePath!.map(
              (path) => _BubbleCard(
                color: isMyChat ? Colors.green.shade100 : Colors.white,
                borderRadius: isMyChat ? senderBorderRadius : otherBorderRadius,
                child: Image.file(File(path)),
              ),
            ),
          _BubbleCard(
            color: isMyChat ? Colors.green.shade100 : Colors.white,
            borderRadius: isMyChat ? senderBorderRadius : otherBorderRadius,
            child: MarkdownBody(data: content),
          ),
        ],
      ),
    );
  }
}

class _BubbleCard extends StatelessWidget {
  const _BubbleCard({
    required this.color,
    required this.borderRadius,
    required this.child,
  });

  final Color color;
  final BorderRadius borderRadius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: child,
      ),
    );
  }
}
