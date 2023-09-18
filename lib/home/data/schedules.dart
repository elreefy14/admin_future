// SchedulesModel schedulesModel = SchedulesModel(
//   coachId: 'coachId',
//   branchId: 'branchId',
//   startTime: 'startTime',
//   endTime: 'endTime',
//   date: 'date',
//   finished: false,
// );
import 'package:cloud_firestore/cloud_firestore.dart';



class SchedulesModel {

  String? branchId;
  Timestamp? startTime;
  Timestamp? endTime;
  String? date;

  bool? finished;
  List<String>? usersList;
  String? scheduleId;

  SchedulesModel({

    required this.branchId,
    required this.startTime,
    required this.endTime,

    required this.finished,
    this.usersList,
    this.scheduleId,
    this.date,
  });
  Map<String, dynamic> toJson2() {
    return {
      'branch_id': branchId,
      'start_time': startTime,
      'end_time': endTime,
      'finished': finished,
      'usersList': usersList,
      'schedule_id': scheduleId,
      'date': date,
    };
  }

  //to json function
  Map<String, dynamic> toJson() {
    return {
      'branch_id': branchId,
      'start_time': startTime?.toDate().toIso8601String(),
      'end_time': endTime?.toDate().toIso8601String(),
      'finished': finished,
      'schedule_id': scheduleId,
      'date': date,
    };
  }

factory SchedulesModel.fromJson2(Map<String, dynamic> json) {
    return SchedulesModel(
//       branch_id "edasdas"
//       coach_id "awak4gIQ28SdtDYLJIEF9phS20p2"
//       date May 13, 2023 at 11:57:01 PM UTC+2
//       end_time May 13, 2023 at 11:57:01 PM UTC+2
//       finished false
//       start_time May 13, 2023 at 11:57:01 PM UTC+2
      branchId: json['branch_id'],
      startTime: json['start_time'],
      endTime: json['end_time'],

      finished: json['finished'],
       usersList: json['usersList'] != null ? List<String>.from(json['usersList']) : null,
       scheduleId: json['schedule_id'],
      date: json['date'],
    );
  }

  //from json function
//from json function
  factory SchedulesModel.fromJson(Map<String, dynamic> json) {
    return SchedulesModel(
      branchId: json['branch_id'],
      startTime: json['start_time'] != null ? Timestamp.fromMillisecondsSinceEpoch(DateTime.parse(json['start_time']).millisecondsSinceEpoch) : null,
      endTime: json['end_time'] != null ? Timestamp.fromMillisecondsSinceEpoch(DateTime.parse(json['end_time']).millisecondsSinceEpoch) : null,
      finished: json['finished'],
      scheduleId: json['schedule_id'],
      date: json['date'],
    );
  }


}
