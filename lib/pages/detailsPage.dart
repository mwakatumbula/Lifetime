import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifetime/widgets/cutomClipper.dart';

class DetailsPage extends StatefulWidget {
  final String bg;
  final int index;
  final String title;
  final String rating;
  final String year;
  final String cast;
  final String yt;
  final String des;

  DetailsPage({
    Key key,
    this.bg,
    this.index,
    this.title,
    this.rating,
    this.year,
    this.cast,
    this.yt,
    this.des,
  }) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                child: Hero(
                  tag: "movie${(widget.index)}",
                  child: ClipShadowPath(
                    clipper: CircularClipper(),
                    shadow: Shadow(blurRadius: 20.0),
                    child: ClipPath(
                      child: CachedNetworkImage(
                        imageUrl: widget.bg,
                        height: 500,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => SpinKitRipple(
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: RawMaterialButton(
                        elevation: 10,
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          child: Container(
                            margin: EdgeInsets.only(right: 3, bottom: 3),
                            child: Icon(
                              FontAwesomeIcons.youtube,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        fillColor: Colors.red,
                        shape: CircleBorder(),
                        onPressed: () {
                          //TODO: Add URL launcher here for youtube.
                        },
                      )),
                ),
              )
            ],
          ),
          Column(
            children: <Widget>[
              buildRow(),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  widget.des,
                  style: TextStyle(
                      fontFamily: "Index",
                      fontSize: 30,
                      fontStyle: FontStyle.italic),
                ),
              )
            ],
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 15,
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                height: 50,
                width: 40,
                child: Icon(FontAwesomeIcons.check),
              ),
              Container(
                height: 50,
                width: 40,
                child: Icon(FontAwesomeIcons.plus),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row buildRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          height: 70,
          width: 70,
          child: Card(
            elevation: 5,
            color: Colors.white70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(FontAwesomeIcons.calendarAlt),
                Divider(
                  height: 2,
                ),
                Text(widget.year)
              ],
            ),
          ),
        ),
        Container(
          height: 70,
          width: 70,
          child: Card(
            elevation: 5,
            color: Colors.white70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(FontAwesomeIcons.imdb),
                Divider(
                  height: 2,
                ),
                Text(widget.rating)
              ],
            ),
          ),
        ),
        GestureDetector(
          child: Container(
            height: 70,
            width: 70,
            child: Card(
              elevation: 5,
              color: Colors.white70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(FontAwesomeIcons.idBadge),
                  Divider(
                    height: 2,
                  ),
                  Text("Cast")
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
