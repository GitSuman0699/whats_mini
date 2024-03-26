import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_bot/chat/pages/chat_room.dart';
import 'package:gemini_bot/isar_helper.dart';
import 'package:gemini_bot/onboard/api_key.dart';
import 'package:gemini_bot/theme.dart';
import 'package:gemini_bot/util/share_pref.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.instance.init();
  await IsarHelper.instance.init();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.watch(themeNotifierProvider);

    return GestureDetector(
      onTap: () {
        if (MediaQuery.of(context).viewInsets.bottom != 0) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: MaterialApp(
        title: 'WhatsMini',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: themeNotifier == Brightness.light
            ? ThemeMode.light
            : ThemeMode.dark,
        home: Prefs.getBool("api_key_set")
            ? const ChatRoomPage()
            : const ApiKeyScreen(),
      ),
    );
  }
}
