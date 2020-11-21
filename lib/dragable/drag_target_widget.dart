import 'dart:io';
import 'dart:ui';

import 'package:dragable/dragable/draggable_widget.dart';
import 'package:dragable/dragable/employee.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class DragTargetWidget extends StatefulWidget {
  final File file;

  const DragTargetWidget({Key key, this.file}) : super(key: key);
  @override
  DragTargetWidgetState createState() => DragTargetWidgetState();
}

class DragTargetWidgetState extends State<DragTargetWidget> {
  Offset offset;
  List<DraggableItem> draggableListInTarget = [];
  GlobalKey _targetKey = GlobalKey();
  Size sizeTarget;
  String employeelist;
  @override
  void initState() {
    print("======Start init state function =====");
    WidgetsBinding.instance.addPostFrameCallback((_) => getSize());
    super.initState();
  }

  getSize() async {
    print("======= Start addPostFramCallback function =======");
    RenderBox box = _targetKey.currentContext.findRenderObject();
    sizeTarget = box.size;
  }

  @override
  Widget build(BuildContext context) {
    print("====Start build function=====");
    var size = MediaQuery.of(context).size;
    print("Size ${size} - size target: ${sizeTarget}");
    return Consumer<Employees>(
      builder: (context, employees, child) => DragTarget(onWillAccept: (data) {
        print("data onWillAccept: ${data}");
        return true;
      }, onAccept: (data) {
        print("data onAccept ${data}");
        return true;
      }, onAcceptWithDetails: (DragTargetDetails data) {
        print(
            'Accept with detail dx - dy: ${data.offset.dx} - ${data.offset.dy}');
        // offset = data.offset - Offset(50, 75);
        // if (offset > Offset(0, 0) &&
        //     offset < Offset(sizeTarget.width - 50, sizeTarget.height - 50)) {
        //   // var dx =
        //   //     num.parse(((offset.dx * 100) / size.width).toStringAsFixed(2));
        //   // var dy =
        //   //     num.parse(((offset.dy * 100) / size.height).toStringAsFixed(2));
        //   // print("dx ${dx} - ${num.parse(dx.toStringAsFixed(2))}");
        //   // print("dy ${dy} - ${num.parse(dy.toStringAsFixed(2))}");
        //   employees.employees
        //       .add(Employee(id: employees.employees.length, offset: offset));
        //   setState(() {});
        // }

        ///
        offset = data.offset;
        employees.employees
            .add(Employee(id: employees.employees.length, offset: offset));
        setState(() {});
      }, onMove: (data) {
        print("OnMove dx - dy ${data.offset.dx} - ${data.offset.dy}");
      }, builder: (context, List<Offset> acceptdata, rejectdata) {
        return Container(
          key: _targetKey,
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: Colors.red,
            ),
          ),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                child: Image.file(
                  widget.file,
                  fit: BoxFit.fill,
                ),
              ),
              Stack(
                children: targetList(employees.employees),
              ),
            ],
          ),
        );
      }),
    );
  }

  List<DraggableItem> targetList(List<Employee> employees) {
    for (int i = 0; i < employees.length; i++) {
      print("employee[i] ${i}");
      if (draggableListInTarget.length == 0) {
        draggableListInTarget
            .add(DraggableItem(employee: employees[i], size: sizeTarget));
      }
      if (draggableListInTarget.length > 0) {
        if (!isCheck(
            draggableListInTarget,
            DraggableItem(
              employee: employees[i],
            ))) {
          draggableListInTarget
              .add(DraggableItem(employee: employees[i], size: sizeTarget));
        }
      }
    }
    print("draggableListInTarget ${draggableListInTarget.length}");
    return draggableListInTarget;
  }

  bool isCheck(List<DraggableItem> list, DraggableItem item) {
    for (int i = 0; i < list.length; i++) {
      if (list[i].employee.id == item.employee.id) {
        return true;
      }
    }
    return false;
  }
}

class DraggableItem extends StatefulWidget {
  const DraggableItem({
    Key key,
    this.employee,
    this.size,
    // this.callBack,
  }) : super(key: key);
  final Employee employee;
  final Size size;

  @override
  _DraggableItemState createState() => _DraggableItemState();
}

class _DraggableItemState extends State<DraggableItem> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.employee.offset?.dx,
      top: widget.employee.offset?.dy,
      child: GestureDetector(
          onLongPress: () {},
          onTap: () {
            print("You tap on Icon index ${widget.employee.id}");
            // print("Target size ${widget.size}");
          },
          onDoubleTap: () {},
          onPanUpdate: (details) {
            print("globalPosition ${details.globalPosition}");
            print(
                "${widget.employee.offset} - ${details.globalPosition - Offset(50, 50)}");
            setState(() {
              if ((details.globalPosition.dx > 10 &&
                      details.globalPosition.dy > 10) &&
                  (details.globalPosition.dx < widget.size.width + 40 &&
                      details.globalPosition.dy < widget.size.height + 40)) {
                widget.employee.offset =
                    details.globalPosition - Offset(50, 50);
              }
            });
            // Offset(
            //     ((widget.employee.offset.dx * 100) / widget.size.width),
            //     (widget.employee.offset.dy * 100 / widget.size.height)
          },
          child: ChairIcon(
              index: widget.employee.id,
              offsetDisplay: widget.employee.offset)),
    );
  }
}
