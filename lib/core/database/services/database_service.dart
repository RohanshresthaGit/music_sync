import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

// import '../models/user_local_model.dart';
// import '../models/product_local_model.dart';
// import '../models/settings_local_model.dart';

abstract class IDatabaseService {
  Future<void> init();

  Isar get db;

  Future<void> clear();

  Future<void> close();
}

class DatabaseService
    implements IDatabaseService {
  static DatabaseService? _instance;

  DatabaseService._();

  factory DatabaseService() {
    _instance ??= DatabaseService._();
    return _instance!;
  }

  late final Isar _isar;

  @override
  Isar get db => _isar;

  @override
  Future<void> init() async {
    if (Isar.instanceNames.isNotEmpty) {
      _isar = Isar.getInstance()!;
      return;
    }

    final dir =
        await getApplicationDocumentsDirectory();

    _isar = await Isar.open(
      [
        /// REGISTER ALL SCHEMAS HERE
        // UserLocalModelSchema,
        // ProductLocalModelSchema,
        // SettingsLocalModelSchema,
      ],
      directory: dir.path,
      inspector: true,
    );
  }

  @override
  Future<void> clear() async {
    await _isar.writeTxn(() async {
      await _isar.clear();
    });
  }

  @override
  Future<void> close() async {
    await _isar.close();
  }
}