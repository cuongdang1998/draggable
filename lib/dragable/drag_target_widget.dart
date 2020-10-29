import 'dart:ui';

import 'package:dragable/dragable/draggable_widget.dart';
import 'package:flutter/material.dart';

class DragTargetWidget extends StatelessWidget {
  Offset offset;
  @override
  Widget build(BuildContext context) {
    return DragTarget(onWillAccept: (data) {
      if (data.dx > 0.0 && data.dy > 0.0) {
        return true;
      } else {
        return false;
      }
    }, onAccept: (data) {
      offset = data;
      print("data ${data}");
      return true;
    }, builder: (context, List<Offset> acceptdata, rejectdata) {
      print("acceptdata ${acceptdata}");
      print("rejectdata ${rejectdata}");
      return Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/commercialoffice.jpg"),
                    fit: BoxFit.fill)),
            child: Stack(
              children: [
                offset != null
                    ? Positioned(
                        left: offset.dx,
                        top: offset.dy,
                        child: DraggableWidget(),
                      )
                    : SizedBox(),
              ],
            ),
          ),
          Container(
            child: Text("${offset}"),
          )
        ],
      );
    });
  }
}
