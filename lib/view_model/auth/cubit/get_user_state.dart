import 'package:equatable/equatable.dart';
import 'package:sapekderas/models/user_model.dart';

abstract class GetUserState extends Equatable {
  const GetUserState();

  @override
  List<Object> get props => [];
}

class GetUserInitial extends GetUserState {}

class GetUserLoading extends GetUserState {}

class GetUserSuccess extends GetUserState {
  final bool isLoading;
  final List<UserModel> allData;
  final List<UserModel> successData;
  final List<UserModel> errorData;
  final List<UserModel> progressData;

  const GetUserSuccess({
    this.isLoading = false,
    required this.allData,
    required this.successData,
    required this.errorData,
    required this.progressData,
  });

  @override
  List<Object> get props =>
      [isLoading, allData, successData, errorData, progressData];

  GetUserSuccess copyWith({
    bool? isLoading,
    List<UserModel>? allData,
    List<UserModel>? successData,
    List<UserModel>? errorData,
    List<UserModel>? progressData
  }) {
    return GetUserSuccess(
      isLoading: isLoading ?? this.isLoading,
      allData: allData ?? this.allData,
      successData: successData ?? this.successData,
      errorData: errorData ?? this.errorData,
      progressData: progressData ?? this.progressData,
    );
  }
}

class GetUserError extends GetUserState {
  final String message;
  const GetUserError(this.message);
  @override
  List<Object> get props => [message];
}