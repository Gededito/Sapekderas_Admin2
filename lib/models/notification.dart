import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'letter_model.dart';

part 'notification.g.dart';

@JsonSerializable()
class NotificationModel extends Equatable {
  final String id;
  final String message;
  final DateTime? createdAt;
  final LetterType type;
  @JsonKey(name: "user_id")
  final String userId;
  @JsonKey(name: "user_type")
  final String userType;

  const NotificationModel({
    this.id = "",
    this.message = "",
    this.createdAt,
    this.type = LetterType.skbm,
    this.userId = "",
    this.userType = "",
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  @override
  List<Object?> get props => [message, createdAt, type, userId, userType, id];
}
