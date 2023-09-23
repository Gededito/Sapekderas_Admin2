import 'package:hive_flutter/hive_flutter.dart';

import '../user_model.dart';

class HiveServices {
  static HiveServices? _hiveService;

  HiveServices._instance(this._hive) {
    _hiveService = this;
  }

  factory HiveServices(hive) => _hiveService ?? HiveServices._instance(hive);

  final HiveInterface _hive;

  /// user
  final _boxUser = "user";
  final _keyUser = "key-user";

  Future<void> init() async {
    await _hive.initFlutter();
    registerAdapter();
    await openBox();
  }

  /// Register Adapter
  void registerAdapter() {
    if (!_hive.isAdapterRegistered(0)) {
      _hive.registerAdapter<UserModel>(UserModelAdapter());
    }
  }

  /// Open Box
  Future<void> openBox() async {
    // Open Box Device Info
    if (!_hive.isBoxOpen(_boxUser)) {
      await _hive.openBox<UserModel>(_boxUser);
    }
  }

  /// User Local Storage
  // Get User from local storage.
  UserModel getUser() {
    return _hive.box<UserModel>(_boxUser).get(_keyUser) ??
        UserModel(email: "", password: "", id: "");
  }

  // Store User to local storage.
  Future<void> storeUser(UserModel data) async {
    if (!_hive.isBoxOpen(_boxUser)) {
      await _hive.openBox<UserModel>(_boxUser);
    }
    await _hive.box<UserModel>(_boxUser).put(_keyUser, data);
  }

  Future<void> deleteAll() async {
    await _hive.deleteFromDisk();
  }
}
