// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..id = json['id'] as String
    ..username = json['username'] as String
    ..name = json['name'] as String
    ..portfolio_url = json['portfolio_url'] as String
    ..bio = json['bio'] as String
    ..location = json['location'] as String
    ..total_likes = json['total_likes'] as int
    ..total_photos = json['total_photos'] as int
    ..total_collections = json['total_collections'] as int
    ..instagram_username = json['instagram_username'] as String
    ..twitter_username = json['twitter_username'] as String
    ..profile_image = json['profile_image'] == null
        ? null
        : ProfileImage.fromJson(json['profile_image'] as Map<String, dynamic>)
    ..links = json['links'] == null
        ? null
        : Link.fromJson(json['links'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'name': instance.name,
      'portfolio_url': instance.portfolio_url,
      'bio': instance.bio,
      'location': instance.location,
      'total_likes': instance.total_likes,
      'total_photos': instance.total_photos,
      'total_collections': instance.total_collections,
      'instagram_username': instance.instagram_username,
      'twitter_username': instance.twitter_username,
      'profile_image': instance.profile_image,
      'links': instance.links,
    };
