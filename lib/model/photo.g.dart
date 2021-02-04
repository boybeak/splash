// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Photo _$PhotoFromJson(Map<String, dynamic> json) {
  return Photo()
    ..id = json['id'] as String
    ..created_at = json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String)
    ..updated_at = json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String)
    ..width = json['width'] as int
    ..height = json['height'] as int
    ..color = json['color'] as String
    ..blur_hash = json['blur_hash'] as String
    ..likes = json['likes'] as int
    ..liked_by_user = json['liked_by_user'] as bool
    ..description = json['description'] as String
    ..user = json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>)
    ..current_user_collections = (json['current_user_collections'] as List)
        ?.map((e) =>
            e == null ? null : Collection.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..urls = json['urls'] == null
        ? null
        : Url.fromJson(json['urls'] as Map<String, dynamic>)
    ..links = json['links'] == null
        ? null
        : Link.fromJson(json['links'] as Map<String, dynamic>)
    ..exif = json['exif'] == null
        ? null
        : Exif.fromJson(json['exif'] as Map<String, dynamic>)
    ..location = json['location'] == null
        ? null
        : Location.fromJson(json['location'] as Map<String, dynamic>)
    ..tags = (json['tags'] as List)
        ?.map((e) => e == null ? null : Tag.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$PhotoToJson(Photo instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
      'width': instance.width,
      'height': instance.height,
      'color': instance.color,
      'blur_hash': instance.blur_hash,
      'likes': instance.likes,
      'liked_by_user': instance.liked_by_user,
      'description': instance.description,
      'user': instance.user,
      'current_user_collections': instance.current_user_collections,
      'urls': instance.urls,
      'links': instance.links,
      'exif': instance.exif,
      'location': instance.location,
      'tags': instance.tags,
    };
