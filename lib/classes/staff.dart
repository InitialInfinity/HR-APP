import 'dart:io';

class Staff {
  String id = "";
  String companyId = "";
  String empId = "";
  String staffName = "";
  String emailId = "";
  String designation = "";
  String address = "";
  String basic_Salary = "1";
  String contact_No = "";
  String userId = "";
  String date = "";
  String month = "";
  String year = "";
  String inTime = "";
  String outTime = "";
  String inlatlong = "";
  String outLatLong = "";
  String status = "";
  String pfNo = "";
  String accountNo = "";
  String esicNo = "";
  String dob = "";
  String doj = "";
  String workingHours = "";
  String exitDate = "";
  String type = "";

  Staff({
    this.id = "",
    this.companyId = "",
    this.empId = "",
    this.staffName = "",
    this.emailId = "",
    this.designation = "",
    this.address = "",
    this.basic_Salary = "",
    this.contact_No = "",
    this.userId = "",
    this.date = "",
    this.month = "",
    this.year = "",
    this.inTime = "",
    this.outTime = "",
    this.inlatlong = "",
    this.outLatLong = "",
    this.status = "",
    this.pfNo = "",
    this.accountNo = "",
    this.esicNo = "",
    this.dob = "",
    this.doj = "",
    this.workingHours = "",
    this.exitDate = "",
    this.type = "",
  });

  factory Staff.fromJson(Map<String, dynamic> json) {
    return Staff(
      id: json['id'],
      companyId: json['companyId'],
      empId: json['EmpId'],
      staffName: json['staffName'],
      emailId: json['emailId'],
      designation: json['designation'],
      basic_Salary: json['basic_Salary'],
      contact_No: json['contact_No'],
      userId: json['UserId'],
      date: json['Date'],
      month: json['Month'],
      year: json['Year'],
      inTime: json['InTime'],
      outTime: json['OutTime'],
      inlatlong: json['InLatLong'],
      outLatLong: json['OutLatLong'],
      status: json['Status'],
      pfNo: json['Pf_No'],
      accountNo: json['Acc_No'],
      esicNo: json['ESIC_No'],
      dob: json['DOB'],
      doj: json['DateOfJoining'],
      workingHours: json['WorkingHours'],
      exitDate: json['ExitDate'],
      type: json['type'],
    );
  }
}
