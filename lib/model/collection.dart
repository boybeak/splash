
import 'package:json_annotation/json_annotation.dart';
import 'package:splash/model/photo.dart';

part 'collection.g.dart';

@JsonSerializable()
class Collection {
  String id;
  String title;
  DateTime published_at, last_collected_at, updated_at;
  Photo cover_photo;

  Collection();

  factory Collection.fromJson(Map<String, dynamic> json) => _$CollectionFromJson(json);
}