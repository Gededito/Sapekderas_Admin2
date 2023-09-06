import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../models/letter_model.dart';
import '../../../utils/utils.dart';
import '../../../views/home/widgets/widgets.dart';

part 'get_letter_state.dart';

class GetLetterCubit extends Cubit<GetLetterState> {
  final collection = FirebaseFirestore.instance
      .collection('letters')
      .withConverter<LetterModel>(
        fromFirestore: (snapshots, _) =>
            LetterModel.fromJson(snapshots.data()!),
        toFirestore: (letter, _) => letter.toJson(),
      );
  GetLetterCubit() : super(GetLetterInitial());

  void getAllData() async {
    emit(GetLetterLoading());
    List<LetterModel> allData = [];
    List<LetterModel> successData = [];
    List<LetterModel> errorData = [];
    List<LetterModel> progressData = [];
    List<ChartData> pieList = [];

    try {
      final querySnapshot = await collection.get();

      for (var element in querySnapshot.docs) {
        allData.add(element.data());
        switch (element.data().status) {
          case StatusLetter.success:
            successData.add(element.data());
            break;
          case StatusLetter.progress:
            progressData.add(element.data());
            break;
          case StatusLetter.error:
            errorData.add(element.data());
            break;
          default:
        }

        bool addToPie = true;
        for (var i = 0; i < pieList.length; i++) {
          if (pieList[i].index == element.data().type.index) {
            pieList[i] = ChartData(
              x: pieList[i].x,
              y: pieList[i].y + 1,
              color: ColorsUtils.colorPie[element.data().type.index],
              index: element.data().type.index,
            );
            addToPie = false;
          }
        }
        if (addToPie) {
          pieList.add(ChartData(
            x: element.data().type.name.toString().toUpperCase(),
            y: 1,
            color: ColorsUtils.colorPie[element.data().type.index],
            index: element.data().type.index,
          ));
        }
      }
      pieList.sort((a, b) => a.index.compareTo(b.index));
      allData.sort((a, b) => b.createdAt!.millisecondsSinceEpoch
          .compareTo(a.createdAt!.millisecondsSinceEpoch));
      progressData.sort((a, b) => b.createdAt!.millisecondsSinceEpoch
          .compareTo(a.createdAt!.millisecondsSinceEpoch));
      emit(GetLetterSuccess(
        allData: allData,
        successData: successData,
        errorData: errorData,
        progressData: progressData,
        pieList: pieList,
      ));
    } catch (e) {
      emit(GetLetterError(e.toString()));
    }
  }

  void deleteData(LetterModel data) {
    var state = this.state;
    if (state is GetLetterSuccess) {
      List<LetterModel> allData = state.allData;
      List<LetterModel> successData = [];
      List<LetterModel> errorData = [];
      List<LetterModel> progressData = [];
      emit(GetLetterSuccess(
        allData: allData,
        successData: state.successData,
        errorData: state.errorData,
        progressData: state.progressData,
        isLoading: true,
        pieList: state.pieList,
      ));

      collection.where("id", isEqualTo: data.id).get().then((value) {
        if (value.docs.isNotEmpty) {
          value.docs.first.reference.delete().then((value) {
            Fluttertoast.showToast(msg: "Surat berhasil dihapus");
            final allData = state.allData
              ..removeWhere((element) => element.id == data.id);

            for (var element in allData) {
              switch (element.status) {
                case StatusLetter.success:
                  successData.add(element);
                  break;
                case StatusLetter.progress:
                  progressData.add(element);
                  break;
                case StatusLetter.error:
                  errorData.add(element);
                  break;
                default:
              }
            }

            emit(GetLetterSuccess(
              allData: allData,
              successData: successData,
              errorData: errorData,
              progressData: progressData,
              pieList: state.pieList,
            ));
          }).catchError((error) {
            Fluttertoast.showToast(msg: "Surat gagal dihapus");
          });
        } else {
          Fluttertoast.showToast(msg: "Surat tidak ditemukan");
        }
      });
    }
  }
}
