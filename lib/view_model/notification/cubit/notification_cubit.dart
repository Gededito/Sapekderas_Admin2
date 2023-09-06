import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/notification.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final collection = FirebaseFirestore.instance
      .collection('notifications')
      .withConverter<NotificationModel>(
        fromFirestore: (snapshots, _) =>
            NotificationModel.fromJson(snapshots.data()!),
        toFirestore: (notification, _) => notification.toJson(),
      );
  NotificationCubit() : super(NotificationInitial());

  void getNotificationByAdmin() async {
    try {
      emit(NotificationLoading());
      List<NotificationModel> allData = [];

      // final user = HiveServices(Hive).getUser();

      final querySnapshot =
          await collection.where('user_type', isEqualTo: "admin").get();

      for (var element in querySnapshot.docs) {
        allData.add(element.data());
      }

      allData.sort((a, b) => a.createdAt!.millisecondsSinceEpoch
          .compareTo(b.createdAt!.millisecondsSinceEpoch));

      if (kDebugMode) {
        print("allData: ${allData.toString()}");
      }

      emit(NotificationSuccess(allData));
    } catch (e, s) {
      if (kDebugMode) {
        print("error: ${e.toString()}, Stackrace: $s");
      }
      emit(NotificationError(e.toString()));
    }
  }
}
