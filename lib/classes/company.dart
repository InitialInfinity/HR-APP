import 'dart:io';

class Company {
  String comapanyName = "";
  String id = "";
  File? companylogo;
  String addressline = "";
  String contactNo = "";
  String longitude = "";
  String latitude = "1";
  String userId = "";
  String emailId = "";
  String isPF = "";
  String isESIC = "";
  String isOvertime = "";

  Company({
    this.comapanyName = "",
    this.id = "",
    this.companylogo,
    this.addressline = "",
    this.contactNo = "",
    this.longitude = "",
    this.latitude = "",
    this.userId = "",
    this.emailId = "",
    this.isPF = "",
    this.isESIC = "",
    this.isOvertime = "",
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      comapanyName: json['CompanyName'],
      id: json['Id'],
      companylogo: json['CompanyLogo'],
      addressline: json['Address_line'],
      contactNo: json['ContactNo'],
      longitude: json['Longitude'],
      latitude: json['Lattitude'],
      userId: json['UserId'],
      emailId: json['EmailId'],
      isPF: json['IsPf'],
      isESIC: json['IsESIC'],
      isOvertime: json['IsOvertime'],
    );
  }
}
