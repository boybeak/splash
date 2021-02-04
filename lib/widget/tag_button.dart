import 'package:flutter/material.dart';
import 'package:splash/model/tag.dart';

class TagButton extends StatefulWidget {

  final Tag tag;

  TagButton(this.tag, {Key key}): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TagButtonState();
  }
}

class _TagButtonState extends State<TagButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Scaffold.of(context).showBottomSheet((context) {
          return Stack(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                child: Text("data"),
              )
            ],
          );
        });
      },
      child: Container(
        child: DecoratedBox(
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.white70,
                  width: 1.2
              ),
              borderRadius: BorderRadius.circular(16),
              color: Colors.black12
          ),
          child: Padding(
            child: Text(widget.tag.title,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
            padding: EdgeInsets.fromLTRB(8, 6, 8, 6),
          ),
        ),
      ),
    );
  }
}