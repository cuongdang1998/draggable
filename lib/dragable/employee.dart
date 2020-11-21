import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Employee {
  int id;
  Offset offset;

  Employee({this.id, this.offset});
  Map<String, dynamic> toJson() => {'id': id, 'offset': offset};
  factory Employee.fromJson(Map<String, dynamic> json) =>
      Employee(id: json["id"], offset: ["offset"] as Offset);
}

class Employees with ChangeNotifier {
  List<Employee> employees = [];
  static String encodeEmployees(List<Employee> employees) =>
      json.encode(employees
          .map<Map<String, dynamic>>((employee) => employee.toJson())
          .toList());

  static List<Employee> decodeEmployees(String employees) =>
      (json.decode(employees) as List<dynamic>)
          .map<Employee>((e) => Employee.fromJson(e))
          .toList();
}
