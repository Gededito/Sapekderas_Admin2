import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sapekderas/models/services/hive_services.dart';
import 'package:sapekderas/models/user_model.dart';
import 'package:uuid/uuid.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final collection = FirebaseFirestore.instance
      .collection('users')
      .withConverter<UserModel>(
        fromFirestore: (snapshots, _) => UserModel.fromJson(snapshots.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

  LoginCubit() : super(LoginInitial());

  void loginEvent(UserModel user) async {
    emit(LoginLoading());
    try {
      final querySnapshot =
          await collection.where('email', isEqualTo: user.email).get();

      if (querySnapshot.docs.isNotEmpty) {
        final getUser = querySnapshot.docs.first.data();
        if (_isPasswordCorrect(user.password, getUser.password)) {
          await HiveServices(Hive).storeUser(getUser);
          emit(LoginSuccess());
        } else {
          emit(const LoginError("Password tidak sama"));
        }
      } else {
        emit(const LoginError("User tidak ditemukan"));
      }
    } catch (e, s) {
      debugPrint("loginEvent\nError: ${e.toString()}\nStackRace: $s");

      emit(LoginError(e.toString()));
    }
  }

  void addAdmin() async {
    final password = _hashPassword("12345678");
    final id = const Uuid().v4();
    final user = UserModel(
        email: "test@gmail.com", password: password, id: id, isVerified: true);
    final querySnapshot =
        await collection.where('email', isEqualTo: user.email).get();
    if (querySnapshot.docs.isEmpty) {
      collection.add(user);
    }
  }

  void addAdmin2() async {
    final password = _hashPassword("12345678");
    final id = const Uuid().v4();
    final user = UserModel(
        email: "lurah@gmail.com", password: password, id: id, isVerified: true);
    final querySnapshot =
        await collection.where('email', isEqualTo: user.email).get();
    if (querySnapshot.docs.isEmpty) {
      collection.add(user);
    }
  }

  String _hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  bool _isPasswordCorrect(String enteredPassword, String storedHashedPassword) {
    var enteredPasswordHash = _hashPassword(enteredPassword);
    return enteredPasswordHash == storedHashedPassword;
  }
}
