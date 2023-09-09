// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'letter_model.g.dart';

@JsonSerializable()
class LetterModel extends Equatable {
  final String id;
  @JsonKey(name: 'user_id')
  final String userId;
  final LetterType type;
  final String name;
  final int nik;
  final int kk;
  @JsonKey(name: 'birth_place')
  final String birthPlace;
  final DateTime? dob;
  final Gender gender;
  final String nationality;
  final String religion;

  @JsonKey(name: 'status_married')
  final String statusMarried;
  final String job;
  final String address;
  final String informations;
  final String rtrw;
  final DateTime? createdAt;
  final StatusLetter status;

  @JsonKey(includeToJson: true)
  final LetterFamily? father;

  @JsonKey(includeToJson: true)
  final LetterFamily? mother;
  @JsonKey(includeToJson: true)
  final LetterActivity? activity;

  final LetterRip? rip;

  const LetterModel({
    required this.id,
    required this.type,
    this.userId = "",
    this.name = "",
    this.nik = 0,
    this.kk = 0,
    this.birthPlace = "",
    this.dob,
    this.gender = Gender.male,
    this.nationality = "Indonesia",
    this.religion = "",
    this.statusMarried = "",
    this.job = "",
    this.address = "",
    this.informations = "",
    this.createdAt,
    this.status = StatusLetter.progress,
    this.father,
    this.mother,
    this.activity,
    this.rip,
    this.rtrw = "",
  });

  factory LetterModel.fromJson(Map<String, dynamic> json) =>
      _$LetterModelFromJson(json);

  Map<String, dynamic> toJson() => _$LetterModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        type,
        name,
        nik,
        birthPlace,
        dob,
        gender,
        nationality,
        religion,
        statusMarried,
        job,
        address,
        informations,
        createdAt,
        status,
        userId,
        father,
        mother,
        activity,
        rip,
        rtrw,
      ];

  LetterModel copyWith({
    String? id,
    String? userId,
    LetterType? type,
    String? name,
    int? nik,
    int? kk,
    String? birthPlace,
    DateTime? dob,
    Gender? gender,
    String? nationality,
    String? religion,
    String? statusMarried,
    String? job,
    String? address,
    String? informations,
    DateTime? createdAt,
    StatusLetter? status,
    LetterFamily? father,
    LetterFamily? mother,
    LetterActivity? activity,
    LetterRip? rip,
    String? rtrw,
  }) {
    return LetterModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      name: name ?? this.name,
      nik: nik ?? this.nik,
      kk: kk ?? this.kk,
      birthPlace: birthPlace ?? this.birthPlace,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      nationality: nationality ?? this.nationality,
      religion: religion ?? this.religion,
      statusMarried: statusMarried ?? this.statusMarried,
      job: job ?? this.job,
      address: address ?? this.address,
      informations: informations ?? this.informations,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      mother: mother ?? this.mother,
      father: father ?? this.father,
      activity: activity ?? this.activity,
      rip: rip ?? this.rip,
      rtrw: rtrw ?? this.rtrw,
    );
  }
}

@JsonSerializable(explicitToJson: true)
class LetterFamily extends Equatable {
  final String name;
  final int nik;
  @JsonKey(name: 'birth_place')
  final String birthPlace;
  final DateTime? dob;
  final String nationality;
  final String religion;
  final String job;
  final String address;
  final String informations;
  final String rtrw;

  const LetterFamily({
    this.name = "",
    this.nik = 0,
    this.birthPlace = "",
    this.dob,
    this.nationality = "Indonesia",
    this.religion = "",
    this.job = "",
    this.address = "",
    this.informations = "",
    this.rtrw = "",
  });

  factory LetterFamily.fromJson(Map<String, dynamic> json) =>
      _$LetterFamilyFromJson(json);

  Map<String, dynamic> toJson() => _$LetterFamilyToJson(this);

  @override
  List<Object?> get props =>
      [name, nik, birthPlace, dob, nationality, religion, job, address, informations];

  LetterFamily copyWith({
    String? name,
    int? nik,
    String? birthPlace,
    DateTime? dob,
    String? nationality,
    String? religion,
    String? job,
    String? address,
    String? informations,
    String? rtrw,
  }) {
    return LetterFamily(
      name: name ?? this.name,
      nik: nik ?? this.nik,
      birthPlace: birthPlace ?? this.birthPlace,
      dob: dob ?? this.dob,
      nationality: nationality ?? this.nationality,
      religion: religion ?? this.religion,
      job: job ?? this.job,
      address: address ?? this.address,
      informations: informations ?? this.informations,
      rtrw: rtrw ?? this.rtrw,
    );
  }
}

@JsonSerializable(explicitToJson: true)
class LetterActivity extends Equatable {
  final String activity;
  final DateTime? time;
  final String address;
  final String informations;
  final String rtrw;

  const LetterActivity({
    this.activity = "",
    this.time,
    this.address = "",
    this.informations = "",
    this.rtrw = "",
  });

  factory LetterActivity.fromJson(Map<String, dynamic> json) =>
      _$LetterActivityFromJson(json);

  Map<String, dynamic> toJson() => _$LetterActivityToJson(this);

  @override
  List<Object?> get props => [activity, time, address, informations];
}

@JsonSerializable(explicitToJson: true)
class LetterRip extends Equatable {
  final String name;
  final int age;
  final String address;
  final String info;
  final DateTime? deathTime;
  final String location;
  final String reason;
  final String rtrw;

  const LetterRip({
    this.name = "",
    this.age = 0,
    this.address = "",
    this.info = "",
    this.deathTime,
    this.location = "",
    this.reason = "",
    this.rtrw = "",
  });

  factory LetterRip.fromJson(Map<String, dynamic> json) =>
      _$LetterRipFromJson(json);

  Map<String, dynamic> toJson() => _$LetterRipToJson(this);

  @override
  List<Object?> get props => [name, age, address, info, deathTime, location, reason];
}

enum StatusLetter {
  @JsonValue("Progress")
  progress,
  @JsonValue("Success")
  success,
  @JsonValue("Error")
  error,
  @JsonValue("another")
  another,
}

enum Gender {
  @JsonValue("Male")
  male,
  @JsonValue("Female")
  female
}

enum LetterType {
  /// Surat keterangan umum
  @JsonValue("SKU")
  sku,
  @JsonValue("SKCK")
  skck,
  @JsonValue("SKTM")
  sktm,

  /// Surat keterangan domisili tinggal
  @JsonValue("SKDT")
  skdt,

  /// Surat Keterangan belum menikah
  @JsonValue("SKBM")
  skbm,

  /// Surat KTP Sementara
  @JsonValue("SKTPS")
  sktps,

  /// Surat Pengantar Nikah
  @JsonValue("SPN")
  spn,

  /// Surat Keterangan Rame - Rame
  @JsonValue("SKRR")
  skrr,

  /// Surat Keterangan Kematian
  @JsonValue("SKK")
  skk,

  /// Surat Keterangan Kenal Lahir
  @JsonValue("SKKL")
  skkl,

  // @JsonValue("Other")
  // other,
}
