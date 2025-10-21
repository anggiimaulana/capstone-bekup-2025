import 'dart:async';
import 'dart:math';
import 'package:capstone/style/colors.dart';
import 'package:flutter/material.dart';

class ChatBotIcon extends StatefulWidget {
  final VoidCallback onPressed;
  const ChatBotIcon({super.key, required this.onPressed});

  @override
  State<ChatBotIcon> createState() => _ChatBotIconState();
}

class _ChatBotIconState extends State<ChatBotIcon>
    with TickerProviderStateMixin {
  late AnimationController _wiggleController;
  late Animation<double> _wiggleAnimation;
  Timer? _wiggleTimer;

  @override
  void initState() {
    super.initState();
    _setupWiggleAnimation();
    _startWiggleTimer();
  }

  void _setupWiggleAnimation() {
    _wiggleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Animasi wiggle: kiri atas -> kanan bawah -> kiri atas
    _wiggleAnimation =
        TweenSequence<double>([
          TweenSequenceItem(tween: Tween<double>(begin: 0, end: 1), weight: 50),
          TweenSequenceItem(tween: Tween<double>(begin: 1, end: 0), weight: 50),
        ]).animate(
          CurvedAnimation(parent: _wiggleController, curve: Curves.easeInOut),
        );
  }

  void _startWiggleTimer() {
    // Mulai wiggle setelah 2 detik, lalu ulangi setiap 4 detik
    _wiggleTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted) {
        _wiggleController.forward().then((_) {
          if (mounted) {
            _wiggleController.reset();
          }
        });
      }
    });

    // Wiggle pertama kali setelah 2 detik
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        _wiggleController.forward().then((_) {
          if (mounted) {
            _wiggleController.reset();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _wiggleController.dispose();
    _wiggleTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _wiggleAnimation,
      builder: (context, child) {
        // Hitung offset wiggle: kiri atas ke kanan bawah
        final wiggleValue = _wiggleAnimation.value;
        final xOffset = sin(wiggleValue * pi) * 3; // horizontal wiggle
        final yOffset = -cos(wiggleValue * pi * 2) * 2; // vertical bounce

        return Transform.translate(
          offset: Offset(xOffset, yOffset),
          child: Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              color: AppColors.oceanBlue,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(32),
              child: InkWell(
                borderRadius: BorderRadius.circular(32),
                onTap: widget.onPressed,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.smart_toy, color: Colors.white, size: 25),
                    Text(
                      "MyAI",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
