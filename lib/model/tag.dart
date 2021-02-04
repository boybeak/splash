import 'package:json_annotation/json_annotation.dart';

part 'tag.g.dart';

@JsonSerializable()
class Tag {
  String title;

  Tag({this.title});

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);

}