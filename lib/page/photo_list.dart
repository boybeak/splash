import 'package:flutter/material.dart';
import 'package:splash/api.dart';
import 'package:splash/model/photo.dart';
import 'package:splash/widget/footer.dart';
import 'package:splash/widget/photo_card.dart';

class PhotoListPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return PhotoListPageState();
  }
}

class PhotoListPageState extends State<PhotoListPage>{
  static int STATE_IDLE = 0, STATE_LOADING = 1, STATE_SUCCESS = 2, STATE_ERROR = -1;

  List<Photo> photos = new List<Photo>();
  ScrollController _scrollController = new ScrollController();
  int page = 0, per_page = 15;
  int state = 0;
  String footerMsg = "";

  bool isLoading() {
    return state == STATE_LOADING;
  }
  //
  // bool isFailed() {
  //   return state == STATE_ERROR;
  // }

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadNextPage();
      }
    });
    reloadPhotos();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void reloadPhotos() {
    page = 0;
    photos.clear();
    loadData(page, per_page, (){

    });
  }

  void loadNextPage() {
    var nextPage = page + 1;
    loadData(nextPage, per_page, (){
      page = nextPage;
    });
  }

  void loadData(int page, int pageSize, var onSuccess) {
    if (isLoading()) {
      return;
    }
    setState(() {
      state = STATE_LOADING;
    });
    Api.getPhotos(page, pageSize).then((value) {
      setState(() {
        state = STATE_SUCCESS;
        footerMsg = "${photos.length} items loaded";
        photos.addAll(value);
      });
    }).catchError((error) {
      setState(() {
        state = STATE_ERROR;
        footerMsg = error.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: photos.length + 1,
      controller: _scrollController,
      itemBuilder: (BuildContext context, int index) {
        if (photos.isEmpty || index == photos.length) {
          return Footer(state: state, footerMsg: footerMsg,);
        } else {
          Photo p = photos[index];
          return GestureDetector(
            child: PhotoCard(
              photo: p,
            ),
            onTap: () {
              print("click");
              Navigator.pushNamed(context, 'detail', arguments: {"photo": p});
            },
          );
        }
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: Colors.white30,
          height: 0.5,
        );
      },
    );
  }

}