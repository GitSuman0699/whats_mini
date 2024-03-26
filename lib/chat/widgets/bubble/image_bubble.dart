// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gemini_bot/chat/model/chat_model.dart';
import 'package:gemini_bot/chat/widgets/bubble/chat_bubble_bottom.dart';

const double kBubbleRadius = 16;

class ImageBubble extends StatelessWidget {
  final Widget image;
  final ChatModel model;
  final double bubbleRadius;
  final bool isSender;
  final Color color;
  final bool tail;
  final bool isDark;
  final void Function()? onTap;

  const ImageBubble({
    Key? key,
    required this.image,
    this.bubbleRadius = kBubbleRadius,
    this.isSender = true,
    this.color = Colors.white70,
    this.tail = true,
    required this.isDark,
    this.onTap,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
            minWidth: 75,
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(bubbleRadius),
                    topRight: Radius.circular(bubbleRadius),
                    bottomLeft: Radius.circular(tail
                        ? isSender
                            ? bubbleRadius
                            : 0
                        : kBubbleRadius),
                    bottomRight: Radius.circular(tail
                        ? isSender
                            ? 0
                            : bubbleRadius
                        : kBubbleRadius),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(bubbleRadius),
                    child: image,
                  ),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 6,
                child: ChatBubbleBottom(
                  model: model,
                  isDark: isDark,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
