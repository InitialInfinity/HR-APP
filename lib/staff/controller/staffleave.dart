import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:hr/classes/staffleave.dart';
import 'package:hr/constant.dart';
import 'package:intl/intl.dart';
import '../../service.dart';
import '../view/staffLeave/leave.dart';

class StaffLeaveController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final TextEditingController fromDate = TextEditingController();
  final TextEditingController toDate = TextEditingController();
  final TextEditingController leaveReason = TextEditingController();
  final TextEditingController leaveType = TextEditingController();
  final TextEditingController noOfDays = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController contactNo = TextEditingController();
  final fbKeyAddLeave = GlobalKey<FormBuilderState>();
  RxString fromDateValue = "".obs;
  RxString toDateValue = "".obs;
  RxBool isLoading = false.obs;
  RxBool showDetails = false.obs;
  // RxList<RxBool> showContainer = <RxBool>[].obs;
  RxList<RxBool> showContainer = List.generate(5, (index) => false.obs).obs;
  late TabController tabControllerList;
  RxList leaveList = [].obs;
  RxInt noofDays = 0.obs;
  RxList balanceLeaveList = [].obs;
  RxList<String> leaveTypeList = <String>[
    "Leave Without Pay",
    "Privilege Leave",
    "Sick Leave",
  ].obs;
  RxList<String> leaveTypeAdd = <String>[
    "Privilege Leave",
    "Sick Leave",
  ].obs;
  RxList leaveBalance = [
    "Total Leave",
    "Applied Leave",
  ].obs;
  StaffLeave staffLeave = StaffLeave();
  @override
  void onInit() {
    getAllLeaveDetails();
    getBalanceLeaveDetails();
    tabControllerList = TabController(vsync: this, length: 2);
    super.onInit();
  }

  getBalanceLeaveDetails() async {
    isLoading.value = true;
    var data = await Service.getBalanceLeaveForStaff();
    balanceLeaveList.value = data["data"];
    print(leaveList);
    isLoading.value = false;
  }

  getAllLeaveDetails() async {
    isLoading.value = true;
    var data = await Service.getAllLeaveForStaff();

    leaveList.value = data["data"];
    print(leaveList);
    isLoading.value = false;
  }

  calculateTravelDays() {
    DateTime fromdate = DateFormat("dd-MM-yyyy").parse(fromDate.text);
    DateTime todate = DateFormat("dd-MM-yyyy").parse(toDate.text);
    noofDays.value = todate.difference(fromdate).inDays;
    staffLeave.noOfDays = noofDays.toString();
    noOfDays.text = staffLeave.noOfDays;
  }

  addLeave() async {
    if (fbKeyAddLeave.currentState!.saveAndValidate()) {
      staffLeave.fromDate = fromDate.text;
      staffLeave.toDate = toDate.text;
      staffLeave.leaveReason = leaveReason.text;
      staffLeave.noOfDays = noOfDays.text;
      staffLeave.contactNo = contactNo.text;
      staffLeave.leaveType = leaveType.text;
      var data = await Service.addStaffLeave(staffLeave);
      print(data);
      if (data["outcome"]["outcomeId"] == 1) {
        flutterToastMsg(data["outcome"]["outcomeDetail"]);
        Get.offAll(() => const StaffLeaveMasterPage());
      } else {
        isLoading.value = false;
      }
    }
  }
}
