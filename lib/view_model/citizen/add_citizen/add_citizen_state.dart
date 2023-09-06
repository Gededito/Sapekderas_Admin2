part of 'add_citizen_cubit.dart';

abstract class AddCitizenState extends Equatable {
  const AddCitizenState();

  @override
  List<Object> get props => [];
}

class AddCitizenInitial extends AddCitizenState {}

class AddCitizenLoading extends AddCitizenState {}

class AddCitizenSuccess extends AddCitizenState {}

class AddCitizenError extends AddCitizenState {
  final String message;

  const AddCitizenError(this.message);
  @override
  List<Object> get props => [message];
}
