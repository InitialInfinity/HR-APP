import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:hr/company/view/companyhome.dart';
import 'package:hr/company/view/shift/shift.dart';
import 'package:hr/constant.dart';

import '../../classes/shift.dart';
import 'package:intl/intl.dart';
import '../../service.dart';
import '../view/shift/addshift.dart';
import '../view/shift/editShift.dart';

class ShiftController extends GetxController {
  final fbKeyAddShift = GlobalKey<FormBuilderState>();
  final TextEditingController shiftName = TextEditingController();
  final TextEditingController startTime = TextEditingController();
  final TextEditingController endTime = TextEditingController();
  final TextEditingController graceTime = TextEditingController();
  final TextEditingController halfDayHours = TextEditingController();
  final TextEditingController fullDayHours = TextEditingController();
  final TextEditingController weekOffType = TextEditingController();
  final TextEditingController weekOff = TextEditingController();
  final TextEditingController weekOffSecond = TextEditingController();
  final TextEditingController weekOffFirst = TextEditingController();
  final TextEditingController id = TextEditingController();
  RxString selectWeekOffValue = "".obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingadd = false.obs;
  RxList<String> weekOffTypeList = <String>[
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "1st and 3rd Saturday",
    "2nd and 4th Saturday",
    "Other"
  ].obs;
  RxList<String> weekDayList1 = <String>[
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
  RxList<String> weekDayList2 = <String>[
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "1st and 3rd Saturday",
    "2nd and 4th Saturday",
    "Not Applicable"
  ].obs;
  Shift shift = Shift();
  RxList shiftList = [].obs;

  @override
  void onInit() {
    getAllShift();
    super.onInit();
  }

  goToAddShift() {
    isLoading.value = true;

    Get.to(() => const AddShiftPage());
    isLoading.value = false;
  }

  getAllShift() async {
    isLoading.value = true;
    var data = await Service.getAllShift();
    print(data);
    if (data["outcome"]["outcomeId"] == 1) {
      shiftList.value = data["data"];
      isLoading.value = false;
      print(shiftList);
    }
  }

  addShift() async {
    if (fbKeyAddShift.currentState!.saveAndValidate()) {
      isLoadingadd.value = true;
      shift.shiftName = shiftName.text;
      shift.startTime = startTime.text;
      shift.endTime = endTime.text;
      shift.graceTime = graceTime.text;
      shift.halfDayTime = halfDayHours.text;
      shift.fullDayTime = fullDayHours.text;
      shift.weekOffFirst = weekOffFirst.text;
      shift.weekOffSecond = weekOffSecond.text;
      var data = await Service.addShift(shift);
      print(data);
      if (data["outcome"]["outcomeId"] == 1) {
        flutterToastMsg(data["outcome"]["outcomeDetail"]);
        isLoadingadd.value = false;
        Get.offAll(() => const ShiftList());
      }
    }
  }

  updateShift(var i) async {
    id.text = i["Id"];
    shiftName.text = i["ShiftName"];
    startTime.text = i["StartTime"];
    endTime.text = i["EndTime"];
    graceTime.text = i["GraceTime"];
    halfDayHours.text = i["HalfDayTime"];
    fullDayHours.text = i["FullDayTime"];
    weekOffFirst.text = i["WeekOff_First"];
    weekOffSecond.text = i["WeekOff_Second"];
    Get.to(() => const EditShiftPage());
  }

  updateShiftData() async {
    isLoadingadd.value = true;
    shift.id = id.text;
    shift.shiftName = shiftName.text;
    shift.startTime = startTime.text;
    shift.endTime = endTime.text;
    shift.graceTime = graceTime.text;
    shift.halfDayTime = halfDayHours.text;
    shift.fullDayTime = fullDayHours.text;
    shift.weekOffFirst = weekOffFirst.text;
    shift.weekOffSecond = weekOffSecond.text;
    var data = await Service.updateShift(shift);
    isLoadingadd.value = false;
    print(data);
    if (data["outcome"]["outcomeId"] == 1) {
      flutterToastMsg(data["outcome"]["outcomeDetail"]);
      Get.offAll(() => const ShiftList());
    }
  }

  deleteShift(var id) async {
    isLoading.value = true;
    var data = await Service.deleteShift(id);
    print(data);
    if (data["outcome"]["outcomeId"] == 1) {
      flutterToastMsg(data["outcome"]["outcomeDetail"]);

      isLoading.value = false;
      update();

      Get.offAll(() => const ShiftList());
    } else {
      isLoading.value = false;
    }
  }
}
