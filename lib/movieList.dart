import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('movies').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          const Text("Loading");
        } else {
          return PageView.builder(
              pageSnapping: true,
              physics: BouncingScrollPhysics(),
              controller: controller,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                DocumentSnapshot mypost = snapshot.data.documents[index];
                return Stack(
                  children: <Widget>[
                    Image.network(
                      "${mypost['bg']}",
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.low,
                      height: double.infinity,
                    ),
                    ClipRect(
                      child: BackdropFilter(
                        filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: Center(
                          child: Container(
                            height: 510,
                            child: Card(
                              color: Colors.black,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Image.network(
                                      "${mypost['bg']}",
                                      fit: BoxFit.values[2],
                                    ),
                                    height: 450,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      '${mypost['title']}',
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              });
        }
        return CircularProgressIndicator();
      },
    );
  }
}
