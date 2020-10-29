import 'package:flutter/cupertino.dart';

class Employee {
  final Offset offset;
  final Icon icon;

  Employee({this.icon, this.offset});
}

class Constants {
  static List<Employee> initializeList(List<Employee> itemList) {
    itemList = [];

    return itemList;
  }
}

class Data with ChangeNotifier {
  bool successDrop;
  List<Employee> employees;
  Employee acceptedData;

  Data() {
    successDrop = false;

    employees = Constants.initializeList(employees);
  }

  bool get isSuccessDrop => successDrop;
  List<Employee> get itemsList => employees;
  Employee get getAcceptedData => acceptedData;

  set setSuccessDrop(bool status) {
    successDrop = status;
    notifyListeners();
  }

  changeAcceptedData(Employee data) {
    acceptedData = data;
    notifyListeners();
  }

  changeSuccessDrop(bool status) {
    setSuccessDrop = status;
  }

  removeLastItem() {
    employees.removeLast();
    notifyListeners();
  }

  addItemToList(Employee item) {
    employees.add(item);
    notifyListeners();
  }

  initializeDraggableList() {
    employees = Constants.initializeList(employees);
    notifyListeners();
  }
}
