import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {
  String city;
  String country;
  Position position;

  Location();

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);

  bool isEmpty() {
    return city == null && country == null && (position == null || !position.isValid());
  }

}

@JsonSerializable()
class Position {
  double latitude, longitude;

  Position();

  factory Position.fromJson(Map<String, dynamic> json) => _$PositionFromJson(json);
  Map<String, dynamic> toJson() => _$PositionToJson(this);

  bool isValid() {
    return latitude != null && longitude != null;
  }

  @override
  String toString() {
    if (!isValid()) {
      return "(null, null)";
    }
    return "(${latitude.abs()}${latitude >= 0 ? 'N' : 'S'}, ${longitude.abs()}${longitude >= 0 ? 'E' : 'W'})";
  }

}