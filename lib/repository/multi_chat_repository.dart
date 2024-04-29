import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:gemini_bot/gemini_service/gemini_service.dart';

class MultiChatRepository extends GeminiService {
  MultiChatRepository._();
  static final instance = MultiChatRepository._();

  Future<String?> getMultiChatResponse({required List<Content> content}) async {
    final response = await gemini.chat(content);

    return response?.content?.parts?.last.text;
  }
}

// Content(parts: [
//   Parts(text: 'Write the first line of a story about a magic backpack.')],
//     role: 'user'),
// Content(parts: [
//   Parts(text: 'In the bustling city of Meadow brook, lived a young girl named Sophie. She was a bright and curious soul with an imaginative mind.')],
//     role: 'model'),
// Content(parts: [
//   Parts(text: 'Can you set it in a quiet village in 1600s France?')],
//     role: 'user'),


// .then((value) => log(value?.output ?? 'without output'))
//         .catchError((e) => log('chat', error: e));






          