import 'package:flutter/material.dart';

class TextFieldSender extends StatefulWidget {
  final Function()? galleryOnPressed;
  final Function(String message)? sendOnPressed;

  const TextFieldSender({super.key, this.galleryOnPressed, this.sendOnPressed});

  @override
  State<TextFieldSender> createState() => _TextFieldSenderState();
}

class _TextFieldSenderState extends State<TextFieldSender> {
  final contentController = TextEditingController();
  final contentFocus = FocusNode();

  @override
  void dispose() {
    contentController.dispose();
    contentFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      spacing: 4,
      children: [
        Expanded(
          child: TextField(
            controller: contentController,
            focusNode: contentFocus,
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 2,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade200,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 14,
              ),
              prefixIcon: widget.galleryOnPressed == null
                  ? null
                  : IconButton(
                      icon: const Icon(Icons.photo_outlined),
                      color: Theme.of(context).colorScheme.primary,
                      onPressed: () {
                        contentController.clear();
                        contentFocus.unfocus();
                        widget.galleryOnPressed!();
                      },
                    ),
              suffixIcon: ListenableBuilder(
                listenable: contentController,
                builder: (context, child) {
                  return contentController.text.isEmpty ? SizedBox() : child!;
                },
                child: IconButton(
                  icon: const Icon(Icons.close),
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: contentController.clear,
                ),
              ),
            ),
          ),
        ),
        DecoratedBox(
          decoration: ShapeDecoration(
            color: Theme.of(context).colorScheme.primary,
            shape: const CircleBorder(),
          ),
          child: ListenableBuilder(
            listenable: contentController,
            builder: (context, child) {
              return IconButton(
                icon: const Icon(Icons.send),
                color: Theme.of(context).colorScheme.onPrimary,
                onPressed: contentController.text.isEmpty
                    ? null
                    : () {
                        final message = contentController.text;
                        contentController.clear();
                        contentFocus.unfocus();
                        widget.sendOnPressed!(message);
                      },
              );
            },
          ),
        ),
      ],
    );
  }
}
