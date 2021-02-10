import 'package:flutter/material.dart';
import 'package:splash/model/collection.dart';

class CollectionCard extends StatefulWidget {
  final Collection collection;

  CollectionCard({Key key, @required this.collection}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CollectionCardState();
  }

}

class CollectionCardState extends State<CollectionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 240,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Image.network(
                widget.collection.cover_photo.urls.regular,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              InkWell(
                onTap: (){
                  Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text(widget.collection.title))
                  );
                },
                child: Container(
                  decoration: BoxDecoration(color: Colors.black38),
                  padding: EdgeInsets.all(8),
                  width: double.infinity, height: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    widget.collection.title,
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
