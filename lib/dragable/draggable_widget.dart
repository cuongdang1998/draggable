import 'package:flutter/material.dart';

class DraggableWidget extends StatefulWidget {
  const DraggableWidget({Key key, this.index, this.offset}) : super(key: key);
  final Offset offset;
  final int index;
  @override
  _DraggableWidgetState createState() => _DraggableWidgetState();
}

class _DraggableWidgetState extends State<DraggableWidget> {
  Offset offset = Offset(0, 0);
  @override
  Widget build(BuildContext context) {
    return Draggable(
        childWhenDragging: ChairIcon(
          index: widget.index,
        ),
        feedback: ChairIcon(
          index: widget.index,
        ),
        onDragEnd: (detail) {
          print("onDragEnd ${detail.offset}");
          setState(() {
            offset = detail.offset;
          });
        },
        data: offset,
        child: ChairIcon(
          index: widget.index,
          offset: widget.offset,
        ));
  }
}

class ChairIcon extends StatelessWidget {
  final int index;
  final Offset offset;
  const ChairIcon({Key key, this.index, this.offset}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.blue),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/images/chair.jpg"),
          )),
      child: Text(
        "${index}\n(${(offset?.dx)?.floor()}, ${(offset?.dy)?.floor()})",
        style: TextStyle(
            color: Colors.red, fontWeight: FontWeight.bold, fontSize: 10),
      ),
    );
  }
}
