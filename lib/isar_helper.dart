import 'package:gemini_bot/chat/model/chat_model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarHelper {
  IsarHelper._privateConstructor();
  static final IsarHelper _instance = IsarHelper._privateConstructor();
  static IsarHelper get instance => _instance;

  Isar? db;

  init() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      if (Isar.instanceNames.isEmpty) {
        db = await Isar.open(
          [ChatModelSchema],
          directory: dir.path,
          inspector: true,
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
