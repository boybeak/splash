import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:splash/model/photo.dart';
import 'package:splash/model/tag.dart';
import 'package:splash/utils/utils.dart';
import 'package:splash/widget/photo_card.dart';
import 'package:splash/widget/photo_info.dart';
import 'package:splash/widget/tag_button.dart';
import 'package:splash/widget/user_bar.dart';

import '../api.dart';

class DetailPage extends StatefulWidget {

  Photo photo;

  DetailPage({Key key, @required this.photo}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DetailPageState();
  }
}

class _DetailPageState extends State<DetailPage> {
  List<Tag> tags = new List();
  Photo photoDetail;

  @override
  void initState() {
    Api.getPhotoDetail(widget.photo.id).then((value) {
      if (value.tags != null && value.tags.isNotEmpty) {
        print("tags=${value.tags}");
        setState(() {
          photoDetail = value;
          tags = value.tags;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: UserBar(
          widget.photo.user,
          avatarSize: Size(36, 36),
        ),
        backgroundColor: Colors.transparent,
        leading: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.info_outline,
                color: Colors.white,
              ),
              onPressed: () {
                showPhotoInfo();
              }),
          IconButton(
              icon: Icon(
                Icons.cloud_download_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                Permission.storage.request().then((value) {
                  if (value.isGranted) {
                    downloadPhoto();
                  }
                });
              }),
          IconButton(
              icon: Icon(
                Icons.wallpaper_outlined,
                color: Colors.white,
              ),
              onPressed: () {}),
        ],
        elevation: 0,
        titleSpacing: -8,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Image.network(
              widget.photo.urls.raw,
              fit: BoxFit.fitHeight,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent loadingProgress) {
                if (loadingProgress == null) {
                  print("loadingProgress == null child=$child");
                  return Stack(
                    children: [
                      child,
                      BackdropFilter(
                        child: Container(
                          child: Image.network(
                            widget.photo.urls.regular,
                            fit: BoxFit.fitHeight,
                            headers: Api.headers,
                          ),
                          color: Colors.black.withOpacity(0.3),
                        ),
                        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                      )
                    ],
                  );
                } else {
                  final Size size = MediaQuery.of(context).size;
                  return Container(
                    width: size.width,
                    height: size.height,
                    // alignment: Alignment.center,
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Visibility(
                          child: BackdropFilter(
                            child: Container(
                              width: size.width,
                              height: size.height,
                              child: Image.network(
                                widget.photo.urls.regular,
                                fit: BoxFit.fitHeight,
                                headers: Api.headers,
                              ),
                              color: Colors.black.withOpacity(0.3),
                            ),
                            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                          ),
                          visible: loadingProgress.cumulativeBytesLoaded !=
                              loadingProgress.expectedTotalBytes,
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        )
                      ],
                    ),
                  );
                }
              },
            ),
          ),
          Positioned(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Wrap(
                spacing: 8,
                runSpacing: 4,
                children: tags.map((e) => TagButton(e)).toList(),
              ),
            ),
            left: 16,
            right: 16,
            bottom: 16,
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
    );
  }

  void showPhotoInfo() {
    if (photoDetail == null) {
      return;
    }
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return PhotoInfoCard(photoDetail);
        });
  }

  Future<void> downloadPhoto() async {
    getImageDir(context).then((value) {
      FlutterDownloader.enqueue(
        url: widget.photo.urls.raw,
        savedDir: value.path,
        showNotification:
        true, // show download progress in status bar (for Android)
        openFileFromNotification: true,
        headers: Api.headers
      ).then((value) {
        print("downloadPhoto ${value.length}");
      }).catchError((error) {
        print("downloadPhoto $error");
      }).whenComplete(() {
        print("downloadPhoto whenComplete");
      });
      FlutterDownloader.registerCallback((id, status, progress) {
        print("$id - $status - $progress");
      });
    });
  }

}
