import 'package:flutter/material.dart';

class ScrollBottomController extends ScrollController {

  List<VoidCallback> bottomListeners = new List<VoidCallback>();

  ScrollBottomController(): super() {
    addListener(() {
      if (position.pixels == position.maxScrollExtent) {
        bottomListeners.forEach((element) {
          element.call();
        });
      }
    });
  }

  void addOnScrollBottomListener(VoidCallback callback) {
    if (bottomListeners.contains(callback)) {
      return;
    }
    bottomListeners.add(callback);
  }

  @override
  void dispose() {
    bottomListeners.clear();
    super.dispose();
  }

}