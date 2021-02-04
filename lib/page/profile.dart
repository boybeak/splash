import 'package:flutter/material.dart';
import 'package:splash/api.dart';
import 'package:splash/model/user.dart';
import 'package:url_launcher/url_launcher.dart';

class UserPage extends StatefulWidget {
  final User user;

  UserPage(this.user, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _UserPageState();
  }
}

class _UserPageState extends State<UserPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();
  Color _actionBarBgColor = Color.fromARGB(0, 0, 0, 0);
  List tabs = ["新闻", "历史", "图片"];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: TabBar(
            controller: _tabController,
            tabs: tabs
                .map((e) => Tab(
                      text: e,
                    ))
                .toList(),
            indicatorColor: Colors.white60,
          ),
        ),
        elevation: 0,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          UserInfoPage(widget.user),
          UserInfoPage(widget.user),
          UserInfoPage(widget.user)
        ],
      ),
    );
  }
}

class UserInfoPage extends StatefulWidget {
  final User user;

  UserInfoPage(this.user, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return UserInfoPageState();
  }
}

class UserInfoPageState extends State<UserInfoPage> {
  List items = new List();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: items.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return UserInfoCard(widget.user);
          } else {
            return Text("index=$index");
          }
        });
  }
}

class UserInfoCard extends StatefulWidget {
  final User user;

  UserInfoCard(this.user, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return UserInfoCardState();
  }
}

class UserInfoCardState extends State<UserInfoCard> {

  @override
  Widget build(BuildContext context) {

    var socials = widget.user.getSocials().map((e) => InkWell(
      child: Icon(
        e.icon,
        color: Colors.white,
        size: 12,
      ),
      onTap: () async {
        if (await canLaunch(e.getAccountUrl())) {
          launch(e.getAccountUrl());
        } else {
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text("Can not open"))
          );
        }
      },
    )).toList();

    return Container(
      height: 200,
      padding: EdgeInsets.all(8),
      child: Card(
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  widget.user.profile_image.large,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8),
                child: Wrap(
                  direction: Axis.vertical,
                  children: [
                    Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(32)),
                          width: 64,
                          height: 64,
                          child: CircleAvatar(
                            backgroundImage:
                            NetworkImage(widget.user.profile_image.large),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 8, right: 8),
                          child: Wrap(
                            direction: Axis.vertical,
                            children: [
                              Text(
                                widget.user.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 4),
                                child: Wrap(
                                  spacing: 8,
                                  children: socials,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      child: Text(
                        widget.user.getBioCompat(),
                        maxLines: 3,
                        style: TextStyle(color: Colors.white70),
                        overflow: TextOverflow.ellipsis,
                      ),
                      padding: EdgeInsets.only(top: 8, bottom: 8),
                    ),
                  ],
                ),
              )
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          )),
    );
  }
}
