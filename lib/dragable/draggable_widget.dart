import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DraggableWidget extends StatelessWidget {
  const DraggableWidget({Key key, this.index, this.offset}) : super(key: key);
  final Offset offset;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Draggable<Offset>(
        dragAnchor: DragAnchor.pointer,
        childWhenDragging: ChairIcon(
          index: index,
        ),
        feedback: ChairIcon(),
        onDragEnd: (detail) {
          print("onDragEnd ${detail.offset}");
        },
        onDragCompleted: () {},
        // data: offset,
        child: ChairIcon(
          index: index,
          offsetDisplay: offset,
        ));
  }
}

class ChairIcon extends StatelessWidget {
  final int index;
  final Offset offsetDisplay;
  const ChairIcon({Key key, this.index, this.offsetDisplay}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          border: Border.all(width: 0, color: Colors.blue),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/images/chair.jpg"),
          )),
      child: Text(
        "${index}\n(${(offsetDisplay?.dx)?.floor()}, ${(offsetDisplay?.dy)?.floor()})",
        style: TextStyle(
            color: Colors.red, fontWeight: FontWeight.bold, fontSize: 10),
      ),
    );
  }
}
