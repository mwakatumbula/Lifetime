import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class MovieBuilder extends StatefulWidget {
  @override
  _MovieBuilderState createState() => _MovieBuilderState();
}

class _MovieBuilderState extends State<MovieBuilder> {

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('movies').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          const Text("Loading");
        } else {
          return Stack(
            children: <Widget>[
              Swiper(
                loop: false,
                itemCount: snapshot.data.documents.length,
                layout: SwiperLayout.TINDER,
                itemWidth: screenWidth * 0.99,
                itemHeight: screenHeight * 0.7,
                itemBuilder: (BuildContext context, index) {
                  DocumentSnapshot mypost = snapshot.data.documents[index];
                  return Stack(
                    children: <Widget>[
                      Center(
                        child: Stack(
                          children: <Widget>[
                            Card(
                              color: Colors.grey,
                              child: Column(
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                      Image.network(
                                        "${mypost['bg']}",
                                        fit: BoxFit.cover,
                                        width: 500,
                                        height: 600,
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                          height: screenHeight * 0.05,
                                          color: Colors.black,
                                          width: screenWidth * 0.2,
                                          child: Center(
                                            child: Text(
                                              (index + 1).toString(),
                                              style: TextStyle(
                                                  fontFamily: "Index",
                                                  fontSize: 50),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 25.0),
                                    child: Text("${mypost['title']}",
                                        style: TextStyle(
                                            fontFamily: "Title",
                                            fontSize: 35,
                                            fontWeight: FontWeight.bold)),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
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
