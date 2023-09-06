// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'letter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LetterModel _$LetterModelFromJson(Map json) => LetterModel(
      id: json['id'] as String,
      type: $enumDecode(_$LetterTypeEnumMap, json['type']),
      userId: json['user_id'] as String? ?? "",
      name: json['name'] as String? ?? "",
      nik: json['nik'] as int? ?? 0,
      kk: json['kk'] as int? ?? 0,
      birthPlace: json['birth_place'] as String? ?? "",
      dob: json['dob'] == null ? null : DateTime.parse(json['dob'] as String),
      gender:
          $enumDecodeNullable(_$GenderEnumMap, json['gender']) ?? Gender.male,
      nationality: json['nationality'] as String? ?? "Indonesia",
      religion: json['religion'] as String? ?? "",
      statusMarried: json['status_married'] as String? ?? "",
      job: json['job'] as String? ?? "",
      address: json['address'] as String? ?? "",
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      status: $enumDecodeNullable(_$StatusLetterEnumMap, json['status']) ??
          StatusLetter.progress,
      father: json['father'] == null
          ? null
          : LetterFamily.fromJson(
              Map<String, dynamic>.from(json['father'] as Map)),
      mother: json['mother'] == null
          ? null
          : LetterFamily.fromJson(
              Map<String, dynamic>.from(json['mother'] as Map)),
      activity: json['activity'] == null
          ? null
          : LetterActivity.fromJson(
              Map<String, dynamic>.from(json['activity'] as Map)),
      rip: json['rip'] == null
          ? null
          : LetterRip.fromJson(Map<String, dynamic>.from(json['rip'] as Map)),
      rtrw: json['rtrw'] as String? ?? "",
    );

Map<String, dynamic> _$LetterModelToJson(LetterModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'type': _$LetterTypeEnumMap[instance.type]!,
      'name': instance.name,
      'nik': instance.nik,
      'kk': instance.kk,
      'birth_place': instance.birthPlace,
      'dob': instance.dob?.toIso8601String(),
      'gender': _$GenderEnumMap[instance.gender]!,
      'nationality': instance.nationality,
      'religion': instance.religion,
      'status_married': instance.statusMarried,
      'job': instance.job,
      'address': instance.address,
      'rtrw': instance.rtrw,
      'createdAt': instance.createdAt?.toIso8601String(),
      'status': _$StatusLetterEnumMap[instance.status]!,
      'father': instance.father?.toJson(),
      'mother': instance.mother?.toJson(),
      'activity': instance.activity?.toJson(),
      'rip': instance.rip?.toJson(),
    };

const _$LetterTypeEnumMap = {
  LetterType.sku: 'SKU',
  LetterType.skck: 'SKCK',
  LetterType.sktm: 'SKTM',
  LetterType.skdt: 'SKDT',
  LetterType.skbm: 'SKBM',
  LetterType.sktps: 'SKTPS',
  LetterType.spn: 'SPN',
  LetterType.skrr: 'SKRR',
  LetterType.skk: 'SKK',
  LetterType.skkl: 'SKKL',
};

const _$GenderEnumMap = {
  Gender.male: 'Male',
  Gender.female: 'Female',
};

const _$StatusLetterEnumMap = {
  StatusLetter.progress: 'Progress',
  StatusLetter.success: 'Success',
  StatusLetter.error: 'Error',
  StatusLetter.another: 'another',
};

LetterFamily _$LetterFamilyFromJson(Map json) => LetterFamily(
      name: json['name'] as String? ?? "",
      nik: json['nik'] as int? ?? 0,
      birthPlace: json['birth_place'] as String? ?? "",
      dob: json['dob'] == null ? null : DateTime.parse(json['dob'] as String),
      nationality: json['nationality'] as String? ?? "Indonesia",
      religion: json['religion'] as String? ?? "",
      job: json['job'] as String? ?? "",
      address: json['address'] as String? ?? "",
      rtrw: json['rtrw'] as String? ?? "",
    );

Map<String, dynamic> _$LetterFamilyToJson(LetterFamily instance) =>
    <String, dynamic>{
      'name': instance.name,
      'nik': instance.nik,
      'birth_place': instance.birthPlace,
      'dob': instance.dob?.toIso8601String(),
      'nationality': instance.nationality,
      'religion': instance.religion,
      'job': instance.job,
      'address': instance.address,
      'rtrw': instance.rtrw,
    };

LetterActivity _$LetterActivityFromJson(Map json) => LetterActivity(
      activity: json['activity'] as String? ?? "",
      time:
          json['time'] == null ? null : DateTime.parse(json['time'] as String),
      address: json['address'] as String? ?? "",
      rtrw: json['rtrw'] as String? ?? "",
    );

Map<String, dynamic> _$LetterActivityToJson(LetterActivity instance) =>
    <String, dynamic>{
      'activity': instance.activity,
      'time': instance.time?.toIso8601String(),
      'address': instance.address,
      'rtrw': instance.rtrw,
    };

LetterRip _$LetterRipFromJson(Map json) => LetterRip(
      name: json['name'] as String? ?? "",
      age: json['age'] as int? ?? 0,
      address: json['address'] as String? ?? "",
      deathTime: json['deathTime'] == null
          ? null
          : DateTime.parse(json['deathTime'] as String),
      location: json['location'] as String? ?? "",
      reason: json['reason'] as String? ?? "",
      rtrw: json['rtrw'] as String? ?? "",
    );

Map<String, dynamic> _$LetterRipToJson(LetterRip instance) => <String, dynamic>{
      'name': instance.name,
      'age': instance.age,
      'address': instance.address,
      'deathTime': instance.deathTime?.toIso8601String(),
      'location': instance.location,
      'reason': instance.reason,
      'rtrw': instance.rtrw,
    };
