import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifetime/pages/background.dart';

class DetailsPage extends StatefulWidget {
  final String title;
  final String bg;

  DetailsPage({Key key, this.title, this.bg}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Background(),
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                expandedHeight: screenHeight * 0.5,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    widget.bg,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Center(
                      child: Container(
                        child: Text(
                          widget.title,
                          style: TextStyle(
                              fontSize: 30,
                              fontFamily: "Title",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.04,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40))),
                          child: Container(
                            height: screenHeight * 0.1,
                            width: screenWidth * 0.17,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Icon(FontAwesomeIcons.calendar),
                                Text("Year")
                              ],
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40))),
                          child: Container(
                            height: screenHeight * 0.1,
                            width: screenWidth * 0.17,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Icon(FontAwesomeIcons.imdb),
                                Text("Rating")
                              ],
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40))),
                          child: Container(
                            height: screenHeight * 0.1,
                            width: screenWidth * 0.17,
                            child: InkWell(
                                borderRadius: BorderRadius.circular(40),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Icon(FontAwesomeIcons.idBadge),
                                    Text("Cast"),
                                  ],
                                ),
                                onTap: () {
                                  print("object");
                                }),
                          ),
                        ),
                      ]),
                ]),
              )
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: screenHeight * 0.05,
          child: Container(
            child: Container(
              color: Colors.red,
              height: double.infinity,
              child: Icon(
                FontAwesomeIcons.youtube,
                size: 35,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
