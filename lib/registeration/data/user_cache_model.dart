import 'package:cloud_firestore/cloud_firestore.dart';
//    AdminModel model = AdminModel(
//         name: 'Write your name...',
//         level: 3,
//         hourlyRate: 0,
//         totalHours: 0,
//         totalSalary: 0,
//         currentMonthHours: 0,
//         currentMonthSalary: 0,
//     );
class AdminModel
{
//    AdminModel model = AdminModel(
//         name: 'Write your name...',
//         level: 3,
//         hourlyRate: 0,
//         totalHours: 0,
//         totalSalary: 0,
//         currentMonthHours: 0,
//         currentMonthSalary: 0,
//     );
  String? name;
  String? email;
  String? id;
  String? phone;
  String? fname;
  String? lname;
  String? token;
  String? totalSalary;
  List<String>? branches;




  AdminModel({
    this.name,
    this.email,
    this.id,
    this.phone,
    this.fname,
    this.lname,
    this.token,
    this.totalSalary,
    this.branches,
  });

  AdminModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    id = json['id'];
    phone = json['phone'];
    fname = json['fname'];
    lname = json['lname'];
    token = json['token'];
    totalSalary = json['totalSalary'];
    branches = json['branches'].cast<String>();
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'id': id,
      'phone': phone,
      'fname': fname,
      'lname': lname,
      'token': token,
      'totalSalary': totalSalary,
      'branches': branches,
    };
  }
}