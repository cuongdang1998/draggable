import 'package:flutter/cupertino.dart';

class Employee {
  int id;
  Offset offset;

  Employee({this.id, this.offset});
}

class Employees with ChangeNotifier {
  List<Employee> employees = [];
  Employee acceptedData;

  Employee get getAcceptedData => acceptedData;

  changeAcceptedData(Employee data) {
    acceptedData = data;
    notifyListeners();
  }

  removeLastItem() {
    employees.removeLast();
    notifyListeners();
  }

  addItemToList(Employee item) {
    employees.add(item);
    notifyListeners();
  }
}
