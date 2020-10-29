import 'package:dragable/home_page.dart';
import 'package:flutter/material.dart';

//
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     Color caughtColor = Colors.deepPurple;
//     return SafeArea(
//       child: Scaffold(
//         body: Container(
//           child: Stack(
//             children: <Widget>[
//               DragBox(Offset(0.0, 0.0), 'Box One', Colors.blueAccent),
//               DragBox(Offset(150.0, 0.0), 'Box Two', Colors.orange),
//               DragBox(Offset(300.0, 0.0), 'Box Three', Colors.lightGreen),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class DragBox extends StatefulWidget {
//   final Offset initPos;
//   final String label;
//   final Color itemColor;
//
//   DragBox(this.initPos, this.label, this.itemColor);
//
//   @override
//   DragBoxState createState() => DragBoxState();
// }
//
// class DragBoxState extends State<DragBox> {
//   Offset position = Offset(0.0, 0.0);
//
//   @override
//   void initState() {
//     super.initState();
//     position = widget.initPos;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//         left: position.dx,
//         top: position.dy,
//         child: Draggable(
//           data: widget.itemColor,
//           child: Container(
//             width: 100.0,
//             height: 100.0,
//             color: widget.itemColor,
//             child: Center(
//               child: Text(
//                 widget.label,
//                 style: TextStyle(
//                   color: Colors.white,
//                   decoration: TextDecoration.none,
//                   fontSize: 20.0,
//                 ),
//               ),
//             ),
//           ),
//           onDraggableCanceled: (velocity, offset) {
//             setState(() {
//               position = offset;
//             });
//           },
//           feedback: Container(
//             width: 100.0,
//             height: 100.0,
//             color: widget.itemColor.withOpacity(0.5),
//             child: Center(
//               child: Text(
//                 widget.label,
//                 style: TextStyle(
//                   color: Colors.white,
//                   decoration: TextDecoration.none,
//                   fontSize: 18.0,
//                 ),
//               ),
//             ),
//           ),
//         ));
//   }
// }
