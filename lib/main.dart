import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifetime/pages/background.dart';
import 'package:lifetime/pages/movieList.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        canvasColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: Colors.white,
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.black26));
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "LIFETIME",
          style:
              TextStyle(color: Colors.black, fontFamily: "Title", fontSize: 30, fontWeight: FontWeight.w900),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          // Background(),
          MovieBuilder(),
        ],
      ),
    );
  }
}
