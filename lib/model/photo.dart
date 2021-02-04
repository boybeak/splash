import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:splash/model/collection.dart';
import 'package:splash/model/exif.dart';
import 'package:splash/model/link.dart';
import 'package:splash/model/location.dart';
import 'package:splash/model/tag.dart';
import 'package:splash/model/url.dart';
import 'package:splash/model/user.dart';
import 'package:splash/utils/utils.dart';

part 'photo.g.dart';

@JsonSerializable()
class Photo {
  String id;
  DateTime created_at;
  DateTime updated_at;
  int width, height;
  String color;
  String blur_hash;
  int likes;
  bool liked_by_user;
  String description;
  User user;
  List<Collection> current_user_collections;
  Url urls;
  Link links;
  Exif exif;
  Location location;
  List<Tag> tags;

  Photo();

  Color getColor() {
    return str2Color(color);
  }

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

}