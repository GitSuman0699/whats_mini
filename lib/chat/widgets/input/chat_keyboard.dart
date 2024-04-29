import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_bot/chat/controller/chat_controller.dart';
import 'package:gemini_bot/constants.dart';
import 'package:gemini_bot/theme.dart';

class ChatKeyboard extends ConsumerStatefulWidget {
  final bool isOneOnOne;
  final bool showReplyBox;
  final VoidCallback attachFile;
  final VoidCallback attachCamera;
  final VoidCallback attachGallery;
  final TextEditingController controller;
  final FocusNode focusNode;
  const ChatKeyboard({
    super.key,
    required this.showReplyBox,
    required this.attachFile,
    required this.attachCamera,
    required this.attachGallery,
    required this.controller,
    required this.focusNode,
    required this.isOneOnOne,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatKeyboardState();
}

class _ChatKeyboardState extends ConsumerState<ChatKeyboard> {
  late final _focusNode = FocusNode();
  bool shouldShowEmojis = false;

  void onEmojiTap() {
    setState(() {
      shouldShowEmojis = !shouldShowEmojis;
    });
    if (shouldShowEmojis) {
      FocusScope.of(context).unfocus();
    } else {
      FocusScope.of(context).requestFocus(_focusNode);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeNotifierProvider) == Brightness.dark;
    final fill = isDark ? kDarkTextFieldBgColor : Colors.white;
    return Padding(
      padding: const EdgeInsets.only(left: 6.0, right: 2.0, bottom: 6.0),
      child: PhysicalModel(
        color: Colors.grey,
        elevation: 2.0,
        borderRadius: BorderRadius.circular(20),
        child: Column(
          children: [
            TextField(
              // readOnly: ref.watch(isLoadingProvider) ? true : false,
              focusNode: widget.focusNode,
              controller: widget.controller,
              decoration: InputDecoration(
                fillColor: fill,
                filled: true,
                hintText: "Type a message",
                isDense: false,
                prefixIcon: _KeyboardButton(
                  fill: fill,
                  onTap: () {},
                  icon: Icons.emoji_emotions_outlined,
                ),
                suffixIcon: widget.isOneOnOne
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Transform.rotate(
                            angle: -1,
                            child: _KeyboardButton(
                              onTap: widget.attachGallery,
                              icon: Icons.attach_file,
                              fill: fill,
                            ),
                          ),
                          _KeyboardButton(
                            onTap: widget.attachCamera,
                            icon: Icons.camera_alt,
                            fill: fill,
                          ),
                        ],
                      )
                    : SizedBox.shrink(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: widget.showReplyBox
                        ? Radius.zero
                        : const Radius.circular(20),
                    topRight: widget.showReplyBox
                        ? Radius.zero
                        : const Radius.circular(20),
                    bottomLeft: const Radius.circular(20),
                    bottomRight: const Radius.circular(20),
                  ),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: widget.showReplyBox
                        ? Radius.zero
                        : const Radius.circular(20),
                    topRight: widget.showReplyBox
                        ? Radius.zero
                        : const Radius.circular(20),
                    bottomLeft: const Radius.circular(20),
                    bottomRight: const Radius.circular(20),
                  ),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.all(10.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _KeyboardButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final Color fill;
  const _KeyboardButton({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.fill,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: fill,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: IconButton(
          onPressed: null,
          splashRadius: kDefaultSplashRadius,
          icon: Icon(
            icon,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
