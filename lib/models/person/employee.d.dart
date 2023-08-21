import 'dart:math';

import 'package:hanet/models/department/department.d.dart';
import 'package:hanet/models/person/person.d.dart';

class Employee {
  String? profile;
  String? name;
  String? department;
  String? postion;
  String? categorize;

  Employee(
      {this.profile,
      this.name,
      this.department,
      this.postion,
      this.categorize});
}

class EmployeeBuilder {
  static Random random = Random(2);
  static List<String> positions = [
    "Leader",
    "BA",
    "Intern",
    "Developer",
  ];
  static Employee createAnEmployee() {
    return Employee(
        profile: "",
        name: "Employee${random.nextInt(10)}",
        department: random.nextInt(2) % 2 == 0 ? "IT" : "Accounting",
        postion: positions[random.nextInt(positions.length)],
        categorize: "Employee");
  }

  static Employee fromPersonAndDepartment(
      HanetPerson person, HanetDepartment department) {
    Employee employee = Employee();
    // assign data
    employee.name = person.name;
    switch (person.type) {
      case 0:
        employee.categorize = "Staff";
        break;
      case 1:
        employee.categorize = "Employee";
        break;
      default:
        employee.categorize = "Other";
    }
    employee.profile = person.avatar;
    employee.postion = person.title;
    employee.department = department.name;

    return employee;
  }
}
