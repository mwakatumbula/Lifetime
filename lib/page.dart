// import 'package:flutter/material.dart';

// class Page extends StatefulWidget {
//   @override
//   _PageState createState() => _PageState();
// }

// class _PageState extends State<Page> {
//   @override
//   Widget build(BuildContext context) {
//     PageController controller;
//     double _sliderValue;
//     return Column(
//       children: <Widget>[
//         PageView.builder(
//           controller: controller,
//           itemCount: 3,
//           itemBuilder: (context, index) {
//             return Container(
//               child: Text(index.toString()),
//             );
//           },
//         ),
//         Slider(
//           activeColor: Colors.indigoAccent,
//           min: 0.0,
//           max: 50.0,
//           onChanged: (index) {
//             setState(() {
//               _sliderValue = controller.animateToPage(
//                 duration: Duration(seconds: 1),
//                 curve: Curves.easeIn,
//               );
//             });
//           },
//           value: _sliderValue,
//         ),
//       ],
//     );
//   }
// }
