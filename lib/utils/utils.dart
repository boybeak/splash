import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

Color str2Color(String colorStr) {
  return new Color(int.parse(colorStr.substring(1, 7), radix: 16) + 0xFF000000);
}

Future<Directory> getRootDirectory(BuildContext context) async {
  final platform = Theme.of(context).platform;
  final baseDir = platform == TargetPlatform.android ? await getExternalStorageDirectory() : await getApplicationDocumentsDirectory();
  return baseDir;
}

Future<Directory> getSubDirectory(BuildContext context, List<String> dirs) async {
  final root = await getRootDirectory(context);
  if (dirs == null || dirs.isEmpty) {
    return root;
  }
  String dir = "";
  dirs.forEach((element) {
    dir += "/$element";
  });
  final directory = new Directory(root.path + dir);
  if (await directory.exists()) {
    await directory.create(recursive: true);
  }
  directory.createSync();
  print("path=${directory.path} exist=${directory.existsSync()}");
  return directory;
}

Future<File> getFile(BuildContext context, String fileName, {List<String> dirs}) async {
  Directory dir = await getSubDirectory(context, dirs);
  return File(dir.path + "/" + fileName);
}

Future<File> getDownloadFile(BuildContext context, String fileName) async {
  return getFile(context, fileName, dirs: ["download"]);
}

Future<Directory> getImageDir(BuildContext context) async {
  return getSubDirectory(context, ['image']);
}
Future<File> getImageFile(BuildContext context, String fileName) async {
  return getFile(context, fileName, dirs: ["image"]);
}