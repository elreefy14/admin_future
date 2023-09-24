import 'package:cloud_firestore/cloud_firestore.dart';

class SchedulesModel {

  String? branchId;
  Timestamp? startTime;
  Timestamp? endTime;
  Timestamp? nearestDay;
  String? date;

  bool? finished;
  List<String>? usersList;
  List<String>? userIds; // new field
  String? scheduleId;
  String? pId;

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
  });

  Map<String, dynamic> toJson2() {
    return {
      'branch_id': branchId,
      'start_time': startTime,
      'end_time': endTime,
      'finished': finished,
      'usersList': usersList,
      'userIds': userIds, // new field
      'nearestDay': nearestDay,
      'schedule_id': scheduleId,
      'date': date,
      'pId': pId,
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
      'nearestDay': nearestDay,
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
      nearestDay: json['nearestDay'],
      scheduleId: json['schedule_id'],
      date: json['date'],
    );
  }

  factory SchedulesModel.fromJson(Map<String, dynamic> json) {
    return SchedulesModel(
      pId: json['pId'],
      branchId: json['branch_id'],
      nearestDay: json['nearestDay'] != null ? Timestamp.fromMillisecondsSinceEpoch((json['nearestDay'] as Timestamp).millisecondsSinceEpoch) : null,
      startTime: json['start_time'] != null ? Timestamp.fromMillisecondsSinceEpoch(DateTime.parse(json['start_time']).millisecondsSinceEpoch) : null,
      endTime: json['end_time'] != null ? Timestamp.fromMillisecondsSinceEpoch(DateTime.parse(json['end_time']).millisecondsSinceEpoch) : null,
      finished: json['finished'],
      userIds: json['userIds'] != null ? List<String>.from(json['userIds']) : null, // new field
      scheduleId: json['schedule_id'],
      date: json['date'],
    );
  }
}
