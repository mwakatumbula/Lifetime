import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lifetime/pages/detailsPage.dart';

class MovieBuilder extends StatefulWidget {
  @override
  _MovieBuilderState createState() => _MovieBuilderState();
}

class _MovieBuilderState extends State<MovieBuilder> {
  PageController controller;
  @override
  void initState() {
    super.initState();
    controller = PageController(
      initialPage: 0,
      viewportFraction: 0.8,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _movieSelector(
    index,
  ) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, widget) {
        double value = 1;
        if (controller.position.haveDimensions) {
          value = controller.page - index;
          value = (1 - (value.abs() * 0.5) + 0.06).clamp(0.0, 1.0);
        }

        return Center(
          child: Stack(
            children: <Widget>[
              SizedBox(
                height: Curves.easeInOut.transform(value) * 625,
                width: Curves.easeInOut.transform(value) * double.infinity,
                child: widget,
              ),
            ],
          ),
        );
      },
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black54,
                    offset: Offset(0.0, 4.0),
                    blurRadius: 4)
              ],
            ),
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('movies').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  const Text("Fetching Data");
                } else {
                  DocumentSnapshot movies = snapshot.data.documents[index];
                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsPage(
                                  bg: "${movies["bg"]}",
                                  index: index,
                                  title: "${movies["title"]}",
                                  rating: "${movies["rating"]}",
                                  yt: "${movies["yt"]}",
                                  cast: "${movies["cast"]}",
                                  des: "${movies["des"]}",
                                  year: "${movies["year"]}",
                                ))),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Hero(
                          tag: "movie${(index)}",
                          child: CachedNetworkImage(
                            imageUrl: "${movies["bg"]}",
                            height: 700,
                            width: 500,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => SpinKitRipple(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return SpinKitRipple(
                  color: Colors.black,
                  size: 50,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('movies').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                const Text("loading");
              else {
                return Stack(
                  children: <Widget>[
                    PageView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data.documents.length,
                      controller: controller,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 50.0, left: 35),
                              child: Text(
                                (index + 1).toString(),
                                style: TextStyle(
                                    fontSize: 250,
                                    color: Colors.black38,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            _movieSelector(index),
                          ],
                        );
                      },
                    ),
                    
                  ],
                );
              }

              return SpinKitRipple(
                color: Colors.red,
                size: 50,
              );
            }),
      ],
    );
  }

  Widget getErrorWidget(BuildContext context, FlutterErrorDetails error) {
    return Center(
      child: Text(
        "Error appeared.",
        style: Theme.of(context).textTheme.title.copyWith(color: Colors.white),
      ),
    );
  }
}
