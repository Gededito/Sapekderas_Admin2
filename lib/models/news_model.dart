import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news_model.g.dart';

@JsonSerializable()
class NewsModel extends Equatable {
  final String id;
  final String image;
  final String title;
  final String content;
  @JsonKey(name: "created_at")
  final DateTime createdAt;
  final String author;

  const NewsModel({
    required this.id,
    this.image = '',
    this.title = '',
    this.content = '',
    required this.createdAt,
    this.author = '',
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) =>
      _$NewsModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsModelToJson(this);
  @override
  List<Object?> get props => [image, title, content, createdAt, author];
}
