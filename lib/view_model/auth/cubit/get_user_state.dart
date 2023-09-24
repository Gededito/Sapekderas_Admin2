part of 'get_user_cubit.dart';

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
  final int increment;

  const GetUserSuccess({
    this.isLoading = false,
    required this.allData,
    this.increment = 0,
  });

  @override
  List<Object> get props => [
        isLoading,
        allData,
        increment,
      ];
}

class GetUserError extends GetUserState {
  final String message;
  const GetUserError(this.message);
  @override
  List<Object> get props => [message];
}
