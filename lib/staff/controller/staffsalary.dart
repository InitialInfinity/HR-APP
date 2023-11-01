import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:htmltopdfwidgets/htmltopdfwidgets.dart';

import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';

import '../../service.dart';
import '../downloadmanager.dart';

class StaffSalaryController extends GetxController {
  final TextEditingController selectedweekDay = TextEditingController();
  final TextEditingController selectDate = TextEditingController();
  RxString sdate = "".obs;
  RxString smonthDate = "".obs;
  RxString syear = "".obs;
  RxBool isloading = false.obs;
  // DateTime monthController = DateTime.now();
  RxList<String> weekDayList = <String>[
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ].obs;
  @override
  void onInit() {
    smonthDate.value = DateFormat.MMM().format(DateTime.now());
    syear.value = DateFormat.y().format(DateTime.now());

    super.onInit();
  }

  getStaffSalaryPDF() async {
    // var data =
    //     await Service.getStaffSalaryDFByMonth(smonthDate.value, syear.value);
    // print(data);
    isloading.value = true;
    var data =
        await Service.getStaffSalaryDFByMonth(smonthDate.value, syear.value);
    print(data);
    isloading.value = false;
    var bytes = base64Decode(data["data"]);

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/salaryslip.pdf");
    await file.writeAsBytes(bytes.buffer.asUint8List());
    await OpenFilex.open(file.path);
  }
}
