import 'package:flutter/material.dart';
import 'package:splash/model/user.dart';

import '../api.dart';

class UserBar extends StatefulWidget {
  static const Size AVATAR_SIZE = const Size(48, 48);

  final User user;
  Color primaryColor;
  Size avatarSize;

  UserBar(this.user,
      {Key key,
      this.primaryColor = Colors.white,
      this.avatarSize = AVATAR_SIZE})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _UserBarState();
  }
}

class _UserBarState extends State<UserBar> {
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: widget.avatarSize.width,
            height: widget.avatarSize.height,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 1.5, color: widget.primaryColor)),
            child: CircleAvatar(
              backgroundImage: NetworkImage(widget.user.profile_image.medium,
                  headers: Api.headers),
            ),
          ),
          SizedBox(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                this.widget.user.name,
                style: TextStyle(
                  color: widget.primaryColor,
                  fontSize: 18,
                ),
                maxLines: 1,
              ),
            ),
            width: 180,
          )
        ],
      ),
      onTap: (){
        Navigator.pushNamed(context, 'user', arguments: {
          'user': widget.user
        });
      },
    );
  }
}
