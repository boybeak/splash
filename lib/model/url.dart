import 'package:json_annotation/json_annotation.dart';

part 'url.g.dart';

@JsonSerializable()
class Url {
  String raw, full, regular, small, thumb;
  Url({this.raw, this.full, this.regular, this.small, this.thumb});

  factory Url.fromJson(Map<String, dynamic> json) => _$UrlFromJson(json);
  Map<String, dynamic> toJson() => _$UrlToJson(this);

  /*factory Url.fromJson(Map<String, dynamic> json) {
    return Url(
      raw: json['raw'],
      full: json['full'],
      regular: json['regular'],
      small: json['small'],
      thumb: json['thumb']
    );
  }*/
}