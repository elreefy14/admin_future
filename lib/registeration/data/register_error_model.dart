// //RegisterModel class which parse this json using json_serializable
// // {"status":"success","id":"2"}
// import 'package:json_annotation/json_annotation.dart';
// part 'register_error_model.g.dart';
//
// @JsonSerializable()
// class RegisterErrorModel {
//   // {
//   // "status": false,
//   // "message": "رقم الهاتف الذي قمت بإدخاله مستخدم من قبل",
//   // "data": null
//   // }
//   //parse json to RegisterErrorModel class using json_serializable
//   bool? status;
//   String? message;
//   dynamic data;
//   RegisterErrorModel({
//     required this.status,
//     required this.message,
//     required this.data,
//   });
//   factory RegisterErrorModel.fromJson(Map<String, dynamic> json) =>
//       _$RegisterErrorModelFromJson(json);
//   Map<String, dynamic> toJson() => _$RegisterErrorModelToJson(this);
//
//
// }
//
//
