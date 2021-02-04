import 'package:json_annotation/json_annotation.dart';

part 'exif.g.dart';

@JsonSerializable()
class Exif {
  String make, model, exposure_time, aperture, focal_length;
  int iso;


  Exif();

  factory Exif.fromJson(Map<String, dynamic> json) => _$ExifFromJson(json);
}