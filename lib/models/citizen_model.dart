// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'citizen_model.g.dart';

@JsonSerializable()
class CitizenModel extends Equatable {
  final String id;
  final int kk;
  final String name;
  final int nik;
  final String gender;

  @JsonKey(name: 'birth_place')
  final String birthPlace;
  final DateTime dob;
  final String religion;
  final String job;
  final String rtrw;
  final String address;
  final String informations;

  @JsonKey(name: 'status_married')
  final String statusMarried;

  const CitizenModel({
    this.id = "",
    this.kk = 0,
    this.name = "",
    this.nik = 0,
    this.gender = "",
    this.birthPlace = "",
    required this.dob,
    this.religion = "",
    this.job = "",
    this.rtrw = "",
    this.address = "",
    this.informations = "",
    this.statusMarried = "",
  });

  factory CitizenModel.fromJson(Map<String, dynamic> json) =>
      _$CitizenModelFromJson(json);

  Map<String, dynamic> toJson() => _$CitizenModelToJson(this);

  @override
  List<Object> get props {
    return [
      id,
      kk,
      name,
      nik,
      gender,
      birthPlace,
      dob,
      religion,
      job,
      rtrw,
      address,
      informations,
      statusMarried
    ];
  }

  CitizenModel copyWith({
    String? id,
    int? kk,
    String? name,
    int? nik,
    String? gender,
    String? birthPlace,
    DateTime? dob,
    String? religion,
    String? job,
    String? rtrw,
    String? address,
    String? informations,
    String? statusMarried,
  }) {
    return CitizenModel(
      id: id ?? this.id,
      kk: kk ?? this.kk,
      name: name ?? this.name,
      nik: nik ?? this.nik,
      gender: gender ?? this.gender,
      birthPlace: birthPlace ?? this.birthPlace,
      dob: dob ?? this.dob,
      religion: religion ?? this.religion,
      job: job ?? this.job,
      rtrw: rtrw ?? this.rtrw,
      address: address ?? this.address,
      informations: informations ?? this.informations,
      statusMarried: statusMarried ?? this.statusMarried,
    );
  }
}
