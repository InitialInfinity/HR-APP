import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../classes/salary.dart';
import '../../constant.dart';
import '../../service.dart';
import '../view/salary/editsalary.dart';
import '../view/salary/salarylist.dart';
import 'package:intl/intl.dart';

class SalaryController extends GetxController {
  RxBool showStaffDetails = false.obs;
  RxString lType = "".obs;
  RxString staffName = "".obs;
  final TextEditingController id = TextEditingController();
  final TextEditingController selectedstaff = TextEditingController();
  final TextEditingController basicSalary = TextEditingController();
  final TextEditingController presentDays = TextEditingController();
  final TextEditingController bonus = TextEditingController();
  final TextEditingController tax = TextEditingController();
  final TextEditingController otherAllowance = TextEditingController();
  final TextEditingController pfAmount = TextEditingController();
  final TextEditingController esicAmount = TextEditingController();
  final TextEditingController overtime = TextEditingController();
  final TextEditingController overtimePerhours = TextEditingController();
  final TextEditingController searchMonth = TextEditingController();
  final TextEditingController searchYear = TextEditingController();
  RxString searchMonthValue = "".obs;
  RxString searchYearValue = "".obs;
  Salary salary = Salary();
  final fbKeyAddSalary = GlobalKey<FormBuilderState>();
  final fbKeyUpdateSalary = GlobalKey<FormBuilderState>();

  RxList allsalaryList = [].obs;
  RxList<String> employeeList = <String>[
    "Chetan",
    "Anamika",
    "Mansi",
    "Azim",
    "Runali",
    "Rushika",
    "Shubham"
  ].obs;
  RxList<String> weekDayList = <String>[
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ].obs;
  RxBool isLoading = false.obs;
  RxString salarymonth = "".obs;
  RxString salaryyear = "".obs;
  RxList staffList = [].obs;

  RxString monthDate = "".obs;
  RxString year = "".obs;
  @override
  void onInit() {
    salarymonth.value = DateFormat.MMM().format(DateTime.now());
    salaryyear.value = DateFormat.y().format(DateTime.now());
    getAllSalarySlip();
    getStaff();
    super.onInit();
  }

  showStaffSalaryDetails() {
    showStaffDetails.value = !showStaffDetails.value;
  }

  getStaff() async {
    isLoading.value = true;
    var data = await Service.getStaff();
    print(data);
    isLoading.value = false;
    if (data["outcome"]["outcomeId"] == 1) {
      staffList.value = data["data"];
      print(staffList);
    }
  }

  getAllSalarySlip() async {
    isLoading.value = true;
    var data =
        await Service.getAllSalarySlip(salarymonth.value, salaryyear.value);
    isLoading.value = false;
    print(data);
    if (data["outcome"]["outcomeId"] == 1) {
      allsalaryList.value = data["data"];
      print(allsalaryList);
    }
  }

  getBasicSalary(String staffId) async {
    var data = await Service.getBasicSalary(staffId);
    print(data);
    basicSalary.text = data["data"][0]["Basic_Salary"].toString();
  }

  getPresentDays(String staffId) async {
    var data = await Service.getPresentDays(
        staffId, salarymonth.value, salaryyear.value);
    print(data);

    if (data["data"][0]["PresentCount"].toString() == "null") {
      presentDays.text = "0";
    } else {
      presentDays.text = data["data"][0]["PresentCount"].toString();
    }
  }

  addSalary() async {
    if (fbKeyAddSalary.currentState!.saveAndValidate()) {
      isLoading.value = true;
      salary.staffId = selectedstaff.text;
      salary.basicSalary = basicSalary.text;
      salary.presentdays =
          (salary.presentdays == "null" || salary.presentdays == "")
              ? "0"
              : presentDays.text;
      salary.bonus = bonus.text;
      salary.tax = tax.text;
      salary.otherAllowance = otherAllowance.text;
      salary.month = salarymonth.value;
      salary.year = salaryyear.value;
      salary.pfAmount = int.parse(pfAmount.text);
      salary.esicAmount = int.parse(esicAmount.text);
      salary.overtime = int.parse(overtime.text);
      salary.overtimePerHour = overtimePerhours.text;

      var data = await Service.addSalarySLip(salary);
      isLoading.value = false;
      print(data);
      if (data["outcome"]["outcomeId"] == 1) {
        flutterToastMsg(data["outcome"]["outcomeDetail"].toString());
        Get.offAll(() => const SalaryPage());
      } else {
        flutterToastMsg("Something went wrong");
      }
    }
  }

  gotoSalaryEdit(var i) {
    id.text = i["Id"];
    selectedstaff.text = i["StaffId"];
    basicSalary.text = i["Basic_Salary"];
    presentDays.text == "null" ? "0" : i["PresentDays"];
    bonus.text = i["Bonus"];
    tax.text = i["Tax"];
    otherAllowance.text = i["OtherAllowance"];
    salarymonth.value = i["Month"];
    salaryyear.value = int.parse(i["Year"].toString()).toString();
    var s = i["PF_Amt"];
    pfAmount.text = s.toString();
    var e = i["ESIC_AMT"];
    esicAmount.text = e.toString();
    var ot = i["Overtime_total_amt"];
    overtime.text = ot.toString();
    var otp = i["Overtime_Per_hrs"];
    overtimePerhours.text = otp.toString();
    // var a = i["Year"];
    // salaryyear.value = a;
    // pfAmount.text = i["PF_Amt"];
    // pfAmount.text = salary.pfAmount.toString();
    // salary.pfAmount = int.parse(pfAmount.text);
    // esicAmount.text = i["ESIC_AMT"];
    // overtime.text = i["Overtime_total_amt"];
    // overtimePerhours.text = i["Overtime_Per_hrs"];
    Get.to(() => const SalaryEditPage());
  }

  updateSalary() async {
    if (fbKeyUpdateSalary.currentState!.saveAndValidate()) {
      salary.id = id.text;
      salary.staffId = selectedstaff.text;
      salary.basicSalary = basicSalary.text;
      salary.presentdays = presentDays.text;
      salary.bonus = bonus.text;
      salary.tax = tax.text;
      salary.otherAllowance = otherAllowance.text;
      salary.month = salarymonth.value;
      salary.year = salaryyear.value;
      salary.pfAmount = int.parse(pfAmount.text);
      salary.esicAmount = int.parse(esicAmount.text);
      salary.overtime = int.parse(overtime.text);
      salary.overtimePerHour = overtimePerhours.text;
      isLoading.value = true;
      var data = await Service.updateSalarySLip(salary);
      isLoading.value = false;
      print(data);
      if (data["outcome"]["outcomeId"] == 1) {
        flutterToastMsg(data["outcome"]["outcomeDetail"].toString());
        Get.offAll(() => const SalaryPage());
      } else {
        flutterToastMsg("Something went wrong");
      }
    }
  }

  deleteSalarySlip(String id) async {
    isLoading.value = true;
    var data = await Service.deleteSalarySLip(id);
    isLoading.value = false;
    if (data["outcome"]["outcomeId"] == 1) {
      flutterToastMsg(data["outcome"]["outcomeDetail"]);
      Get.offAll(() => const SalaryPage());
    }
    print(data);
  }

  filterByMonth(searchMonthValue, searchYearValue) async {
    isLoading.value = true;
    var data =
        await Service.getAllSalarySlip(searchMonthValue, searchYearValue);
    print(data);
    isLoading.value = false;
    if (data["outcome"]["outcomeId"] == 1) {
      flutterToastMsg(data["outcome"]["outcomeDetail"]);
      allsalaryList.value = data["data"];
      Get.to(() => const SalaryPage());
    }
  }
}
