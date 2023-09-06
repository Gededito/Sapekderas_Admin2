// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map json) => NotificationModel(
      id: json['id'] as String? ?? "",
      message: json['message'] as String? ?? "",
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      type: $enumDecodeNullable(_$LetterTypeEnumMap, json['type']) ??
          LetterType.skbm,
      userId: json['user_id'] as String? ?? "",
      userType: json['user_type'] as String? ?? "",
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'createdAt': instance.createdAt?.toIso8601String(),
      'type': _$LetterTypeEnumMap[instance.type]!,
      'user_id': instance.userId,
      'user_type': instance.userType,
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
