import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splash/api.dart';
import 'package:splash/model/photo.dart';
import 'package:splash/model/tag.dart';
import 'package:splash/theme.dart';
import 'package:splash/widget/tag_button.dart';

class HelloPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HelloState();
  }
}

class _HelloState extends State<HelloPage> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2))
        .then((value) => {
          Navigator.popAndPushNamed(context, 'main')
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Wrap(
        spacing: 16,
        runSpacing: 8,
        children: [
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}
