import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gemini_bot/theme.dart';

class ChatAttachmentCard extends StatelessWidget {
  final double height;
  final bool isDark;
  final Uint8List? photo;

  const ChatAttachmentCard({
    Key? key,
    required this.height,
    required this.isDark,
    required this.photo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: height,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: isDark ? kDarkTextFieldBgColor : kLightTextFieldBgColor,
        boxShadow: height == 0
            ? [] // no shadow if the height is 0
            : [
                BoxShadow(
                  color: isDark ? Colors.black12 : Colors.grey.withOpacity(0.8),
                  spreadRadius: 0.5,
                  blurRadius: 1,
                  offset: Offset.zero,
                ),
              ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.memory(
                photo!,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
