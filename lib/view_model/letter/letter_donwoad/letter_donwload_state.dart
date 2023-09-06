part of 'letter_donwload_cubit.dart';

abstract class LetterDonwloadState extends Equatable {
  const LetterDonwloadState();

  @override
  List<Object> get props => [];
}

class LetterDonwloadInitial extends LetterDonwloadState {}

class LetterDonwloadLoading extends LetterDonwloadState {}

class LetterDonwloadSuccess extends LetterDonwloadState {}

class LetterDonwloadError extends LetterDonwloadState {
  final String error;

  const LetterDonwloadError(this.error);

  @override
  List<Object> get props => [error];
}
