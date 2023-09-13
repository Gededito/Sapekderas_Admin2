import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sapekderas/models/user_model.dart';
import 'package:sapekderas/view_model/auth/cubit/get_user_state.dart';

class GetUserCubit extends Cubit<GetUserState> {
  final collection = FirebaseFirestore.instance
      .collection('users')
      .withConverter<UserModel>(
        fromFirestore: (snapshots, _) =>
            UserModel.fromJson(snapshots.data()!),
        toFirestore: (user, _) => user.toJson(),
      );
  GetUserCubit() : super(GetUserInitial());

  void getAllData() async {
    emit(GetUserLoading());
    List<UserModel> allData = [];
    List<UserModel> successData = [];
    List<UserModel> errorData = [];
    List<UserModel> progressData = [];

    try {
      final querySnapshot = await collection.get();
      for (var element in querySnapshot.docs) {
        allData.add(element.data());
      }
      emit(GetUserSuccess(
        allData: allData,
        successData: successData,
        errorData: errorData,
        progressData: progressData
      ));
    } catch (e) {
      emit(GetUserError(e.toString()));
    }
  }
}