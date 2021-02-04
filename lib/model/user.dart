import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:splash/model/link.dart';
import 'package:splash/model/profile_image.dart';
import 'package:splash/social_icons.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String id;
  String username;
  String name;
  String portfolio_url;
  String bio;
  String location;
  int total_likes;
  int total_photos;
  int total_collections;
  String instagram_username;
  String twitter_username;
  ProfileImage profile_image;
  Link links;

  User();

  List<Social> getSocials() {
    List<Social> list = new List<Social>();
    if (twitter_username != null && twitter_username.isNotEmpty) {
      list.add(Social(SocialIcons.twitter, "Twitter", twitter_username, "https://twitter.com/"));
    }
    if (instagram_username != null && instagram_username.isNotEmpty) {
      list.add(Social(SocialIcons.instagram, "Instagram", instagram_username, "https://www.instagram.com/"));
    }
    return list;
  }

  String getBioCompat() {
    if (bio == null) {
      return "";
    }
    return bio;
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

}

class Social {
  IconData icon;
  String name;
  String account;
  String url;

  Social(this.icon, this.name, this.account, this.url);

  String getAccountUrl() {
    return "$url$account";
  }

}
