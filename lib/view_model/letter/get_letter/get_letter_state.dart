// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_letter_cubit.dart';

abstract class GetLetterState extends Equatable {
  const GetLetterState();

  @override
  List<Object> get props => [];
}

class GetLetterInitial extends GetLetterState {}

class GetLetterLoading extends GetLetterState {}

class GetLetterSuccess extends GetLetterState {
  final bool isLoading;
  final List<LetterModel> allData;
  final List<LetterModel> successData;
  final List<LetterModel> errorData;
  final List<LetterModel> progressData;
  final List<ChartData> pieList;

  const GetLetterSuccess({
    this.isLoading = false,
    required this.allData,
    required this.successData,
    required this.errorData,
    required this.progressData,
    required this.pieList,
  });

  @override
  List<Object> get props =>
      [isLoading, allData, successData, errorData, progressData];

  GetLetterSuccess copyWith({
    bool? isLoading,
    List<LetterModel>? allData,
    List<LetterModel>? successData,
    List<LetterModel>? errorData,
    List<LetterModel>? progressData,
    List<ChartData>? pieList,
  }) {
    return GetLetterSuccess(
      isLoading: isLoading ?? this.isLoading,
      allData: allData ?? this.allData,
      successData: successData ?? this.successData,
      errorData: errorData ?? this.errorData,
      progressData: progressData ?? this.progressData,
      pieList: pieList ?? this.pieList,
    );
  }
}

class GetLetterError extends GetLetterState {
  final String message;
  const GetLetterError(this.message);
  @override
  List<Object> get props => [message];
}
