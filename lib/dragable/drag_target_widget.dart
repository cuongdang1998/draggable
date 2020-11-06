import 'dart:ui';

import 'package:dragable/dragable/draggable_widget.dart';
import 'package:dragable/dragable/employee.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DragTargetWidget extends StatefulWidget {
  @override
  _DragTargetWidgetState createState() => _DragTargetWidgetState();
}

class _DragTargetWidgetState extends State<DragTargetWidget> {
  Offset offset;
  List<DraggableItem> draggableListInTarget = [];
  List<Offset> acceptedOffsetList = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Employees>(
      builder: (context, employees, child) => DragTarget(onWillAccept: (data) {
        return true;
      }, onAccept: (data) {
        print("data onAccept ${data}");
        return true;
      }, onAcceptWithDetails: (DragTargetDetails data) {
        print('Accept with detail dx: ${data.offset.dx}');
        print('Accept with detail dy: ${data.offset.dy}');
        offset = data.offset - Offset(50, 50);
        employees.employees
            .add(Employee(id: employees.employees.length, offset: offset));
        //acceptedOffsetList.add(offset);
        print("offset minus widget ${offset}");
        setState(() {});
      }, onMove: (data) {
        print("OnMove dx ${data.offset.dx}");
        print("OnMove dy ${data.offset.dy}");
      }, builder: (context, List<Offset> acceptdata, rejectdata) {
        print("acceptdata ${acceptdata}");
        print("rejectdata ${rejectdata}");
        return Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.red),
              image: DecorationImage(
                  image: AssetImage("assets/images/commercialoffice.jpg"),
                  fit: BoxFit.fill)),
          child: Stack(
            children: targetList(employees.employees),
          ),
        );
      }),
    );
  }

  List<DraggableItem> targetList(List<Employee> employee) {
    int currentTapping;
    for (int i = 0; i < employee.length; i++) {
      print("employee[i] ${i}");
      if (draggableListInTarget.length == 0) {
        draggableListInTarget.add(DraggableItem(
          employee: employee[i],
        ));
      }
      if (draggableListInTarget.length > 0) {
        if (!isCheck(
            draggableListInTarget,
            DraggableItem(
              employee: employee[i],
            ))) {
          draggableListInTarget.add(DraggableItem(
            employee: employee[i],
          ));
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

// typedef void DraggableCallBack(index);

class DraggableItem extends StatefulWidget {
  const DraggableItem({
    Key key,
    this.employee,
    // this.callBack,
  }) : super(key: key);
  final Employee employee;

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
            //currentTapping = i;
            //callBack(index);
          },
          onDoubleTap: () {},
          onPanUpdate: (details) {
            print("globalPosition ${details.globalPosition}");
            print(
                "${widget.employee.offset} - ${details.globalPosition - Offset(50, 50)}");
            setState(() {
              widget.employee.offset = details.globalPosition - Offset(50, 50);
            });
          },
          child: ChairIcon(
              index: widget.employee.id, offset: widget.employee.offset)),
    );
  }
}
