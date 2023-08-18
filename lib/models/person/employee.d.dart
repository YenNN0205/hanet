import 'dart:math';

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
}
