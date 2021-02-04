import 'dart:convert';
import 'dart:io';

import 'package:splash/model/photo.dart';
import 'package:splash/model/collection.dart';
import 'package:http/http.dart' as http;

class Api {

  static const headers = {
    HttpHeaders.authorizationHeader: "Client-ID 2UmADJIJPl0KKahuQBH4CsFI4i4DK6s3taPeFi1i1tA"
  };

  static Future<List<Photo>> getPhotos(int page, int per_page) async {
    final response = await http.get(
      "https://api.unsplash.com/photos?page=$page&per_page=$per_page",
      headers: headers
    );
    if (response.statusCode == 200) {
      List ja = jsonDecode(response.body);
      List<Photo> photos = ja.map((e) => Photo.fromJson(e)).toList();
      print("get photos success ${photos.length}");
      return photos;
    } else {
      print("get photos failed " + response.toString());
      throw Exception('Failed to load photo {' + response.body + '}\n');
    }
  }

  static Future<Photo> getPhotoDetail(String id) async {
    print("getPhotoDetail id=$id");
    final response = await http.get(
      "https://api.unsplash.com/photos/$id",
      headers: headers
    );
    if (response.statusCode == 200) {
      return Photo.fromJson(jsonDecode(response.body));
    } else {
      print("get photo detail failed ");
      throw Exception('Failed to load photo {' + response.body + '}\n');
    }
  }

  static Future<List<Collection>> getCollections(int page, int per_page) async {
    final response = await http.get(
        "https://api.unsplash.com/collections?page=$page&per_page=$per_page",
        headers: headers
    );
    if (response.statusCode == 200) {
      List ja = jsonDecode(response.body);
      List<Collection> collections = ja.map((e) => Collection.fromJson(e)).toList();
      return collections;
    } else {
      print("get photos failed " + response.toString());
      throw Exception('Failed to load photo {' + response.body + '}\n');
    }
  }


}