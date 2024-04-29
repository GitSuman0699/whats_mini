import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiService {
  GeminiService();
  final gemini = Gemini.instance;

  GeminiService._privateConstructor();
  static final GeminiService _instance = GeminiService._privateConstructor();
  static GeminiService get instance => _instance;
}
