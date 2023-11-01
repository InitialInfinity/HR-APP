import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:hr/company/view/leave/editleave.dart';
import 'package:hr/constant.dart';
import 'package:hr/service.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

import '../view/companyhome.dart';
import 'package:intl/intl.dart';

import '../view/leave/leavemaster.dart';
import '../view/leaveapproval/leaveapprovallist.dart';

class LeaveController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final TextEditingController privilegeleave = TextEditingController();
  final TextEditingController sickleave = TextEditingController();
  // final TextEditingController selectedweekDay = TextEditingController();
  final TextEditingController selectedStaffName = TextEditingController();
  final TextEditingController selectDate = TextEditingController();
  final TextEditingController addDescription = TextEditingController();
  final TextEditingController weekOffSecond = TextEditingController();
  final TextEditingController weekOffFirst = TextEditingController();
  final TextEditingController reason = TextEditingController();
  RxInt selectedContainer = 0.obs;

  RxString date = "".obs;
  RxString monthDate = "".obs;
  RxString staffName = "".obs;
  RxString year = "".obs;
  RxString holidayId = "".obs;
  RxString weekoffId = "".obs;
  RxString leaveId = "".obs;
  RxBool showHoliday = false.obs;
  RxBool showLeave = false.obs;
  RxBool showWeekOff = true.obs;

  RxBool isUpdate = false.obs;
  final fbKeyAddLeave = GlobalKey<FormBuilderState>();
  final fbKeyEditLeave = GlobalKey<FormBuilderState>();
  RxList allHolidday = [].obs;
  RxList staffList = [].obs;
  RxList weekOfflist = [].obs;
  RxList leaveList = [].obs;
  RxList addleaveList = [].obs;
  RxList leaveListAdmin = [].obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingTemp = false.obs;
  RxBool isLoadingAttendance = false.obs;
  RxBool isLoadingleave = false.obs;
  RxBool isApprove = false.obs;
  RxBool isReject = false.obs;
  late TabController tabControllerList;

  RxList<String> weekDayList = <String>[
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "1st and 3rd Saturday",
    "2nd and 4th Saturday",
  ].obs;
  RxList<String> titleList = <String>[
    "Add Week Off",
    "Add Holiday",
    "Add Leave",
  ].obs;
  RxList adminAllLeave = [].obs;
  @override
  void onInit() {
    getAllHoliday();
    getWeekOff();
    getStaff();
    getLeave();
    adminGetLeaveDetails();
    getLeaveListAdmin();
    monthDate.value = DateFormat.MMM().format(DateTime.now());
    year.value = DateFormat.y().format(DateTime.now());
    tabControllerList = TabController(vsync: this, length: 3);
    super.onInit();
  }

  showHolidaycontainer() {
    showHoliday.value = !showHoliday.value;
    if (showHoliday.value == true) {
      showLeave.value = false;
      showWeekOff.value = false;
    }
  }

  showWeekOffcontainer() {
    showWeekOff.value = !showWeekOff.value;
    if (showWeekOff.value == true) {
      showHoliday.value = false;
      showLeave.value = false;
    }
  }

  showLeavecontainer() {
    showLeave.value = !showLeave.value;
    if (showLeave.value == true) {
      showHoliday.value = false;
      showWeekOff.value = false;
    }
  }

  getAllHoliday() async {
    isLoading.value = true;
    var data = await Service.getHolidays();
    print(data);
    isLoading.value = false;
    if (data["outcome"]["outcomeId"] == 1) {
      allHolidday.value = data["data"];
      print(allHolidday);
    }
  }

  getStaff() async {
    isLoading.value = true;
    var data = await Service.getStaff();
    print(data);
    isLoading.value = false;
    if (data["outcome"]["outcomeId"] == 1) {
      staffList.value = data["data"];
      print(allHolidday);
    }
  }

  getWeekOff() async {
    isLoading.value = true;
    var data = await Service.getWeekOff();
    print(data);
    isLoading.value = false;
    if (data["outcome"]["outcomeId"] == 1) {
      weekOfflist.value = data["data"];
      print(weekOfflist);
    }
  }

  getLeave() async {
    var data = await Service.getLeaveaddAdmin();
    print(data);
    isLoading.value = false;
    if (data["outcome"]["outcomeId"] == 1) {
      addleaveList.value = data["data"];
      print(addleaveList);
    }
  }

  addHoliday() async {
    isLoading.value = true;
    if (isUpdate.value == true) {
      var data = await Service.updateHoliday(
          selectDate.text, addDescription.text, holidayId.value);
      print(data);

      if (data["outcome"]["outcomeId"] == 1) {
        isLoading.value = false;
        flutterToastMsg(data["outcome"]["outcomeDetail"].toString());
        Get.offAll(() => const LeaveMasterPage());
      } else {
        flutterToastMsg("Something went wrong");
        isLoading.value = false;
      }
    } else if (fbKeyAddLeave.currentState!.saveAndValidate()) {
      var data = await Service.addHoliday(
        selectDate.text,
        addDescription.text,
      );
      print(data);

      if (data["outcome"]["outcomeId"] == 1) {
        isLoading.value = false;
        if (data["outcome"]["outcomeDetail"].toString() == "Holiday exist!") {
          flutterToastMsg("Holiday already exist!");
        } else {
          flutterToastMsg(data["outcome"]["outcomeDetail"].toString());
        }

        Get.offAll(() => const LeaveMasterPage());
      } else {
        flutterToastMsg("Something went wrong");
        isLoading.value = false;
      }
    }
  }

  addWeekOff() async {
    isLoading.value = true;
    if (isUpdate.value == true) {
      showWeekOff.value = true;
      var data = await Service.updateWeekOff(weekOffFirst.text,
          weekOffSecond.text, (isUpdate.value == true) ? weekoffId.value : "");

      print(data);
      if (data["outcome"]["outcomeId"] == 1) {
        isLoading.value = false;

        flutterToastMsg("Week Off updated successfully");

        Get.offAll(() => const LeaveMasterPage());
      } else {
        isLoading.value = false;

        flutterToastMsg("Something went wrong");
      }
    } else if (fbKeyAddLeave.currentState!.saveAndValidate()) {
      if (weekOffFirst.text == weekOffSecond.text) {
        flutterToastMsg("Please select different days as week off.");
        isLoading.value = false;
      } else {
        var data =
            await Service.addWeekOff(weekOffFirst.text, weekOffSecond.text);
        print(data);
        if (data["outcome"]["outcomeId"] == 1) {
          isLoading.value = false;

          flutterToastMsg("Week Off added successfully");

          Get.offAll(() => const LeaveMasterPage());
        } else {
          flutterToastMsg("Something went wrong");
          isLoading.value = false;
        }
      }
    }
  }

  addLeave() async {
    isLoading.value = true;
    if (isUpdate.value == true) {
      showLeave.value = true;
      var data = await Service.updateLeave(
          selectedStaffName.text, sickleave.text, privilegeleave.text);

      print(data);
      if (data["outcome"]["outcomeId"] == 1) {
        isLoading.value = false;

        flutterToastMsg("Leaves updated successfully");

        Get.offAll(() => const LeaveMasterPage());
      } else {
        isLoading.value = false;

        flutterToastMsg("Something went wrong");
      }
    } else if (fbKeyAddLeave.currentState!.saveAndValidate()) {
      isLoading.value = true;
      var data = await Service.addLeave(
          selectedStaffName.text, sickleave.text, privilegeleave.text);
      print(data);

      if (data["outcome"]["outcomeId"] == 1) {
        flutterToastMsg("Leave added successfully");

        Get.offAll(() => const LeaveMasterPage());
        isLoading.value = false;
      } else {
        flutterToastMsg("Something went wrong");
        isLoading.value = false;
      }
    }
  }

  deleteHoliday(String id) async {
    isLoading.value = true;
    var data = await Service.deleteHoliday(id);
    print(data);
    if (data["outcome"]["outcomeId"] == 1) {
      flutterToastMsg(data["outcome"]["outcomeDetail"]).toString();
      isLoading.value = false;
      Get.offAll(() => const LeaveMasterPage());
    } else {
      isLoading.value = false;
    }
  }

  deleteWeekOff(String id) async {
    isLoading.value = true;
    var data = await Service.deleteWeekOff(id);
    print(data);
    if (data["outcome"]["outcomeId"] == 1) {
      flutterToastMsg(data["outcome"]["outcomeDetail"]).toString();
      isLoading.value = false;
      Get.offAll(() => const LeaveMasterPage());
    } else {
      isLoading.value = false;
    }
  }

  editLeave(var i, var selectValue) {
    isUpdate.value = true;

    if (selectValue == 0) {
      selectedContainer.value = 0;
      weekoffId.value = i["Id"];
      showWeekOff.value = true;
      showWeekOffcontainer();
      weekOffFirst.text = i["WeekOff_First"];
      weekOffSecond.text = i["WeekOff_Second"];
      Get.to(() => EditLeavePage(selectedContainer.value));
      update();
    } else if (selectValue == 1) {
      selectedContainer.value = 1;
      holidayId.value = i["Id"];
      showHoliday.value = true;
      showHolidaycontainer();
      selectDate.text = i["Date"];
      addDescription.text = i["Description"];
      Get.to(() => EditLeavePage(selectedContainer.value));
      update();
    } else if (selectValue == 2) {
      selectedContainer.value = 2;
      leaveId.value = i["Id"];
      showLeave.value = true;
      showLeavecontainer();
      selectedStaffName.text = i["StaffName"];
      sickleave.text = i["SickLeaves"];
      privilegeleave.text = i["PrivilegeLeave"];

      Get.to(() => EditLeavePage(selectValue));
      update();
    }
  }

  adminGetLeaveDetails() async {
    isLoading.value = true;
    var data = await Service.getAdminLeaveDetails();
    print(data);
    isLoading.value = false;
    if (data["outcome"]["outcomeId"] == 1) {
      adminAllLeave.value = data["data"];
      print(adminAllLeave);
    }
  }

  addLeaveApproval(String id, String staffId, String approval) async {
    isLoading.value = true;

    var data =
        await Service.addLeaveApproval(id, staffId, approval, reason.text);
    print(data);
    isLoading.value = false;
    if (data["outcome"]["outcomeId"] == 1) {
      flutterToastMsg(data["outcome"]["outcomeDetail"]).toString();
      Get.offAll(() => const LeaveApprovalList());

      update();
    } else {
      isLoading.value = false;
    }
  }

  getLeaveReportMonthly() async {
    isLoadingleave.value = true;
    monthDate.value = DateFormat.MMM().format(DateTime.now());
    var month = DateFormat.M().format(DateTime.now());
    var data = await Service.getLeaveReportMonthly(month);
    print(data);
    isLoadingleave.value = false;
    var bytes = base64Decode(data["data"]);

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/report.xlsx");
    await file.writeAsBytes(bytes.buffer.asUint8List());
    await OpenFilex.open(file.path);
  }

  getLeaveListAdmin() async {
    var data = await Service.getLeaveListAdmin();
    print(data);
    if (data["outcome"]["outcomeId"] == 1) {
      leaveListAdmin.value = data['data'];
    }
  }

  getAttendanceReportMonthly() async {
    isLoadingAttendance.value = true;
    monthDate.value = DateFormat.MMM().format(DateTime.now());
    var month = DateFormat.M().format(DateTime.now());
    var data = await Service.getAttendanceReportOfMonth(month, year.value);
    print(data);

    isLoadingAttendance.value = false;
    if (data["data"] == null) {
      flutterToastMsg("There is no attendance report file");
    } else {
      var bytes = base64Decode(data["data"]);

      final output = await getTemporaryDirectory();
      final file = File("${output.path}/attendancereport.xlsx");
      await file.writeAsBytes(bytes.buffer.asUint8List());
      await OpenFilex.open(file.path);
    }
  }
}
