import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class MovieBuilder extends StatefulWidget {
  @override
  _MovieBuilderState createState() => _MovieBuilderState();
}

class _MovieBuilderState extends State<MovieBuilder> {
  PageController controller = PageController(
    viewportFraction: 1,
    initialPage: 0,
  );
  @override
  Widget build(
    BuildContext context,
  ) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('movies').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          const Text("Loading");
        } else {
          return Stack(
            children: <Widget>[
              Swiper(
                loop: true,
                index: 0,
                itemCount: snapshot.data.documents.length,
                layout: SwiperLayout.TINDER,
                itemWidth: 500,
                itemHeight: 708,
                itemBuilder: (BuildContext context, index) {
                  DocumentSnapshot mypost = snapshot.data.documents[index];
                  return Stack(
                    children: <Widget>[
                      Center(
                        child: Card(
                          color: Colors.black,
                          child: Column(
                            children: <Widget>[
                              Image.network(
                                "${mypost['bg']}",
                                fit: BoxFit.cover,
                                width: 500,
                                height: 600,
                              ),
                              Text("${mypost['title']}")
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                  // return Center(child: Text("Hello"));
                },
              ),
            ],
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
