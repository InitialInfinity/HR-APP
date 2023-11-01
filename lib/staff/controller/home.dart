import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hr/constant.dart';
import 'package:intl/intl.dart';

import '../../classes/staff.dart';
import '../../service.dart';
import '../view/staffhome.dart';

class HomeController extends GetxController {
  // final TextEditingController selectedweekDay = TextEditingController();
  // final TextEditingController selectDate = TextEditingController();
  RxString punchIn = "--/--".obs;

  RxString punchOut = "--/--".obs;
  RxString? currentAddress = "Location not found".obs;
  Position? currentPosition;
  RxBool isLoading = false.obs;
  RxBool isLate = false.obs;
  RxBool isCo = false.obs;
  RxDouble lat = 0.0.obs;
  RxDouble long = 0.0.obs;
  Staff staff = Staff();
  RxString attendanceId = "".obs;
  RxString dailystatus = "".obs;
  RxString staffName = "".obs;
  RxString address = "".obs;
  RxString designation = "".obs;
  RxString emailid = "".obs;
  RxString empid = "".obs;
  RxString dob = "".obs;
  RxString basicsalary = "".obs;
  RxString doj = "".obs;
  RxString workinghours = "".obs;
  RxString pfNo = "".obs;
  RxString accountNo = "".obs;
  RxString esic = "".obs;
  RxString doe = "".obs;

  @override
  void onInit() {
    // punchIn.value = "09:00";
    // punchOut.value = "05:00";
    // getCurrentPosition();
    getStaffDetails();
    greetings();
    getAttendanceByDate();
    super.onInit();
  }

  RxString greetings() {
    final timenow = TimeOfDay.now().hour;
    if (timenow < 12) {
      dailystatus.value = "Morning";
      return 'Morning'.obs;
    } else if ((timenow >= 12) && (timenow <= 16)) {
      dailystatus.value = "Afternoon";
      return 'Afternoon'.obs;
    } else if ((timenow > 16) && (timenow < 20)) {
      dailystatus.value = "Evening";
      return 'Evening'.obs;
    } else {
      dailystatus.value = "Night";
      return 'Night'.obs;
    }
  }

  getStaffDetails() async {
    isLoading.value = true;
    var data = await Service.getStaffById();
    print(data);
    isLoading.value = false;
    if (data["outcome"]["outcomeId"] == 1) {
      staffName.value = data["data"][0]["StaffName"].toString();
      designation.value = data["data"][0]["Designation"].toString();
      emailid.value = data["data"][0]["EmailId"].toString();
      empid.value = data["data"][0]["EmpId"].toString();
      dob.value = data["data"][0]["DOB"].toString();
      doj.value = data["data"][0]["DateOfJoining"].toString();
      basicsalary.value = data["data"][0]["Basic_Salary"].toString();
      workinghours.value = data["data"][0]["WorkingHours"].toString();
      pfNo.value = data["data"][0]["PF_No"].toString();
      accountNo.value = data["data"][0]["Acc_No"].toString();
      esic.value = data["data"][0]["ESIC_No"].toString();
      address.value = data["data"][0]["Address"].toString();
      // doe.value = data["data"][0]["Basic_Salary"].toString();
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      flutterToastMsg(
          'Location services are disabled. Please enable the services');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        flutterToastMsg('Location permissions are denied');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      flutterToastMsg(
          'Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    return true;
  }

  Future<void> getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    isLoading.value = true;

    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low)
        .then((Position position) {
      currentPosition = position;
      _getAddressFromLatLng(currentPosition!);
      isLoading.value = false;
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            currentPosition!.latitude, currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      lat.value = currentPosition!.latitude;
      long.value = currentPosition!.longitude;
      Placemark place = placemarks[0];

      currentAddress!.value =
          '${place.street}, ${place.locality}, ${place.subAdministrativeArea},${"\n"}${place.postalCode}';
    }).catchError((e) {
      debugPrint(e);
    });
  }

  punchInFunc() async {
    final timeIn = DateFormat('hh:mm a').format(DateTime.now());
    punchIn.value = timeIn;
    await saveAttendance();
    // Get.back();
    print(punchIn);
  }

  punchOutFunc() async {
    await getCurrentPosition();
    final timeOut = DateFormat('hh:mm a').format(DateTime.now());
    punchOut.value = timeOut;
    // Get.back();
    await updateAttendance();
    print(punchOut);
  }

  getAttendanceByDate() async {
    var data = await Service.getAttendanceByDate(
        DateFormat('MM').format(DateTime.now()),
        DateFormat('dd').format(DateTime.now()));
    attendanceId.value = data["data"][0]["Id"].toString();
    punchIn.value = data["data"][0]["InTime"].toString();
    if (punchIn.value == "" ||
        punchIn.value == "--/--" ||
        punchIn.value == "null") {
      punchIn.value = "--/--";
    } else {
      punchIn.value = data["data"][0]["InTime"].toString();
    }
    punchOut.value = data["data"][0]["OutTime"].toString();
    if (punchOut.value == "" ||
        punchOut.value == "--/--" ||
        punchOut.value == "null") {
      punchOut.value = "--/--";
    } else {
      punchOut.value = data["data"][0]["OutTime"].toString();
    }

    print(punchOut.value);
  }

  saveAttendance() async {
    isLoading.value = true;
    staff.date = DateFormat('dd').format(DateTime.now());
    staff.month = DateFormat('MM').format(DateTime.now());
    staff.year = DateFormat('yyyy').format(DateTime.now());
    staff.inTime = punchIn.value;
    staff.inlatlong = "${lat.value},${long.value}";
    staff.status = "P";
    // if (isLate.value == true) {
    //   staff.type = "LateMark";
    // } else if (isCo.value == true) {
    //   staff.type = "Co";
    // }
    var data = await Service.addAttendanceStaff(staff);
    isLoading.value = false;
    print(data);
    if (data["outcome"]["outcomeId"] == 1) {
      Get.back();
      Get.to(() => const StaffHomePage());
      getAttendanceByDate();
      flutterToastMsg(data["outcome"]["outcomeDetail"].toString());
    } else {
      flutterToastMsg("Something went wrong");
    }
  }

  updateAttendance() async {
    isLoading.value = true;
    staff.id = attendanceId.value.toString();
    staff.date = DateFormat('dd').format(DateTime.now());
    staff.month = DateFormat('MM').format(DateTime.now());
    staff.year = DateFormat('yyyy').format(DateTime.now());
    staff.outTime = punchOut.value;
    staff.outLatLong = "${lat.value},${long.value}";
    staff.status = "P";
    var data = await Service.updateAttendanceStaff(staff);
    isLoading.value = false;
    print(data);
    if (data["outcome"]["outcomeId"] == 1) {
      Get.back();
      Get.to(() => const StaffHomePage());

      flutterToastMsg(data["outcome"]["outcomeDetail"].toString());
    } else {
      flutterToastMsg("Something went wrong");
    }
  }
}
