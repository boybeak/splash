
import 'package:json_annotation/json_annotation.dart';

part 'profile_image.g.dart';

@JsonSerializable()
class ProfileImage {
  String small, medium, large;

  ProfileImage();

  factory ProfileImage.fromJson(Map<String, dynamic> json) => _$ProfileImageFromJson(json);

}