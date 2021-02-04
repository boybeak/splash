import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:splash/model/photo.dart';
import 'package:splash/utils/utils.dart';
import 'package:splash/widget/user_bar.dart';

import '../api.dart';

class PhotoCard extends StatefulWidget {

  final Photo photo;

  const PhotoCard({Key key, @required this.photo}): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _PhotoCardState();
  }

}

class _PhotoCardState extends State<PhotoCard> {

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    final double size = min(screen.width, screen.height);

    final photoBgColor = widget.photo.getColor();
    final photoFgColor = Color.fromARGB(0xFF, 0xFF - photoBgColor.red,
        0xFF - photoBgColor.green, 0xFF - photoBgColor.blue);

    return Container(
      child: Stack(
        alignment:Alignment.bottomLeft , //指定未定位或部分定位widget的对齐方式
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(
              color: photoBgColor
            ),
            position: DecorationPosition.background,
            child: Image.network(
              widget.photo.urls.regular,
              width: size,
              height: size,
              fit: BoxFit.cover,
              headers: Api.headers
            ),
          ),
          Positioned(
            left: 16,
            bottom: 16,
            child: UserBar(widget.photo.user, primaryColor: photoFgColor,)
          ),
        ],
      ),
    );
  }

}