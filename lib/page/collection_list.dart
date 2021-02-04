import 'package:flutter/material.dart';
import 'package:splash/model/collection.dart';
import 'package:splash/widget/collection_card.dart';
import 'package:splash/widget/footer.dart';
import 'package:splash/api.dart';
import 'package:splash/widget/scroll_bottom_listener.dart';

class CollectionListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CollectionListPageList();
  }
}

class CollectionListPageList extends State<CollectionListPage> {
  ScrollBottomController bottomController = new ScrollBottomController();

  int state = Footer.STATE_IDLE;
  List<Collection> collections = List<Collection>();
  String footerMsg = "";

  int page;
  final int pageSize = 15;

  @override
  void initState() {
    bottomController.addOnScrollBottomListener(() {
      loadNextPage();
    });
    reloadPhotos();
    super.initState();
  }

  bool isLoading() {
    return state == Footer.STATE_LOADING;
  }

  void reloadPhotos() {
    page = 0;
    collections.clear();
    loadData(page, pageSize, () {});
  }

  void loadNextPage() {
    var nextPage = page + 1;
    loadData(nextPage, pageSize, () {
      page = nextPage;
    });
  }

  void loadData(int page, int pageSize, var onSuccess) {
    if (isLoading()) {
      return;
    }
    setState(() {
      state = Footer.STATE_LOADING;
    });
    Api.getCollections(page, pageSize).then((value) {
      setState(() {
        collections.addAll(value);
        state = Footer.STATE_SUCCESS;
      });
      onSuccess();
    }).catchError((e) {
      setState(() {
        state = Footer.STATE_ERROR;
        footerMsg = e.toString();
      });
    }).whenComplete(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: bottomController,
        itemCount: collections.length + 1,
        itemBuilder: (context, index) {
          if (collections.isEmpty || index == collections.length) {
            return Footer(
              state: state,
              footerMsg: footerMsg,
            );
          }
          return Container(
            child: CollectionCard(collection: collections[index]),
          );
        });
  }
}
