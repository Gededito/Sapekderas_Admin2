import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class UserModel extends Equatable {
  @HiveField(0)
  final String email;

  @HiveField(1)
  final String password;

  @HiveField(2)
  final String id;

  @HiveField(3)
  final String name;

  @HiveField(4)
  final String phone;

  @HiveField(5, defaultValue: "")
  final String nik;

  @HiveField(6, defaultValue: false)
  @JsonKey(defaultValue: false)
  final bool isVerified;

  @HiveField(7, defaultValue: "")
  final String type;

  UserModel({
    required this.email,
    required this.password,
    required this.id,
    this.nik = "",
    this.type = "",
    this.name = "",
    this.phone = "",
    this.isVerified = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserModel copyWith({
    String? email,
    String? password,
    String? id,
    String? name,
    bool? isVerified,
    String? type,
    String? nik,
    String? phone,
  }) =>
      UserModel(
        email: email ?? this.email,
        password: password ?? this.password,
        id: id ?? this.id,
        name: name ?? this.name,
        isVerified: isVerified ?? this.isVerified,
        phone: phone ?? this.phone,
        nik: nik ?? this.nik,
        type: type ?? this.type,
      );

  @override
  List<Object?> get props => [email, password, id, name, isVerified];
}
