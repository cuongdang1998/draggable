import 'package:flutter/material.dart';

class DraggableWidget extends StatefulWidget {
  const DraggableWidget({Key key}) : super(key: key);
  @override
  _DraggableWidgetState createState() => _DraggableWidgetState();
}

class _DraggableWidgetState extends State<DraggableWidget> {
  Offset position = Offset(0.0, 0.0);
  @override
  Widget build(BuildContext context) {
    return Draggable(
        childWhenDragging: Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/images/chair.jpg"),
          )),
        ),
        feedback: Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/images/chair.jpg"),
          )),
        ),
        onDraggableCanceled: (velocity, offset) {
          setState(() {
            position = offset;
            print("onDraggableCanceled ${offset}");
          });
        },
        // onDragStarted: () {
        //
        // },
        onDragEnd: (detail) {
          print("onDragEnd ${detail.offset}");
          setState(() {
            position = detail.offset;
          });
        },
        data: position,
        child: Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/images/chair.jpg"),
          )),
        ));
  }
}
