part of 'add_letter_cubit.dart';

abstract class AddLetterState extends Equatable {
  const AddLetterState();

  @override
  List<Object> get props => [];
}

class AddLetterInitial extends AddLetterState {}

class AddLetterLoading extends AddLetterState {}

class AddLetterError extends AddLetterState {
  final String message;

  const AddLetterError(this.message);

  @override
  List<Object> get props => [message];
}

class AddLetterSuccess extends AddLetterState {}
