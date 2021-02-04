// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Collection _$CollectionFromJson(Map<String, dynamic> json) {
  return Collection()
    ..id = json['id'] as String
    ..title = json['title'] as String
    ..published_at = json['published_at'] == null
        ? null
        : DateTime.parse(json['published_at'] as String)
    ..last_collected_at = json['last_collected_at'] == null
        ? null
        : DateTime.parse(json['last_collected_at'] as String)
    ..updated_at = json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String)
    ..cover_photo = json['cover_photo'] == null
        ? null
        : Photo.fromJson(json['cover_photo'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CollectionToJson(Collection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'published_at': instance.published_at?.toIso8601String(),
      'last_collected_at': instance.last_collected_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
      'cover_photo': instance.cover_photo,
    };
