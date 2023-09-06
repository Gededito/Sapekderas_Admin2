import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../models/citizen_model.dart';
import '../../../models/enums.dart';

part 'get_citizen_state.dart';

class GetCitizenCubit extends Cubit<GetCitizenState> {
  final collection = FirebaseFirestore.instance
      .collection('citizens')
      .withConverter<CitizenModel>(
        fromFirestore: (snapshots, _) =>
            CitizenModel.fromJson(snapshots.data()!),
        toFirestore: (citizen, _) => citizen.toJson(),
      );
  GetCitizenCubit() : super(GetCitizenInitial());

  void getAllCitizen() async {
    List<CitizenModel> allData = [];
    emit(GetCitizenLoading());
    try {
      final querySnapshot = await collection.get();
      for (var element in querySnapshot.docs) {
        allData.add(element.data());
      }
      emit(GetCitizenSuccess(allData, const [], isLoading: false));
    } catch (e) {
      emit(GetCitizenError(e.toString()));
    }
  }

  void searchCitizen(String search, {SearchType? type}) {
    List<CitizenModel> searchData = [];
    var state = this.state;
    if (state is GetCitizenSuccess) {
      final allData = state.allData;
      try {
        emit(GetCitizenLoading());

        var isName = int.tryParse(search);
        if (isName == null) {
          for (var element in allData) {
            if (element.name.contains(search)) {
              searchData.add(element);
            }
          }
        } else {
          for (var element in allData) {
            bool nik = element.nik.toString().contains(search);
            bool kk = element.kk.toString().contains(search);
            if (kk || nik) {
              searchData.add(element);
            }
          }
        }

        emit(GetCitizenSuccess(allData, searchData,
            isLoading: false, type: type));
      } catch (e) {
        emit(GetCitizenSuccess(allData, searchData,
            isLoading: false, type: type));
      }
    } else if (state is GetCitizenInitial || state is GetCitizenError) {
      getAllCitizen();
    }
  }

  void searchNikCitizen(String search, {SearchType? type}) {
    List<CitizenModel> searchData = [];
    var state = this.state;
    if (state is GetCitizenSuccess) {
      final allData = state.allData;
      try {
        emit(GetCitizenLoading());

        for (var element in allData) {
          if (element.nik.toString() == search) {
            searchData.add(element);
          }
        }

        emit(GetCitizenSuccess(allData, searchData,
            isLoading: false, type: type));
      } catch (e) {
        emit(GetCitizenSuccess(allData, searchData,
            isLoading: false, type: type));
      }
    } else if (state is GetCitizenInitial || state is GetCitizenError) {
      getAllCitizen();
    }
  }

  void deleteSearch() {
    var state = this.state;
    if (state is GetCitizenSuccess) {
      emit(GetCitizenSuccess(
        state.allData,
        const [],
        isLoading: false,
      ));
    }
  }

  void updateCitizen(CitizenModel data) {
    var state = this.state;

    if (state is GetCitizenSuccess) {
      List<CitizenModel> allData = state.allData;

      emit(GetCitizenSuccess(state.allData, const [], isLoading: true));
      collection.where("id", isEqualTo: data.id).get().then((value) {
        if (value.docs.isNotEmpty) {
          value.docs.first.reference.set(data).then((value) {
            Fluttertoast.showToast(msg: "User berhasil diedit");
            for (var i = 0; i < allData.length; i++) {
              if (allData[i].id == data.id) {
                allData[i] = data;
              }
            }

            emit(GetCitizenSuccess(allData, const [], isLoading: false));
          }).catchError((error) {
            Fluttertoast.showToast(msg: "User gagal diedit");
          });
        } else {
          Fluttertoast.showToast(msg: "User tidak ditemukan");
        }
      });
    }
  }

  void deleteCitizen(int nik) {
    var state = this.state;

    if (state is GetCitizenSuccess) {
      emit(GetCitizenSuccess(state.allData, const [], isLoading: true));

      collection.where("nik", isEqualTo: nik).get().then((value) {
        if (value.docs.isNotEmpty) {
          value.docs.first.reference.delete().then((value) {
            Fluttertoast.showToast(msg: "User berhasil dihapus");
            final allData = state.allData
              ..removeWhere((element) => element.nik == nik);

            emit(GetCitizenSuccess(allData, const [], isLoading: false));
          }).catchError((error) {
            Fluttertoast.showToast(msg: "User gagal dihapus");
          });
        } else {
          Fluttertoast.showToast(msg: "User tidak ditemukan");
        }
      });
    }
  }
}
