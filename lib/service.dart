import 'dart:io';
import 'package:get/get.dart';
import 'package:hr/login.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'classes/company.dart';
import 'classes/salary.dart';
import 'classes/shift.dart';
import 'classes/staff.dart';
import 'classes/staffleave.dart';
import 'constant.dart';

class Service extends GetConnect {
  static String baseURL = "https://hrms.initialinfinity.com/api";
  static File? image1;
  static RxBool isLoading = false.obs;
  static final showPass = false.obs;

  static RxString role = "".obs;
  static DateTime dateFrom = DateTime.now();
  static DateTime dateTo = DateTime.now();
  static const FlutterSecureStorage storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );
  static Future<dynamic> login(
      String mobile, String password, String role) async {
    var response = await http.post(
      Uri.parse("$baseURL/Login"),
      headers: {
        "Content-Type": 'application/json',
      },
      body: convert.jsonEncode({
        "CONTACTNO": mobile,
        "PASSWORD": password,
        "ROLE": role,
      }),
    );

    var resp = convert.jsonDecode(response.body);

    return resp;
  }

  static Future<dynamic> logout() async {
    String? token = await Service.getToken();
    var id = await getId();
    var loginid = await getLoginId();

    var response = await http.post(
      Uri.parse("$baseURL/Login/LogOut"),
      headers: {
        "Content-Type": "application/json",
      },
      body: convert.jsonEncode({
        "id": id.toString(),
        "LoginId": loginid.toString(),
      }),
    );
    var resp = convert.jsonDecode(response.body);
    Get.offAll(() => const LoginPage());
    return resp;
  }

  static Future<dynamic> forgotPassword(String contactNo, String role) async {
    String? token = await Service.getToken();
    var id = await getId();

    var response = await http.post(
      Uri.parse("$baseURL/Login/ForgotPassword"),
      headers: {
        "Content-Type": "application/json",
      },
      body:
          convert.jsonEncode({"contactNo": contactNo.toString(), "role": role}),
    );
    var resp = convert.jsonDecode(response.body);

    return resp;
  }

  static Future<dynamic> newPassword(String contactNo, String password,
      String newPassword, String role) async {
    var id = await getId();

    var response = await http.post(
      Uri.parse("$baseURL/Login/ResetPassword"),
      headers: {
        "Content-Type": "application/json",
      },
      body: convert.jsonEncode({
        "Id": id.toString(),
        "ContactNo": contactNo.toString(),
        "Password": password.toString(),
        "NewPassword": newPassword.toString(),
        "Role": role.toString() //STAFF
      }),
    );
    var resp = convert.jsonDecode(response.body);

    return resp;
  }

  static Future<String?> getId() async {
    return await storage.read(key: 'id');
  }

  static Future<String?> getUserId() async {
    return await storage.read(key: 'userId');
  }

  static Future<String?> getAttendanceId() async {
    return await storage.read(key: 'attendanceId');
  }

  static Future<String?> getCompanyId() async {
    return await storage.read(key: 'companyId');
  }

  static Future<String?> getToken() async {
    return await Service.storage.read(key: 'token');
  }

  static Future<String?> getLoginId() async {
    return await Service.storage.read(key: 'loginId');
  }

  //Company
  static updateCompanyImage(Company company) async {
    String? token = await Service.getToken();
    var userId = await getId();

    company.userId = userId.toString();
    company.id = userId.toString();
    var map = <String, String>{};
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    map['UserId'] = company.userId;

    var request =
        http.MultipartRequest('POST', Uri.parse("$baseURL/Company/EditImage"))
          ..fields.addAll(map);
    request.headers.addAll(headers);
    request.files.add(
      await http.MultipartFile.fromPath(
          'CompanyLogo', company.companylogo!.path),
    );

    var response = await http.Response.fromStream(
      await request.send(),
    );
    var resp = convert.jsonDecode(response.body);

    return resp;
  }

  static updateCompany(Company company) async {
    String? token = await Service.getToken();
    var userId = await getId();

    company.userId = userId.toString();
    company.id = userId.toString();
    var map = <String, String>{};
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    map['CompanyName'] = company.comapanyName;
    map['Id'] = company.id;
    // map['CompanyLogo'] = company.companylogo!.path;
    map['Address_line'] = company.addressline;
    map['ContactNo'] = company.contactNo;
    map['Longitude'] = company.longitude;
    map['Lattitude'] = company.latitude;
    map['UserId'] = company.userId;
    map['EmailId'] = company.emailId;
    map['IsPf'] = company.isPF;
    map['IsESIC'] = company.isESIC;
    map['IsOvertime'] = company.isOvertime;
    var request = http.MultipartRequest(
        'POST', Uri.parse("$baseURL/Company/UpdateCompany"))
      ..fields.addAll(map);
    request.headers.addAll(headers);
    // request.files.add(
    //   await http.MultipartFile.fromPath(
    //       'CompanyLogo', company.companylogo!.path),
    // );

    var response = await http.Response.fromStream(
      await request.send(),
    );
    var resp = convert.jsonDecode(response.body);
    // if (response.statusCode == 200) {
    //   await storage.write(
    //       key: 'token', value: resp["result"]["outcome"]["tokens"].toString());

    //   return resp;
    // }
    // print(resp);
    return resp;
  }

  static registerCompany(Company company) async {
    String? token = await Service.getToken();
    var userId = await getId();

    var map = <String, String>{};
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    map['CompanyName'] = company.comapanyName;
    map['CompanyLogo'] = company.companylogo!.path;
    map['Address_line'] = company.addressline;
    map['ContactNo'] = company.contactNo;
    map['Longitude'] = company.longitude;
    map['Lattitude'] = company.latitude;
    map['EmailId'] = company.emailId;
    map['IsPf'] = company.isPF;
    map['IsESIC'] = company.isESIC;
    map['IsOvertime'] = company.isOvertime;

    var request =
        http.MultipartRequest('POST', Uri.parse("$baseURL/Registration"))
          ..fields.addAll(map);
    request.headers.addAll(headers);
    request.files.add(
      await http.MultipartFile.fromPath(
          'CompanyLogo', company.companylogo!.path),
    );

    var response = await http.Response.fromStream(
      await request.send(),
    );
    var resp = convert.jsonDecode(response.body);
    // if (response.statusCode == 200) {
    //   await storage.write(w f
    //       key: 'token', value: resp["result"]["outcome"]["tokens"].toString());

    //   return resp;
    // }
    // print(resp);
    return resp;
  }

  static Future<dynamic> getUpdatedCompanyProfileImage() async {
    String? token = await Service.getToken();
    var userid = await getId();
    var response = await http.get(
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
      Uri.parse("$baseURL/Company/GetImage?UserId=$userid"),
    );
    var resp = convert.jsonDecode(response.body);

    return resp;
  }

  static Future<dynamic> getCompanyProfile() async {
    String? token = await Service.getToken();
    var userid = await getId();
    var response = await http.get(
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
      Uri.parse("$baseURL/Company/GetCompany?UserId=$userid"),
    );
    var resp = convert.jsonDecode(response.body);

    return resp;
  }

  static Future<dynamic> deleteCompany() async {
    String? token = await Service.getToken();
    var userId = await Service.getId();
    var response = await http.post(
      Uri.parse("$baseURL/Company/Delete"),
      headers: {
        "Content-Type": "application/json",
      },
      body: convert.jsonEncode(
        <String, String>{
          "userId": userId.toString(),
          "id": userId.toString(),
        },
      ),
    );
    var json = convert.jsonDecode(response.body);
    if (json["outcome"]["outcomeId"] == 1) {
      flutterToastMsg(json["outcome"]["outcomeDetail"]);
      Get.offAll(() => const LoginPage());
    }
    return json;
  }

  static Future<dynamic> addStaffForCompany(Staff staff) async {
    String? token = await Service.getToken();
    var userId = await Service.getId();
    var response = await http.post(
      Uri.parse("$baseURL/AdminStaff"),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: convert.jsonEncode(
        <String, String>{
          "companyId": userId.toString(),
          "staffName": staff.staffName,
          "emailId": staff.emailId,
          "EmpId": staff.empId,
          "designation": staff.designation,
          "address": staff.address,
          "basic_Salary": staff.basic_Salary,
          "contact_No": staff.contact_No,
          "userId": userId.toString(),
          "ESIC_No": staff.esicNo,
          "Pf_No": staff.pfNo,
          "Acc_No": staff.accountNo,
          "DOB": staff.dob,
          "DateOfJoining": staff.doj,
          "ExitDate": staff.exitDate,
          "WorkingHours": staff.workingHours,
          "ShiftId": "cafb651d-3c6b-4ad8-bfb8-e22093f7538f"
        },
      ),
    );
    var json = convert.jsonDecode(response.body);

    return json;
  }

  static Future<dynamic> updateStaffForCompany(Staff staff) async {
    String? token = await Service.getToken();
    var userId = await Service.getId();
    var response = await http.post(
      Uri.parse("$baseURL/AdminStaff/EditStaff"),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: convert.jsonEncode(
        <String, String>{
          "id": staff.id,
          "companyId": userId.toString(),
          "staffName": staff.staffName,
          "emailId": staff.emailId,
          "designation": staff.designation,
          "address": staff.address,
          "basic_Salary": staff.basic_Salary,
          "contact_No": staff.contact_No,
          "userId": userId.toString(),
          "ESIC_No": staff.esicNo,
          "Pf_No": staff.pfNo,
          "Acc_No": staff.accountNo,
          "DOB": staff.dob,
          "DateOfJoining": staff.doj,
          "ExitDate": staff.exitDate,
          "WorkingHours": staff.workingHours,
        },
      ),
    );
    var json = convert.jsonDecode(response.body);

    return json;
  }

  static Future<dynamic> getAllStaff() async {
    String? token = await Service.getToken();
    var userid = await getId();
    // var id = userid!.substring(1, userid.length - 1);
    var response = await http.get(
      headers: {
        "Content-Type": "application/json",
      },
      Uri.parse(
          "$baseURL/AdminStaff/GetAllStaff?UserId=$userid&CompanyId=$userid"),
    );
    var resp = convert.jsonDecode(response.body);

    return resp;
  }

  static Future<dynamic> deleteStaff(String staffId) async {
    String? token = await Service.getToken();
    var userId = await getId();
    var response = await http.post(
      Uri.parse("$baseURL/AdminStaff/DeleteStaff"),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: convert.jsonEncode(
        <String, String>{
          "userId": userId.toString(),
          "CompanyId": userId.toString(),
          "id": staffId.toString(),
        },
      ),
    );
    var resp = convert.jsonDecode(response.body);
    return resp;
  }

  //add week off company
  static Future<dynamic> addWeekOff(
      String weekofFirst, String weekOffSecond) async {
    var userId = await getId();

    var response = await http.post(
      Uri.parse("$baseURL/HolidaysAndWeekoff/WeekOff"),
      headers: {
        "Content-Type": "application/json",
      },
      body: convert.jsonEncode(
        <String, String>{
          // "id": "54C0012B-A30F-4CEE-9A19-A609148A5C00",
          "userId": userId.toString(),
          "companyId": userId.toString(),
          "weekOff_First": weekofFirst.toString(),
          "weekOff_Second": weekOffSecond.toString()
        },
      ),
    );
    var resp = convert.jsonDecode(response.body);

    return resp;
  }

  static Future<dynamic> updateWeekOff(
      String weekofFirst, String weekOffSecond, String weekoffid) async {
    var userId = await getId();
    String? token = await Service.getToken();
    var response = await http.post(
      Uri.parse("$baseURL/HolidaysAndWeekoff/WeekOff"),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: convert.jsonEncode(
        <String, String>{
          "id": weekoffid.toString(),
          "userId": userId.toString(),
          "companyId": userId.toString(),
          "weekOff_First": weekofFirst.toString(),
          "weekOff_Second": weekOffSecond.toString()
        },
      ),
    );
    var resp = convert.jsonDecode(response.body);

    return resp;
  }

  static Future<dynamic> getWeekOff() async {
    String? token = await Service.getToken();
    var userid = await getId();
    // var id = userid!.substring(1, userid.length - 1);
    var response = await http.get(
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
      Uri.parse(
          "$baseURL/HolidaysAndWeekoff/GetAllWeekoff?UserId=$userid&CompanyId=$userid"),
    );
    var resp = convert.jsonDecode(response.body);

    return resp;
  }

  static Future<dynamic> deleteWeekOff(String leaveid) async {
    String? token = await Service.getToken();
    var ID = await Service.getId();
    var response = await http.post(
      Uri.parse("$baseURL/HolidaysAndWeekoff/DeleteWeekOff"),
      headers: {
        "Content-Type": "application/json",
      },
      body: convert.jsonEncode(
        <String, String>{
          "userId": ID.toString(),
          "Id": leaveid.toString(),
          "CompanyId": ID.toString(),
        },
      ),
    );
    var resp = convert.jsonDecode(response.body);

    return resp;
  }

  //Add Holiday
  static Future<dynamic> addHoliday(String date, String description) async {
    var userid = await getId();
    var response = await http.post(
      Uri.parse(
          "https://hrms.initialinfinity.com/api/HolidaysAndWeekoff/Holiday"),
      headers: {
        "Content-Type": "application/json",
      },
      body: convert.jsonEncode(
        <String, String>{
          "userId": userid.toString(),
          "companyId": userid.toString(),
          "date": date.toString(),
          "description": description.toString()
          // "userId": "44a05df9-e259-4fca-8bc6-23a3abfe4ca1",
          // "companyId": "44a05df9-e259-4fca-8bc6-23a3abfe4ca1",
          // "date": "15-09-2023",
          // "description": "Abc"
        },
      ),
    );
    var resp = convert.jsonDecode(response.body);

    return resp;
  }

  static Future<dynamic> updateHoliday(
      String date, String description, String id) async {
    var userid = await getId();
    var response = await http.post(
      Uri.parse(
          "https://hrms.initialinfinity.com/api/HolidaysAndWeekoff/Holiday"),
      headers: {
        "Content-Type": "application/json",
      },
      body: convert.jsonEncode(
        <String, String>{
          "id": id.toString(),
          "userId": userid.toString(),
          "companyId": userid.toString(),
          "date": date.toString(),
          "description": description.toString()
          // "userId": "44a05df9-e259-4fca-8bc6-23a3abfe4ca1",
          // "companyId": "44a05df9-e259-4fca-8bc6-23a3abfe4ca1",
          // "date": "15-09-2023",
          // "description": "Abc"
        },
      ),
    );
    var resp = convert.jsonDecode(response.body);

    return resp;
  }

  static Future<dynamic> getHolidays() async {
    String? token = await Service.getToken();
    var userid = await getId();
    // var id = userid!.substring(1, userid.length - 1);
    var response = await http.get(
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      Uri.parse(
          "$baseURL/HolidaysAndWeekoff/GetAllHoliday?UserId=$userid&CompanyId=$userid"),
    );
    var resp = convert.jsonDecode(response.body);

    return resp;
  }

  static Future<dynamic> deleteHoliday(String leaveid) async {
    String? token = await Service.getToken();
    var id = await Service.getId();
    var response = await http.post(
      Uri.parse("$baseURL/HolidaysAndWeekoff/DeleteHoliday"),
      headers: {
        "Content-Type": "application/json",
      },
      body: convert.jsonEncode(
        <String, String>{
          "userId": id.toString(),
          "Id": leaveid.toString(),
          "CompanyId": id.toString()
        },
      ),
    );
    var resp = convert.jsonDecode(response.body);

    return resp;
  }

  //dashboard
  static Future<dynamic> getDashboard() async {
    String? token = await Service.getToken();
    var userid = await getId();
    // var id = userid!.substring(1, userid.length - 1);
    var response = await http.get(
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
      Uri.parse(
          "$baseURL/Report/GetDashBoard?userId=$userid&CompanyId=$userid"),
    );
    var resp = convert.jsonDecode(response.body);
    return resp;
  }

  //report
  static Future<dynamic> getAttendanceReportOfYear() async {
    String? token = await Service.getToken();
    var userid = await getId();
    // var id = userid!.substring(1, userid.length - 1);
    var response = await http.get(
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      Uri.parse(
          "$baseURL/Report/GetAttendenceReport?userId=$userid&CompanyId=$userid"),
    );
    var resp = convert.jsonDecode(response.body);

    return resp;
  }

  static Future<dynamic> getAttendanceReportOfMonth(
      String month, String year) async {
    String? token = await Service.getToken();
    var userid = await getId();
    // var id = userid!.substring(1, userid.length - 1);
    var response = await http.get(
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      Uri.parse(
          "$baseURL/pdf/GetAttendenceReportByMonth?userId=$userid&CompanyId=$userid&Month=$month&Year=$year"),
    );
    var resp = convert.jsonDecode(response.body);

    return resp;
  }

  static Future<dynamic> getLeaveReportYearly() async {
    String? token = await Service.getToken();
    var userid = await getId();
    // var id = userid!.substring(1, userid.length - 1);
    var response = await http.get(
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
      Uri.parse(
          "$baseURL/Report/GetLeaveReport?userId=$userid&CompanyId=$userid"),
    );
    var resp = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      await storage.write(
          key: 'token', value: resp["result"]["outcome"]["tokens"].toString());

      return resp;
    }
    return resp;
  }

  static Future<dynamic> getLeaveReportMonthly(String month) async {
    String? token = await Service.getToken();
    var userid = await getId();
    // var id = userid!.substring(1, userid.length - 1);
    var response = await http.get(
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      Uri.parse(
          "$baseURL/pdf/GetLeaveReportByMonth?userId=$userid&CompanyId=$userid&Month=$month"),
    );
    var resp = convert.jsonDecode(response.body);

    return resp;
  }

  //salary slip
  static Future<dynamic> getStaff() async {
    String? token = await Service.getToken();
    var userid = await getId();
    // var id = userid!.substring(1, userid.length - 1);
    var response = await http.get(
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      Uri.parse(
          "$baseURL/SalarySlip/GetStaff?userId=$userid&CompanyId=$userid"),
    );
    var resp = convert.jsonDecode(response.body);

    return resp;
  }

  static Future<dynamic> getStaffSalaryDFByMonth(
      String month, String year) async {
    var userid = await getId();
    var companyid = await getCompanyId();

    // var id = userid!.substring(1, userid.length - 1);
    var response = await http.get(
        headers: {
          "Content-Type": "application/json",
        },
        Uri.parse(
            "$baseURL/SlipPDF/StaffSalarySlipPDF?userId=$userid&CompanyId=$companyid&Month=$month&Year=$year&StaffId=$userid"));
    var resp = convert.jsonDecode(response.body);

    return resp;
  }

  static Future<dynamic> getStaffById() async {
    String? token = await Service.getToken();
    var userid = await getId();
    var companyid = await getCompanyId();

    // var id = userid!.substring(1, userid.length - 1);
    var response = await http.get(
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      Uri.parse(
          "$baseURL/AdminStaff/GetStaffById?UserId=$userid&CompanyId=$companyid&Id=$userid"),
    );
    var resp = convert.jsonDecode(response.body);

    return resp;
  }

  static Future<dynamic> getBasicSalary(String staffId) async {
    String? token = await Service.getToken();
    var userid = await getId();
    // var id = userid!.substring(1, userid.length - 1);
    var response = await http.get(
      headers: {
        "Content-Type": "application/json",
      },
      Uri.parse(
          "$baseURL/SalarySlip/GetBasicSalary?userId=$userid&CompanyId=$userid&StaffId=$staffId"),
    );
    var resp = convert.jsonDecode(response.body);

    return resp;
  }

  static Future<dynamic> getPresentDays(
      String staffId, String month, String year) async {
    String? token = await Service.getToken();
    var userid = await getId();
    // var id = userid!.substring(1, userid.length - 1);
    month = DateFormat.M().format(DateTime.now());
    var response = await http.get(
      headers: {
        "Content-Type": "application/json",
      },
      Uri.parse(
          "$baseURL/SalarySlip/GetPresentCount?StaffId=$staffId&userId=$userid&CompanyId=$userid&Month=$month&Year=$year"),
    );
    var resp = convert.jsonDecode(response.body);

    return resp;
  }

  static Future<dynamic> getSalarySlipById(String staffId) async {
    String? token = await Service.getToken();
    var userid = await getId();

    var response = await http.get(
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      Uri.parse(
          "$baseURL/SalarySlip/GetSalarySlipById?userId=$userid&CompanyId=$userid&Id=$staffId"),

      ///SalarySlip/GetSalarySlipById?userId=$userid&CompanyId=$userid&Id=cb55f03e-5806-49fc-b6c6-e858535bf999
    );
    var resp = convert.jsonDecode(response.body);

    return resp;
  }

  static Future<dynamic> getAllSalarySlip(String month, String year) async {
    String? token = await Service.getToken();
    var userid = await getId();

    var response = await http.get(
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      Uri.parse(
          "$baseURL/SalarySlip/GetSalarySlip?userId=$userid&CompanyId=$userid&Month=$month&Year=$year"),

      ///SalarySlip/GetSalarySlipById?userId=$userid&CompanyId=$userid&Id=cb55f03e-5806-49fc-b6c6-e858535bf999
    );
    var resp = convert.jsonDecode(response.body);

    return resp;
  }

  static Future<dynamic> addSalarySLip(Salary salary) async {
    String? token = await Service.getToken();
    var userId = await getId();
    var response = await http.post(
      Uri.parse("$baseURL/SalarySlip"),
      headers: {
        "Content-Type": "application/json",
      },
      body: convert.jsonEncode(
        <String, dynamic>{
          "userId": userId.toString(),
          "CompanyId": userId.toString(),
          "StaffId": salary.staffId,
          "basic_Salary": salary.basicSalary,
          "tax": salary.tax,
          "bonus": salary.bonus,
          "otherAllowance": salary.otherAllowance,
          "month": salary.month,
          "Year": salary.year,
          "PresentDays": salary.presentdays,
          "PF_Amt": salary.pfAmount,
          "ESIC_AMT": salary.esicAmount,
          "Overtime": salary.overtime,
          "Overtime_Per_hrs": salary.overtimePerHour.toString()
        },
      ),
    );
    var resp = convert.jsonDecode(response.body);

    return resp;
  }

  static Future<dynamic> updateSalarySLip(Salary salary) async {
    String? token = await Service.getToken();
    var userId = await getId();
    var response = await http.post(
      Uri.parse("$baseURL/SalarySlip"),
      headers: {
        "Content-Type": "application/json",
      },
      body: convert.jsonEncode(
        <String, dynamic>{
          "Id": salary.id,
          "userId": userId.toString(),
          "CompanyId": userId.toString(),
          "StaffId": salary.staffId,
          "basic_Salary": salary.basicSalary,
          "tax": salary.tax,
          "bonus": salary.bonus,
          "otherAllowance": salary.otherAllowance,
          "month": salary.month,
          "Year": salary.year,
          "PresentDays": salary.presentdays,
          "PF_Amt": salary.pfAmount,
          "ESIC_AMT": salary.esicAmount,
          "Overtime": salary.overtime,
          "Overtime_Per_hrs": salary.overtimePerHour
        },
      ),
    );
    var resp = convert.jsonDecode(response.body);

    return resp;
  }

  static Future<dynamic> deleteSalarySLip(String salaryid) async {
    var id = await getId();
    var response = await http.post(
      Uri.parse("$baseURL/SalarySlip/Delete"),
      headers: {
        "Content-Type": "application/json",
      },
      body: convert.jsonEncode(
        <String, String>{
          "id": salaryid.toString(),
          "CompanyId": id.toString(),
          "userId": id.toString(),
        },
      ),
    );
    var resp = convert.jsonDecode(response.body);

    return resp;
  }

  //Add leave
  static Future<dynamic> addLeave(
      String staffId, String sickLeave, String privilegeLeave) async {
    var userid = await getId();
    var response = await http.post(
      Uri.parse("$baseURL/AdminStaff/UpdateLeaves"),
      headers: {
        "Content-Type": "application/json",
      },
      body: convert.jsonEncode(
        <String, String>{
          "id": staffId.toString(), //StaffId
          "companyId": userid.toString(),
          "sickLeaves": sickLeave.toString(),
          "privilegeLeave": privilegeLeave.toString(),
          "userId": userid.toString(),
        },
      ),
    );
    var resp = convert.jsonDecode(response.body);

    return resp;
  }

  static Future<dynamic> updateLeave(
      String staffId, String sickLeave, String privilegeLeave) async {
    var userid = await getId();
    var response = await http.post(
      Uri.parse("$baseURL/AdminStaff/UpdateLeaves"),
      headers: {
        "Content-Type": "application/json",
      },
      body: convert.jsonEncode(
        <String, String>{
          "id": staffId.toString(), //StaffId
          "companyId": userid.toString(),
          "sickLeaves": sickLeave.toString(),
          "privilegeLeave": privilegeLeave.toString(),
          "userId": userid.toString(),
        },
      ),
    );
    var resp = convert.jsonDecode(response.body);

    return resp;
  }

  static Future<dynamic> getLeaveaddAdmin() async {
    // String? token = await Service.getToken();
    var userid = await getId();

    var response = await http.get(
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      Uri.parse(
          "$baseURL/AdminStaff/GetAllLeaves?UserId=$userid&CompanyId=$userid"),
    );
    var resp = convert.jsonDecode(response.body);

    return resp;
  }

  //add attendance
  static Future<dynamic> addAttendanceStaff(Staff staff) async {
    var userId = await Service.getId();
    var companyId = await Service.getCompanyId();
    var response = await http.post(
      Uri.parse("$baseURL/Attendence"),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: convert.jsonEncode(
        <String, String>{
          "USERID": userId.toString(),
          "COMPANYID": companyId.toString(),
          "STAFFID": userId.toString(),
          "DATE": staff.date.toString(),
          "MONTH": staff.month.toString(),
          "YEAR": staff.year.toString(),
          "INTIME": staff.inTime.toString(),
          "INLATLONG": staff.inlatlong.toString(),
          "type": staff.status.toString(),
          // "type": staff.type.toString(),
        },
      ),
    );
    var json = convert.jsonDecode(response.body);

    return json;
  }

  //update attendance
  static Future<dynamic> updateAttendanceStaff(Staff staff) async {
    var userId = await Service.getId();
    var companyId = await Service.getCompanyId();

    var response = await http.post(
      Uri.parse("$baseURL/Attendence/UpdateAttendence"),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: convert.jsonEncode(
        <String, String>{
          "ID": staff.id.toString(),
          "USERID": userId.toString(),
          "COMPANYID": companyId.toString(),
          "STAFFID": userId.toString(),
          "OUTTIME": staff.outTime.toString(),
          "OUTLATLONG": staff.outLatLong.toString()
        },
      ),
    );
    var json = convert.jsonDecode(response.body);

    return json;
  }

  static Future<dynamic> getAttendanceByDate(String month, String date) async {
    // String? token = await Service.getToken();
    var userid = await getId();
    var companyId = await getCompanyId();

    var response = await http.get(
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      Uri.parse(
          "$baseURL/Attendence/AttendenceByDate?userId=$userid&StaffId=$userid&Month=$month&Date=$date&CompanyId=$companyId"),

      ///SalarySlip/GetSalarySlipById?userId=$userid&CompanyId=$userid&Id=cb55f03e-5806-49fc-b6c6-e858535bf999
    );
    var resp = convert.jsonDecode(response.body);

    return resp;
  }

  ///add staff Leave
  static Future<dynamic> addStaffLeave(StaffLeave staff) async {
    var userId = await Service.getId();
    var companyId = await Service.getCompanyId();
    var response = await http.post(
      Uri.parse("$baseURL/LeaveApplication"),
      headers: {
        "Content-Type": "application/json",
      },
      body: convert.jsonEncode(
        <String, String>{
          "companyId": companyId.toString(),
          "staffId": userId.toString(),
          "leaveType": staff.leaveType,
          "fromDate": staff.fromDate,
          "toDate": staff.toDate,
          "leaveReason": staff.leaveReason,
          "noOfDays": staff.noOfDays,
          "contactNo": staff.contactNo,
          "userId": userId.toString(),
        },
      ),
    );
    var json = convert.jsonDecode(response.body);

    return json;
  }

  static Future<dynamic> getAllLeaveForStaff() async {
    // String? token = await Service.getToken();
    var userid = await getId();
    var companyId = await Service.getCompanyId();

    var response = await http.get(
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      Uri.parse(
          "$baseURL/LeaveApplication/GetAllLeaveDetails?UserId=$userid&CompanyId=$companyId&StaffId=$userid"),
    );
    var resp = convert.jsonDecode(response.body);

    return resp;
  }

  static Future<dynamic> getBalanceLeaveForStaff() async {
    // String? token = await Service.getToken();
    var userid = await getId();
    var companyId = await Service.getCompanyId();

    var response = await http.get(
      headers: {
        "Content-Type": "application/json",
      },
      Uri.parse(
          "$baseURL/StaffDashBoard/GetLeaves?userId=$userid&CompanyId=$companyId"),
    );
    var resp = convert.jsonDecode(response.body);

    return resp;
  }

  ///add shift
  static Future<dynamic> addShift(Shift shift) async {
    var userId = await Service.getId();
    var companyId = await Service.getCompanyId();
    var response = await http.post(
      Uri.parse("$baseURL/ShiftMaster"),
      headers: {
        "Content-Type": "application/json",
      },
      body: convert.jsonEncode(
        <String, String>{
          "userId": userId.toString(),
          "companyId": userId.toString(),
          "shiftName": shift.shiftName,
          "startTime": shift.startTime,
          "endTime": shift.endTime,
          "graceTime": shift.graceTime,
          "halfDayTime": shift.halfDayTime,
          "fullDayTime": shift.fullDayTime,
          "weekOff_First": shift.weekOffFirst,
          "weekOff_Second": shift.weekOffSecond
        },
      ),
    );
    var json = convert.jsonDecode(response.body);

    return json;
  }

  static Future<dynamic> getAllShift() async {
    // String? token = await Service.getToken();
    var userid = await getId();

    var response = await http.get(
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      Uri.parse(
          "$baseURL/ShiftMaster/GetAllShift?UserId=$userid&CompanyId=$userid"),
    );
    var resp = convert.jsonDecode(response.body);

    return resp;
  }

  static Future<dynamic> deleteShift(var id) async {
    var userId = await Service.getId();
    // var companyId = await Service.getCompanyId();
    var response = await http.post(
      Uri.parse("$baseURL/ShiftMaster/DeleteShift"),
      headers: {
        "Content-Type": "application/json",
      },
      body: convert.jsonEncode(
        <String, String>{
          "id": id.toString(),
          "userId": userId.toString(),
          "companyId": userId.toString(),
        },
      ),
    );
    var json = convert.jsonDecode(response.body);

    return json;
  }

  static Future<dynamic> updateShift(Shift shift) async {
    var userId = await Service.getId();
    var companyId = await Service.getCompanyId();
    var response = await http.post(
      Uri.parse("$baseURL/ShiftMaster"),
      headers: {
        "Content-Type": "application/json",
      },
      body: convert.jsonEncode(
        <String, String>{
          "id": shift.id.toString(),
          "userId": userId.toString(),
          "companyId": userId.toString(),
          "shiftName": shift.shiftName,
          "startTime": shift.startTime,
          "endTime": shift.endTime,
          "graceTime": shift.graceTime,
          "halfDayTime": shift.halfDayTime,
          "fullDayTime": shift.fullDayTime,
          "weekOff_First": shift.weekOffFirst,
          "weekOff_Second": shift.weekOffSecond
        },
      ),
    );
    var json = convert.jsonDecode(response.body);

    return json;
  }

  static Future<dynamic> getAdminLeaveDetails() async {
    // String? token = await Service.getToken();
    var userid = await getId();

    var response = await http.get(
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      Uri.parse(
          // "$baseURL/LeaveApplication/GetLeaveDetailsForAdmin?UserId=85B5F7AD-19B0-4B5F-BA2A-5FA1D2AD3FE8&CompanyId=85B5F7AD-19B0-4B5F-BA2A-5FA1D2AD3FE8")
          "$baseURL/LeaveApplication/GetLeaveDetailsForAdmin?UserId=$userid&CompanyId=$userid"),
    );
    var resp = convert.jsonDecode(response.body);

    return resp;
  }

  static Future<dynamic> addLeaveApproval(
      String id, String staffId, String approval, String reason) async {
    var userId = await Service.getId();
    var companyId = await Service.getCompanyId();
    var response = await http.post(
      Uri.parse("$baseURL/LeaveApplication/Approval"),
      headers: {
        "Content-Type": "application/json",
      },
      body: convert.jsonEncode(
        <String, String>{
          "id": id.toString(),
          "companyId": userId.toString(),
          "staffId": staffId.toString(),
          "userId": userId.toString(),
          "approval": approval.toString(),
          "reason": reason.toString()
        },
      ),
    );
    var json = convert.jsonDecode(response.body);

    return json;
  }

  static Future<dynamic> getAllShiftDropDown() async {
    // String? token = await Service.getToke
    // x n();
    var userid = await getId();

    var response = await http.get(
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      Uri.parse(
          // "$baseURL/LeaveApplication/GetLeaveDetailsForAdmin?UserId=85B5F7AD-19B0-4B5F-BA2A-5FA1D2AD3FE8&CompanyId=85B5F7AD-19B0-4B5F-BA2A-5FA1D2AD3FE8")
          "$baseURL/ShiftMaster/DrGetAllShift?UserId=$userid&CompanyId=$userid"),
    );
    var resp = convert.jsonDecode(response.body);

    return resp;
  }

  static Future<dynamic> getBirthday() async {
    // String? token = await Service.getToken();
    var userid = await getId();

    var response = await http.get(
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      Uri.parse(
          "$baseURL/DefineReport/GetBirthday?userId=$userid&CompanyId=$userid"),
    );
    var resp = convert.jsonDecode(response.body);

    return resp;
  }

  static Future<dynamic> getWorkAnnivesary() async {
    // String? token = await Service.getToken();
    var userid = await getId();

    var response = await http.get(
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      Uri.parse(
          "$baseURL/DefineReport/GetWorkAnniversary?userId=$userid&CompanyId=$userid"),
    );
    var resp = convert.jsonDecode(response.body);

    return resp;
  }

  static Future<dynamic> getLeaveListAdmin() async {
    // String? token = await Service.getToken();
    var userid = await getId();

    var response = await http.get(
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      Uri.parse(
          "$baseURL/LeaveApplication/GetLeaveListAdmin?userId=$userid&CompanyId=$userid"),
    );
    var resp = convert.jsonDecode(response.body);

    return resp;
  }

  //dashboard data
  static Future<dynamic> getTodaysPresentData() async {
    // String? token = await Service.getToken();
    var userid = await getId();

    var response = await http.get(
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      Uri.parse(
          "$baseURL/DefineReport/GetPresentStaff?userId=$userid&CompanyId=$userid"),
    );
    var resp = convert.jsonDecode(response.body);

    return resp;
  }

  static Future<dynamic> getTodaysAbsentData() async {
    // String? token = await Service.getToken();
    var userid = await getId();

    var response = await http.get(
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      Uri.parse(
          "$baseURL/DefineReport/GetAbsentStaff?userId=$userid&CompanyId=$userid"),
    );
    var resp = convert.jsonDecode(response.body);

    return resp;
  }

  static Future<dynamic> getTodaysOnLeaveData() async {
    // String? token = await Service.getToken();
    var userid = await getId();

    var response = await http.get(
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      Uri.parse(
          "$baseURL/DefineReport/GetOnLeaveStaff?userId=$userid&CompanyId=$userid"),
    );
    var resp = convert.jsonDecode(response.body);

    return resp;
  }

  static Future<dynamic> getTodaysWFHData() async {
    // String? token = await Service.getToken();
    var userid = await getId();

    var response = await http.get(
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      Uri.parse(
          "$baseURL/DefineReport/GetWFHStaff?userId=$userid&CompanyId=$userid"),
    );
    var resp = convert.jsonDecode(response.body);

    return resp;
  }
}
