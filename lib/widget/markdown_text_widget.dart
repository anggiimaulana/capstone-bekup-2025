import 'package:flutter/material.dart';

class MarkdownTextWidget extends StatelessWidget {
  final String text;
  final TextStyle? baseStyle;
  final Color? textColor;

  const MarkdownTextWidget({
    super.key,
    required this.text,
    this.baseStyle,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultColor = textColor ?? (isDark ? Colors.white : Colors.black87);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _parseMarkdownText(text, defaultColor, context),
    );
  }

  List<Widget> _parseMarkdownText(
    String text,
    Color textColor,
    BuildContext context,
  ) {
    final widgets = <Widget>[];
    final lines = text.split('\n');

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];

      if (line.trim().isEmpty) {
        widgets.add(const SizedBox(height: 8));
        continue;
      }

      // Handle headers (### text)
      if (line.startsWith('###')) {
        widgets.add(_buildHeader(line.substring(3).trim(), textColor, 16));
        widgets.add(const SizedBox(height: 8));
        continue;
      }

      // Handle headers (## text)
      if (line.startsWith('##')) {
        widgets.add(_buildHeader(line.substring(2).trim(), textColor, 18));
        widgets.add(const SizedBox(height: 8));
        continue;
      }

      // Handle headers (# text)
      if (line.startsWith('#')) {
        widgets.add(_buildHeader(line.substring(1).trim(), textColor, 20));
        widgets.add(const SizedBox(height: 8));
        continue;
      }

      // Handle bullet points (• text, * text, - text)
      if (line.startsWith('•') ||
          line.startsWith('*') ||
          line.startsWith('-')) {
        widgets.add(_buildBulletPoint(line, textColor));
        continue;
      }

      // Handle numbered lists (1. text, 2. text, etc.)
      if (RegExp(r'^\d+\.\s').hasMatch(line)) {
        widgets.add(_buildNumberedPoint(line, textColor));
        continue;
      }

      // Handle regular text with bold and italic
      widgets.add(_buildRichText(line, textColor));
      widgets.add(const SizedBox(height: 4));
    }

    return widgets;
  }

  Widget _buildHeader(String text, Color color, double fontSize) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: color,
          height: 1.2,
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String line, Color color) {
    String cleanLine = line;
    if (line.startsWith('• ')) {
      cleanLine = line.substring(2);
    } else if (line.startsWith('* ')) {
      cleanLine = line.substring(2);
    } else if (line.startsWith('- ')) {
      cleanLine = line.substring(2);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 4, left: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 8, right: 8),
            width: 4,
            height: 4,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          Expanded(child: _buildRichText(cleanLine, color)),
        ],
      ),
    );
  }

  Widget _buildNumberedPoint(String line, Color color) {
    final match = RegExp(r'^(\d+)\.\s(.*)').firstMatch(line);
    if (match == null) return _buildRichText(line, color);

    final number = match.group(1)!;
    final content = match.group(2)!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4, left: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 20,
            child: Text(
              '$number.',
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(child: _buildRichText(content, color)),
        ],
      ),
    );
  }

  Widget _buildRichText(String text, Color color) {
    final spans = <TextSpan>[];
    final regex = RegExp(r'\*\*(.*?)\*\*|\*(.*?)\*|`(.*?)`');
    int lastEnd = 0;

    for (final match in regex.allMatches(text)) {
      // Add text before match
      if (match.start > lastEnd) {
        spans.add(
          TextSpan(
            text: text.substring(lastEnd, match.start),
            style: TextStyle(color: color),
          ),
        );
      }

      // Add styled text
      final boldText = match.group(1);
      final italicText = match.group(2);
      final codeText = match.group(3);

      if (boldText != null) {
        // Bold text (**text**)
        spans.add(
          TextSpan(
            text: boldText,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        );
      } else if (italicText != null) {
        // Italic text (*text*)
        spans.add(
          TextSpan(
            text: italicText,
            style: TextStyle(color: color, fontStyle: FontStyle.italic),
          ),
        );
      } else if (codeText != null) {
        // Code text (`text`)
        spans.add(
          TextSpan(
            text: codeText,
            style: TextStyle(
              color: color,
              fontFamily: 'monospace',
              backgroundColor: Colors.grey.withOpacity(0.1),
            ),
          ),
        );
      }

      lastEnd = match.end;
    }

    // Add remaining text
    if (lastEnd < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(lastEnd),
          style: TextStyle(color: color),
        ),
      );
    }

    // If no matches found, return plain text
    if (spans.isEmpty) {
      spans.add(
        TextSpan(
          text: text,
          style: TextStyle(color: color),
        ),
      );
    }

    return RichText(
      text: TextSpan(
        children: spans,
        style: const TextStyle(fontSize: 14, height: 1.4),
      ),
    );
  }
}
