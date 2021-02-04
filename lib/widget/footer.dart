import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Footer extends StatefulWidget {

  static int STATE_IDLE = 0, STATE_LOADING = 1,
      STATE_SUCCESS = 2, STATE_ERROR = -1;

  final int state;
  final String footerMsg;

  Footer({Key key, @required this.state, this.footerMsg}): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FooterState();
  }
}

class FooterState extends State<Footer> {

  bool isLoading() {
    return widget.state == Footer.STATE_LOADING;
  }

  bool isFailed() {
    return widget.state == Footer.STATE_ERROR;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Center(
          child: Stack(
            children: [
              Visibility(
                  visible: !isLoading(),
                  child: Wrap(
                    direction: Axis.vertical,
                    spacing: 8,
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Container(
                        child: Text(widget.footerMsg),
                        padding: EdgeInsets.only(left: 8, right: 8),
                        width: MediaQuery.of(context).size.width,
                        // height: 120,
                      ),
                      Visibility(
                        visible: isFailed(),
                        child: TextButton(onPressed: () {}, child: Text("Retry")),
                      )
                    ],
                  )),
              Visibility(
                visible: isLoading(),
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                ),
              )
            ],
          )),
      padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
    );
  }

}