import 'package:flutter/material.dart';
import 'package:splash/model/exif.dart';
import 'package:splash/model/location.dart';
import 'package:splash/model/photo.dart';

class PhotoInfoCard extends StatefulWidget {
  final Photo photo;

  PhotoInfoCard(this.photo);

  @override
  State<StatefulWidget> createState() {
    return _PhotoInfoCardState();
  }
}

class _PhotoInfoCardState extends State<PhotoInfoCard> {
  @override
  Widget build(BuildContext context) {

    List<Widget> headerAndRows = new List<Widget>();
    if (widget.photo.description != null) {
      headerAndRows.add(Header("Description"));
      headerAndRows.add(Padding(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Text(widget.photo.description),
      ));
    }

    final Exif exif = widget.photo.exif;
    if (exif != null) {
      headerAndRows.add(Header("Exif"));
      headerAndRows.add(Padding(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Table(
          children: [
            InfoTableRow(Icons.architecture_outlined, "Size", "${widget.photo.width} x ${widget.photo.height}"),
            InfoTableRow(Icons.camera_alt_outlined, "Model", exif.model),
            InfoTableRow(Icons.camera_roll_outlined, "Make", exif.make),
            InfoTableRow(
                Icons.camera_outlined, "Aperture", exif.aperture),
            InfoTableRow(Icons.iso_outlined, "ISO", exif.iso.toString()),
            InfoTableRow(Icons.timelapse_outlined, "Exposure time",
                exif.exposure_time),
            InfoTableRow(Icons.switch_camera_outlined, "Focal length",
                exif.focal_length),
          ],
        ),
      ));
    }

    final Location location = widget.photo.location;
    if (location != null && !location.isEmpty()) {
      List<TableRow> rows = new List<TableRow>();
      headerAndRows.add(Header("Location"));

      if (location.country != null) {
        rows.add(InfoTableRow(Icons.map_outlined, "Country", location.country));
      }
      if (location.city != null) {
        rows.add(InfoTableRow(Icons.location_city_outlined, "City", location.city));
      }
      if (location.position != null && location.position.isValid()) {
        rows.add(InfoTableRow(Icons.location_on_outlined, "Position", location.position.toString()));
      }

      headerAndRows.add(Padding(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Table(
          children: rows,
        ),
      ));
    }

    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: headerAndRows,
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
      width: double.infinity,
      height: 480,
    );
  }
}

class InfoCell extends SizedBox {
  InfoCell(IconData iconData, String title, String text): super(
    width: 120,
    child: Row(
        children: [
          Icon(iconData, color: Colors.black38,),
          Column(
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.black38, fontSize: 18),
              ),
              Text(
                text,
                style: TextStyle(color: Colors.black38, fontSize: 18),
              )
            ],
          )
        ]
    ),
  );
}

class Header extends Padding {
  Header(String data)
      : super(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: HeaderText(data));
}

class HeaderText extends Text {
  HeaderText(String data)
      : super(data,
            style: TextStyle(
                color: Colors.black45,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal));
}

class InfoTableRow extends TableRow {
  InfoTableRow(IconData icon, String name, String value)
      : super(children: [
          Container(
            padding: EdgeInsets.only(top: 4, bottom: 4),
            height: 40,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Icon(icon, color: Colors.black38,),
                ),
                Text(
                  name,
                  style: TextStyle(color: Colors.black38, fontSize: 18),
                )
              ],
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
            alignment: Alignment.centerLeft
          ),
          Container(
            padding: EdgeInsets.only(top: 4, bottom: 4),
            height: 40,
            child: Text(
              value,
              style: TextStyle(color: Colors.black38, fontSize: 18),
            ),
            alignment: Alignment.centerLeft,
          )
        ]);
}
