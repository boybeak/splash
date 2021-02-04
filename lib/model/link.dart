import 'package:json_annotation/json_annotation.dart';

part 'link.g.dart';

@JsonSerializable()
class Link {
  String self, html, photos, likes, portfolio, download, download_location;
  Link();

  factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);
}