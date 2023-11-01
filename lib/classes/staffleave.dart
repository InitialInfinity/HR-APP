class StaffLeave {
  String userId = "";
  String companyId = "";
  String staffId = "";
  String leaveType = "";
  String fromDate = "";
  String toDate = "";

  String leaveReason = "";
  String noOfDays = "1";
  String contactNo = "";

  StaffLeave({
    this.userId = "",
    this.companyId = "",
    this.staffId = "",
    this.leaveType = "",
    this.fromDate = "",
    this.toDate = "",
    this.leaveReason = "",
    this.noOfDays = "",
    this.contactNo = "",
  });

  factory StaffLeave.fromJson(Map<String, dynamic> json) {
    return StaffLeave(
      userId: json['userId'],
      companyId: json['companyId'],
      staffId: json['staffId'],
      leaveType: json['leaveType'],
      leaveReason: json['leaveReason'],
      fromDate: json['fromDate'],
      toDate: json['toDate'],
      noOfDays: json['noOfDays'],
      contactNo: json['contactNo'],
    );
  }
}
