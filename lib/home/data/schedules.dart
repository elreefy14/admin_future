import 'package:admin_future/registeration/data/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SchedulesModel {

  String? branchId;
  Timestamp? startTime;
  Timestamp? endTime;
  Timestamp? nearestDay;
  String? date;

  bool? finished;
  List<String?>? usersList;
  List<String?>? userIds; // new field
  String? scheduleId;
  String? pId;
//maxUsers
  String? maxUsers;
  List<UserModel>? users;
  SchedulesModel({
    required this.pId,
    required this.branchId,
    required this.startTime,
    required this.endTime,
    required this.finished,
    this.usersList,
    this.userIds, // new field
    this.scheduleId,
    this.date, 
    required this.nearestDay, 
    List<UserModel>? users, this.maxUsers,
  });

  Map<String, dynamic> toJson2() {
    return {
      'branch_id': branchId,
      'start_time': startTime,
      'end_time': endTime,
      'finished': finished,
      'usersList': usersList,
      'userIds': userIds, // new field
      'nearest_day': nearestDay,
      'schedule_id': scheduleId,
      'date': date,
      'pId': pId,
      'users': users,
      'maxUsers': maxUsers,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'pId': pId,
      'branch_id': branchId,
      'start_time': startTime?.toDate().toIso8601String(),
      'end_time': endTime?.toDate().toIso8601String(),
      'finished': finished,
      'userIds': userIds, // new field
      'schedule_id': scheduleId,
      'date': date,
      'nearest_day': nearestDay,
      'users': users,
      'maxUsers': maxUsers,
    };
  }

  factory SchedulesModel.fromJson2(Map<String, dynamic> json) {
    return SchedulesModel(
      branchId: json['branch_id'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      pId: json['pId'],
      finished: json['finished'],
      usersList: json['usersList'] != null ? List<String>.from(json['usersList']) : null,
      userIds: json['userIds'] != null ? List<String>.from(json['userIds']) : null, // new field
      nearestDay: json['nearest_day'],
      scheduleId: json['schedule_id'],
      date: json['date'],
      users: json['users'] != null ? List<UserModel>.from(json['users'].map((x) => UserModel.fromJson(x))) : null,
      maxUsers: json['maxUsers'],
    );
  }

  factory SchedulesModel.fromJson(Map<String, dynamic> json) {
    return SchedulesModel(
      pId: json['pId'],
      branchId: json['branch_id'],
      nearestDay: json['nearest_day'] != null ? Timestamp.fromMillisecondsSinceEpoch((json['nearestDay'] as Timestamp).millisecondsSinceEpoch) : null,
      startTime: json['start_time'] != null ? Timestamp.fromMillisecondsSinceEpoch(DateTime.parse(json['start_time']).millisecondsSinceEpoch) : null,
      endTime: json['end_time'] != null ? Timestamp.fromMillisecondsSinceEpoch(DateTime.parse(json['end_time']).millisecondsSinceEpoch) : null,
      finished: json['finished'],
      userIds: json['userIds'] != null ? List<String>.from(json['userIds']) : null, // new field
      scheduleId: json['schedule_id'],
      date: json['date'],
      users: json['users'] != null ? List<UserModel>.from(json['users'].map((x) => UserModel.fromJson(x))) : null,
      maxUsers: json['maxUsers'],
    );
  }
}
