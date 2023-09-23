import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sapekderas/models/notification.dart';
import 'package:uuid/uuid.dart';

import '../../../models/user_model.dart';

part 'get_user_state.dart';

class GetUserCubit extends Cubit<GetUserState> {
  final collection = FirebaseFirestore.instance
      .collection('users')
      .withConverter<UserModel>(
        fromFirestore: (snapshots, _) => UserModel.fromJson(snapshots.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

  final notification = FirebaseFirestore.instance
      .collection('notifications')
      .withConverter<NotificationModel>(
        fromFirestore: (snapshots, _) =>
            NotificationModel.fromJson(snapshots.data()!),
        toFirestore: (notification, _) => notification.toJson(),
      );
  GetUserCubit() : super(GetUserInitial());

  void getAllData() async {
    emit(GetUserLoading());
    List<UserModel> allData = [];

    try {
      final querySnapshot =
          await collection.where("type", isEqualTo: "user").get();

      for (var element in querySnapshot.docs) {
        allData.add(element.data());
      }
      emit(GetUserSuccess(
        allData: allData,
      ));
    } catch (e) {
      emit(GetUserError(e.toString()));
    }
  }

  void verifyUser(UserModel model) async {
    var state = this.state;

    if (state is GetUserSuccess) {
      collection.where("id", isEqualTo: model.id).get().then((value) {
        if (value.docs.isNotEmpty) {
          value.docs.first.reference.set(model);
          Fluttertoast.showToast(msg: "User berhasil diverifikasi");

          notification.add(
            NotificationModel(
              id: const Uuid().v4(),
              message: "Account anda berhasil diverifikasi",
              userId: model.id,
              userType: "user",
              createdAt: DateTime.now(),
            ),
          );

          List<UserModel> oldUser = state.allData;

          for (var i = 0; i < oldUser.length; i++) {
            if (oldUser[i].id == model.id) {
              oldUser[i] = model;
            }
          }

          int increment = state.increment + 1;

          emit(GetUserSuccess(
              allData: oldUser, isLoading: false, increment: increment));
        }
      });
    }
  }
}
