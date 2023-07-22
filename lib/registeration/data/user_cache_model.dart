class UserCacheModel {
   String? token;
   String? uId;
   String? email;
   String? name;
   String? phone;
   String? image;
   int? level;
   int? hourlyRate;
   int? totalHours;
   int? totalSalary;
   int? currentMonthHours;
   int? currentMonthSalary;
   String? fname;
   String? lname;
   String? role;
//list of strings contain branches names
  List<String>? branches;
  UserCacheModel({

   this.token,
   this.uId,
   this.email,
   this.name,
   this.phone,
   this.level,
   this.hourlyRate,
   this.totalHours,
   this.totalSalary,
   this.currentMonthHours,
   this.currentMonthSalary,
    this.image,
    this.fname,
    this.lname,
    this.branches,
    this.role,
  });

  factory UserCacheModel.fromJson(Map<String, dynamic> json) {
    return UserCacheModel(
      fname: json['fname'],
      lname: json['lname'],
      token: json['token'],
      uId: json['uid'],
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
      level: json['level'],
      hourlyRate: json['hourly_rate'],
      totalHours: json['total_hours'],
      totalSalary: json['total_salary'],
      currentMonthHours: json['current_month_hours'],
      currentMonthSalary: json['current_month_salary'],
      image: json['image'],
      branches: json['branches'] != null ? List<String>.from(json['branches']) : null,
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() => {
    'fname': fname,
    'lname': lname,
    'image': image,
    'token': token,
    'uid': uId,
    'email': email,
    'name': name,
    'phone': phone,
    'level': level,
    'hourly_rate': hourlyRate,
    'total_hours': totalHours,
    'total_salary': totalSalary,
    'current_month_hours': currentMonthHours,
    'current_month_salary': currentMonthSalary,
    'branches': branches,
    'role': role,
  };
}