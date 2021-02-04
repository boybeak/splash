// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Link _$LinkFromJson(Map<String, dynamic> json) {
  return Link()
    ..self = json['self'] as String
    ..html = json['html'] as String
    ..photos = json['photos'] as String
    ..likes = json['likes'] as String
    ..portfolio = json['portfolio'] as String
    ..download = json['download'] as String
    ..download_location = json['download_location'] as String;
}

Map<String, dynamic> _$LinkToJson(Link instance) => <String, dynamic>{
      'self': instance.self,
      'html': instance.html,
      'photos': instance.photos,
      'likes': instance.likes,
      'portfolio': instance.portfolio,
      'download': instance.download,
      'download_location': instance.download_location,
    };
