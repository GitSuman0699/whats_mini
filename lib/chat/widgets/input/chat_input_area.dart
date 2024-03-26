import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_bot/chat/controller/chat_controller.dart';
import 'package:gemini_bot/chat/widgets/input/chat_input_card.dart';
import 'package:gemini_bot/chat/widgets/input/chat_keyboard.dart';
import 'package:gemini_bot/theme.dart';
import 'package:image_picker/image_picker.dart';

class ChatInputArea extends ConsumerStatefulWidget {
  const ChatInputArea({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatInputAreaState();
}

class _ChatInputAreaState extends ConsumerState<ChatInputArea> {
  final _inputController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool showAttachFileSheet = true;
  final ImagePicker _picker = ImagePicker();
  Uint8List? _photo;
  String? p;

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeNotifierProvider) == Brightness.dark;
    return Column(
      children: [
        if (_photo != null)
          Stack(
            children: [
              ChatAttachmentCard(
                height: MediaQuery.of(context).size.height * .1,
                isDark: isDark,
                photo: _photo!,
              ),
              Positioned(
                right: 10,
                top: 0,
                bottom: 0,
                child: TextButton(
                  onPressed: () {
                    _photo = null;
                    setState(() {});
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        const SizedBox(height: 3),
        SafeArea(
          child: Row(
            children: [
              Expanded(
                child: ChatKeyboard(
                  focusNode: _focusNode,
                  controller: _inputController,
                  showReplyBox: false,
                  attachFile: toggleAttachFileSheet,
                  attachCamera: attachCamera,
                  attachGallery: attachGallery,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3, right: 3, bottom: 5),
                child: SizedBox(
                  width: 48,
                  height: 48,
                  child: FloatingActionButton(
                    elevation: 0,
                    onPressed: () async {
                      // _focusNode.unfocus();
                      String text = _inputController.text.trim();
                      Uint8List? photo = _photo;
                      _inputController.clear();
                      _photo = null;
                      setState(() {});
                      await ref.watch(chatProvider.notifier).updateUserMessage(
                            text: text,
                            photo: photo,
                            p: p,
                            ref: ref,
                            context: context,
                          );
                    },
                    child: const Icon(Icons.send),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void toggleAttachFileSheet() {
    setState(() {
      showAttachFileSheet = !showAttachFileSheet;
    });
  }

  void attachCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      p = pickedFile.path;
      pickedFile.readAsBytes().then(
            (value) => setState(
              () {
                _photo = value;
              },
            ),
          );
    } else {
      debugPrint("No image selected");
    }
  }

  void attachGallery() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (pickedFile != null) {
      p = pickedFile.path;

      pickedFile.readAsBytes().then(
            (value) => setState(
              () {
                _photo = value;
              },
            ),
          );
    } else {
      debugPrint("No image selected");
    }
  }
}
