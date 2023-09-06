// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_citizen_cubit.dart';

abstract class GetCitizenState extends Equatable {
  const GetCitizenState();

  @override
  List<Object?> get props => [];
}

class GetCitizenInitial extends GetCitizenState {}

class GetCitizenLoading extends GetCitizenState {}

class GetCitizenSuccess extends GetCitizenState {
  final bool isLoading;
  final List<CitizenModel> allData;
  final List<CitizenModel> searchData;
  final SearchType? type;

  const GetCitizenSuccess(this.allData, this.searchData,
      {this.isLoading = false, this.type});

  @override
  List<Object?> get props => [allData, searchData, isLoading, type];

  GetCitizenSuccess copyWith({
    List<CitizenModel>? allData,
    List<CitizenModel>? searchData,
    bool? isLoading,
    SearchType? type,
  }) {
    return GetCitizenSuccess(
      allData ?? this.allData,
      searchData ?? this.searchData,
      isLoading: isLoading ?? this.isLoading,
      type: type ?? this.type,
    );
  }
}

class GetCitizenError extends GetCitizenState {
  final String message;

  const GetCitizenError(this.message);
  @override
  List<Object> get props => [message];
}
