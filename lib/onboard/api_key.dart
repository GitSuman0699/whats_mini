import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_bot/chat/pages/chat_room.dart';
import 'package:gemini_bot/chat/widgets/chat_room_scaffold.dart';
import 'package:gemini_bot/dialog_components.dart';
import 'package:gemini_bot/functions.dart';
import 'package:gemini_bot/theme.dart';
import 'package:gemini_bot/util/share_pref.dart';

class ApiKeyScreen extends ConsumerStatefulWidget {
  const ApiKeyScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ApiKeyScreenState();
}

class _ApiKeyScreenState extends ConsumerState<ApiKeyScreen> {
  final TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeNotifierProvider) == Brightness.dark;
    return ChatRoomScaffold(
      appBar: null,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                gotoUrl(url: "https://ai.google.dev/");
              },
              child: const Text("GET YOUR API KEY"),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'click on "GET YOUR API KEY" to get your API key, \n Note: Please enable "Desktop Site" in your browser\n You can also watch tutorial video by the link given below',
                textAlign: TextAlign.center,
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
              ),
            ),
            TextButton(
              onPressed: () {
                gotoUrl(url: "https://youtube.com/shorts/AJH8nJ8HNAI");
              },
              child: const Text("API KEY TUTORIAL"),
            ),
            TextFieldWidget(
              textEditingController: textEditingController,
              isDark: isDark,
            ),
            ElevatedButton(
              onPressed: () async {
                if (textEditingController.text.isNotEmpty) {
                  Prefs.setBool("api_key_set", true);
                  Prefs.setString("api_key", textEditingController.text.trim());
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const ChatRoomPage();
                      },
                    ),
                  );
                } else {
                  DialogComponents.snackBar(context, "API key is empty");
                }
              },
              child: const Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }
}

class TextFieldWidget extends ConsumerStatefulWidget {
  final TextEditingController textEditingController;
  final bool isDark;
  const TextFieldWidget({
    super.key,
    required this.textEditingController,
    required this.isDark,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TextFieldWidgetState();
}

class _TextFieldWidgetState extends ConsumerState<TextFieldWidget> {
  bool visible = false;
  @override
  Widget build(BuildContext context) {
    final fill = widget.isDark ? kDarkTextFieldBgColor : Colors.white;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: widget.textEditingController,
        obscureText: visible ? false : true,
        decoration: InputDecoration(
          fillColor: fill,
          filled: true,
          hintText: "Gemini API Key ",
          isDense: false,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                visible ? visible = false : visible = true;
              });
            },
            icon: visible
                ? const Icon(Icons.visibility_outlined)
                : const Icon(Icons.visibility_off_outlined),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            borderSide: BorderSide.none,
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.all(10.0),
        ),
      ),
    );
  }
}
