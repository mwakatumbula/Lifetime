import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lifetime/widgets/cutomClipper.dart';

class DetailsPage extends StatefulWidget {
  final String bg;
  final int index;

  DetailsPage({Key key, this.bg, this.index}) : super(key: key);

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
            ],
          )
        ],
      ),
    );
  }
}
