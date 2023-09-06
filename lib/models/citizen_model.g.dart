// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'citizen_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CitizenModel _$CitizenModelFromJson(Map json) => CitizenModel(
      id: json['id'] as String? ?? "",
      kk: json['kk'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      nik: json['nik'] as int? ?? 0,
      gender: json['gender'] as String? ?? "",
      birthPlace: json['birth_place'] as String? ?? "",
      dob: DateTime.parse(json['dob'] as String),
      religion: json['religion'] as String? ?? "",
      job: json['job'] as String? ?? "",
      rtrw: json['rtrw'] as String? ?? "",
      address: json['address'] as String? ?? "",
      statusMarried: json['status_married'] as String? ?? "",
    );

Map<String, dynamic> _$CitizenModelToJson(CitizenModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'kk': instance.kk,
      'name': instance.name,
      'nik': instance.nik,
      'gender': instance.gender,
      'birth_place': instance.birthPlace,
      'dob': instance.dob.toIso8601String(),
      'religion': instance.religion,
      'job': instance.job,
      'rtrw': instance.rtrw,
      'address': instance.address,
      'status_married': instance.statusMarried,
    };
