class Attendance {
  String userId = "";
  String companyId = "";
  String staffId = "";
  String date = "";
  String month = "";
  String year = "";
  String inTime = "";
  String inLatLong = "1";
  String status = "";

  Attendance({
    this.userId = "",
    this.companyId = "",
    this.staffId = "",
    this.date = "",
    this.month = "",
    this.year = "",
    this.inTime = "",
    this.inLatLong = "",
    this.status = "",
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      userId: json['userId'],
      companyId: json['CompanyId'],
      staffId: json['StaffId'],
      date: json['Date'],
      month: json['Month'],
      year: json['Year'],
      inTime: json['InTime'],
      inLatLong: json['InLatLong'],
      status: json['Status'],
    );
  }
}
