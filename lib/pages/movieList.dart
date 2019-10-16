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
  int _sliderValue = 0;
  @override
  void initState() {
    super.initState();
    controller = PageController(
      initialPage: 0,
      viewportFraction: 0.8,
    );
    _movieSelector(controller);
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
                DocumentSnapshot movies = snapshot.data.documents[index];
                if (snapshot.data.documents.length == 0) {
                  const Text("Fetching Data");
                } else {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => DetailsPage(
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
                return Container(
                  height: 50,
                  width: 50,
                  child: Text("1 stream"),
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
    return Stack(children: <Widget>[
      StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('movies').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data.documents.length == 0)
              const Text("loading");
            else {
              return Stack(
                children: <Widget>[
                  PageView.builder(
                    itemCount: snapshot.data.documents.length,
                    controller: controller,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 35.0, left: 35),
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
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 50,
                      child: Material(
                        child: Slider(
                          activeColor: Colors.black,
                          min: 0.0,
                          max: 100.0,
                          value: _sliderValue.toDouble(),
                          divisions: 100,
                          onChangeEnd: (double value) {
                            value = value;
                          },
                          onChanged: (double index) {
                            _sliderValue = controller.animateToPage(
                                index.round(),
                                curve: Curves.ease,
                                duration: Duration(seconds: 5)) as int;

                            index = _sliderValue as double;
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            return Container(
                  height: 50,
                  width: 50,
                  child: Text("2 stream"),
                );
          }),
    ]);
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
