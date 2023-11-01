import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import '../constant.dart';
import 'package:intl/intl.dart';

DateTime? dob;
DateTime? doj;
DateTime? doe;
void showDatePickerLeaveDate(TextEditingController controller, RxString date) {
  DatePicker.showDatePicker(Get.context!,
      onMonthChangeStartWithFirstDate: true,
      pickerMode: DateTimePickerMode.date,
      dateFormat: 'dd-MM-yyyy',
      pickerTheme: DateTimePickerTheme(
        showTitle: true,
        confirm: Text(
          'SELECT'.tr,
          style: const TextStyle(color: BLUE),
        ),
        cancel: Text(
          'CANCEL'.tr,
          style: const TextStyle(color: GREY),
        ),
      ),
      // maxDateTime: DateTime.now(),
      maxDateTime: DateTime.now().add(const Duration(days: 3650)),
      minDateTime: DateTime.now(),
      locale: DateTimePickerLocale.en_us,
      onConfirm: (dateTime, List<int> index) {
    controller.text = DateFormat('dd-MM-yyyy').format(dateTime);
    date.value = DateFormat('dd-MM-yyyy').format(dateTime);
  }, onCancel: () {});
}

void showDatePickerStaffDOB(
  TextEditingController controller,
  RxString date,
) {
  DatePicker.showDatePicker(Get.context!,
      onMonthChangeStartWithFirstDate: true,
      pickerMode: DateTimePickerMode.date,
      dateFormat: 'dd-MM-yyyy',
      pickerTheme: DateTimePickerTheme(
        showTitle: true,
        confirm: Text(
          'SELECT'.tr,
          style: const TextStyle(color: BLUE),
        ),
        cancel: Text(
          'CANCEL'.tr,
          style: const TextStyle(color: RED),
        ),
      ),
      // maxDateTime: DateTime.now(),
      maxDateTime: DateTime.now().add(const Duration(days: 3650)),
      // minDateTime: dob,
      locale: DateTimePickerLocale.en_us,
      onConfirm: (dateTime, List<int> index) {
    controller.text = DateFormat('MM-dd-yyyy').format(dateTime);
    date.value = DateFormat('MM-dd-yyyy').format(dateTime);
    dob = DateFormat("MM-dd-yyyy").parse(date.value);
    // dob = DateFormat('MM-dd-yyyy').format(dateTime);
  }, onCancel: () {});
}

void showDatePickerStaffDOJ(
  TextEditingController controller,
  RxString date,
) {
  DatePicker.showDatePicker(Get.context!,
      onMonthChangeStartWithFirstDate: true,
      pickerMode: DateTimePickerMode.date,
      dateFormat: 'dd-MM-yyyy',
      pickerTheme: DateTimePickerTheme(
        showTitle: true,
        confirm: Text(
          'SELECT'.tr,
          style: const TextStyle(color: BLUE),
        ),
        cancel: Text(
          'CANCEL'.tr,
          style: const TextStyle(color: RED),
        ),
      ),
      // maxDateTime: DateTime.now(),
      maxDateTime: DateTime.now().add(const Duration(days: 3650)),
      minDateTime: dob,
      locale: DateTimePickerLocale.en_us,
      onConfirm: (dateTime, List<int> index) {
    controller.text = DateFormat('MM-dd-yyyy').format(dateTime);
    date.value = DateFormat('MM-dd-yyyy').format(dateTime);
    doj = DateFormat("MM-dd-yyyy").parse(date.value);
  }, onCancel: () {});
}

void showDatePickerStaffDOE(
  TextEditingController controller,
  RxString date,
) {
  DatePicker.showDatePicker(Get.context!,
      onMonthChangeStartWithFirstDate: true,
      pickerMode: DateTimePickerMode.date,
      dateFormat: 'dd-MM-yyyy',
      pickerTheme: DateTimePickerTheme(
        showTitle: true,
        confirm: Text(
          'SELECT'.tr,
          style: const TextStyle(color: BLUE),
        ),
        cancel: Text(
          'CANCEL'.tr,
          style: const TextStyle(color: RED),
        ),
      ),
      // maxDateTime: DateTime.now(),
      maxDateTime: DateTime.now().add(const Duration(days: 3650)),
      minDateTime: doj,
      locale: DateTimePickerLocale.en_us,
      onConfirm: (dateTime, List<int> index) {
    controller.text = DateFormat('MM-dd-yyyy').format(dateTime);
    date.value = DateFormat('MM-dd-yyyy').format(dateTime);
  }, onCancel: () {});
}

void showMonth(
  String? locale,
  RxString monthValue,
) async {
  // final localeObj = locale != null ? Locale(locale) : null;
  final selected = await showMonthPicker(
    headerColor: BLUE,
    selectedMonthBackgroundColor: BLUE,
    unselectedMonthTextColor: BLUE,
    hideHeaderRow: true,
    lastDate: DateTime.now(),
    firstDate: DateTime.now().subtract(const Duration(days: 3650)),
    confirmWidget: normaltext(
      "OK",
      BLUE,
      FontWeight.bold,
    ),
    cancelWidget: normaltext(
      "Cancel",
      BLUE,
      FontWeight.bold,
    ),
    context: Get.context!,
    initialDate: DateTime.now(),
  ).then((date) {
    if (date != null) {
      monthValue.value = DateFormat.MMM().format(date);
      print(monthValue.value);
    }
  });
}

void showYear(
  String? locale,
  RxString yearValue,
) async {
  // final localeObj = locale != null ? Locale(locale) : null;
  final selected = await showMonthPicker(
    firstDate: DateTime.now(),
    lastDate: DateTime.now(),
    headerColor: BLUE,
    selectedMonthBackgroundColor: BLUE,
    unselectedMonthTextColor: BLUE,
    yearFirst: true,
    hideHeaderRow: true,
    confirmWidget: normaltext(
      "OK",
      BLUE,
      FontWeight.bold,
    ),
    cancelWidget: normaltext(
      "Cancel",
      BLUE,
      FontWeight.bold,
    ),
    context: Get.context!,
    initialDate: DateTime.now(),
  ).then((date) {
    if (date != null) {
      yearValue.value = DateFormat.y().format(date);
      print(yearValue.value);
    }
  });
}

void showTime(TextEditingController controller) async {
  TimeOfDay? pickedTime = await showTimePicker(
    initialTime: TimeOfDay.now(),
    context: Get.context!,
  );

  if (pickedTime != null) {
    print(pickedTime.format(Get.context!)); //output 10:51 PM
    DateTime parsedTime =
        DateFormat.jm().parse(pickedTime.format(Get.context!).toString());
    //converting to DateTime so that we can further format on different pattern.
    print(parsedTime); //output 1970-01-01 22:53:00.000
    RxString formattedTime = DateFormat("h:mm a").format(parsedTime).obs;
    print(formattedTime); //output 14:59:00
    //DateFormat() is from intl package, you can format the time on any pattern you need.

    controller.text = formattedTime.value; //set the value of text field.
  } else {
    print("Time is not selected");
  }
}
