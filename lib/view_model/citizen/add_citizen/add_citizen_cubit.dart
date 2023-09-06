import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sapekderas/models/citizen_model.dart';
import 'package:uuid/uuid.dart';

part 'add_citizen_state.dart';

class AddCitizenCubit extends Cubit<AddCitizenState> {
  final collection = FirebaseFirestore.instance
      .collection('citizens')
      .withConverter<CitizenModel>(
        fromFirestore: (snapshots, _) =>
            CitizenModel.fromJson(snapshots.data()!),
        toFirestore: (citizen, _) => citizen.toJson(),
      );
  AddCitizenCubit() : super(AddCitizenInitial());

  void addCitizen(CitizenModel data) async {
    emit(AddCitizenLoading());
    try {
      final querySnapshot =
          await collection.where('nik', isEqualTo: data.nik).get();

      if (querySnapshot.docs.isEmpty) {
        await collection.add(data.copyWith(id: const Uuid().v4()));
        emit(AddCitizenSuccess());
      } else {
        emit(const AddCitizenError("NIK sudah terdaftar"));
      }
    } catch (e) {
      emit(AddCitizenError(e.toString()));
    }
  }
}
