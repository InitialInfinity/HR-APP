import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:hr/company/controller/profile.dart';
import 'package:hr/company/controller/shift.dart';
import 'package:hr/widget/drawer.dart';
import 'package:hr/widget/dropdown.dart';

import '../../../constant.dart';
import '../../../widget/appbar.dart';
import '../../../widget/bottomnavigationbar.dart';
import '../../../widget/button.dart';
import '../../../widget/datepicker.dart';
import '../../../widget/label.dart';
import '../../../widget/textformfield.dart';

class AddShiftPage extends StatelessWidget {
  const AddShiftPage({super.key});

  @override
  Widget build(BuildContext context) {
    ShiftController shiftController = Get.put(ShiftController());
    return Obx(
      () {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: WillPopScope(
            onWillPop: () async => true,
            child: SafeArea(
              child: Column(
                children: [
                  AppBarWidget("Add Shift", false, () {}, true, true),
                  FormBuilder(
                    key: shiftController.fbKeyAddShift,
                    child: Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SingleChildScrollView(
                          child: (shiftController.isLoading.value)
                              ? Center(child: loadingWidget())
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // LabelWidget("Shift Name"),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        LabelWidget("Shift Name"),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        normaltext("*", RED)
                                      ],
                                    ),
                                    TextFormFieldWidget(
                                      hinttext: "Enter Shift Name",
                                      controller: shiftController.shiftName,
                                      errortext: "Enter Shift Name",
                                      keyboardType: TextInputType.name,
                                      inputFormatter: r'[a-z A-Z , ]',
                                      prefixIcon: const Icon(
                                        Icons.punch_clock,
                                        color: BLUE,
                                      ),
                                      onTap: () {},
                                    ),
                                    const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10)),
                                    // LabelWidget("Start Time"),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        LabelWidget("Start Time"),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        normaltext("*", RED)
                                      ],
                                    ),
                                    TextFormFieldWidget(
                                      hinttext: "Enter Start Time",
                                      controller: shiftController.startTime,
                                      errortext: "Select Start Time",
                                      keyboardType: TextInputType.name,
                                      inputFormatter: r'[a-z A-Z,0-9.:-()&]',
                                      prefixIcon: const Icon(
                                        Icons.alarm,
                                        color: BLUE,
                                      ),
                                      onTap: () {
                                        showTime(shiftController.startTime);
                                      },
                                    ),
                                    const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10)),
                                    // LabelWidget("End Time"),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        LabelWidget("End Time"),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        normaltext("*", RED)
                                      ],
                                    ),
                                    TextFormFieldWidget(
                                      hinttext: "Select End Time",
                                      controller: shiftController.endTime,
                                      errortext: "Select End Time",
                                      readonly: true,
                                      keyboardType: TextInputType.number,
                                      inputFormatter: r'[0-9 .]',
                                      prefixIcon: const Icon(
                                        Icons.alarm,
                                        color: BLUE,
                                      ),
                                      onTap: () {
                                        showTime(shiftController.endTime);
                                      },
                                    ),
                                    const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10)),
                                    LabelWidget(
                                      "Grace Time",
                                    ),
                                    TextFormField(
                                      cursorColor: BLUE,
                                      controller: shiftController.graceTime,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      textAlign: TextAlign.left,
                                      enabled: true,
                                      style: const TextStyle(fontSize: 14),
                                      decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 10.0,
                                                  horizontal: 10.0),
                                          prefixIcon: const Icon(
                                            Icons.timelapse,
                                            color: BLUE,
                                          ),
                                          border: const OutlineInputBorder(
                                            borderSide: BorderSide(color: GREY),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.0),
                                            ),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide:
                                                const BorderSide(color: GREY),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide:
                                                const BorderSide(color: GREY),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide:
                                                const BorderSide(color: GREY),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide:
                                                const BorderSide(color: GREY),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide:
                                                const BorderSide(color: GREY),
                                          ),
                                          filled: true,
                                          hintStyle: const TextStyle(
                                            color: GREY_DARK,
                                            fontSize: 12,
                                          ),
                                          hintText: "Select Grace Time",
                                          fillColor: Colors.white,
                                          errorStyle: TextStyle(
                                            color: RED,
                                          )),
                                      keyboardType: TextInputType.none,
                                      onTap: () {
                                        showTime(shiftController.graceTime);
                                      },
                                    ),
                                    // TextFormFieldWidget(
                                    //   hinttext: "Select Grace Time",
                                    //   controller: shiftController.graceTime,
                                    //   errortext: "Select Grace Time",
                                    //   readonly: true,
                                    //   keyboardType: TextInputType.number,
                                    //   inputFormatter: r'[0-9 .]',
                                    //   prefixIcon: const Icon(
                                    //     Icons.timelapse,
                                    //     color: BLUE,
                                    //   ),
                                    //   onTap: () {

                                    //     showTime(shiftController.graceTime);
                                    //   },
                                    // ),
                                    const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10)),
                                    // LabelWidget("Half Day Hours"),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        LabelWidget("Half Day Hours"),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        normaltext("*", RED)
                                      ],
                                    ),
                                    TextFormFieldWidget(
                                      hinttext: "Enter Half Day Hours",
                                      controller: shiftController.halfDayHours,
                                      errortext: "Enter Half Day Hours",
                                      keyboardType: TextInputType.datetime,
                                      inputFormatter: r'[0-9 :]',
                                      prefixIcon: const Icon(
                                        Icons.alarm,
                                        color: BLUE,
                                      ),
                                      // onTap: () {
                                      //   showTime(shiftController.halfDayHours);
                                      // },
                                    ),
                                    const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10)),
                                    // LabelWidget("Full Day Hours"),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        LabelWidget("Full Day Hours"),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        normaltext("*", RED)
                                      ],
                                    ),
                                    TextFormFieldWidget(
                                      hinttext: "Enter Full Day Hours",
                                      controller: shiftController.fullDayHours,
                                      errortext: "Enter Full Day Hours",
                                      keyboardType: TextInputType.datetime,
                                      inputFormatter: r'[0-9 :]',
                                      prefixIcon: const Icon(
                                        Icons.alarm,
                                        color: BLUE,
                                      ),
                                      // onTap: () {
                                      //   showTime(shiftController.fullDayHours);
                                      // },
                                    ),
                                    const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10)),
                                    // LabelWidget("Select Week Off"),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        LabelWidget("Select Week Off"),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        normaltext("*", RED)
                                      ],
                                    ),
                                    DropDownWidget(
                                      hinttext: "Select Week Off",
                                      errortext: "Select Week Off",
                                      isExpanded: true,
                                      selectedvalue: shiftController
                                          .weekOffType.text
                                          .toString(),
                                      list: shiftController.weekOffTypeList,
                                      controller: shiftController.weekOffType,
                                      icon: const Icon(
                                        Icons.calendar_view_day_rounded,
                                        color: BLUE,
                                      ),
                                    ),
                                    const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10)),
                                    (isOtherValue.value == true)
                                        ? Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 8.0,
                                                            left: 3.0),
                                                    child: Row(
                                                      children: [
                                                        normaltext(
                                                            "Select Week Off 1",
                                                            GREY_DARK),
                                                        const SizedBox(
                                                          width: 4,
                                                        ),
                                                        normaltext("*", RED)
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              DropdownButtonFormField(
                                                decoration: InputDecoration(
                                                  border:
                                                      const OutlineInputBorder(
                                                    borderSide:
                                                        BorderSide(color: GREY),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10.0),
                                                    ),
                                                  ),
                                                  disabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: GREY),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: GREY),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: GREY),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: GREY),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: GREY),
                                                  ),
                                                  fillColor: WHITE,
                                                  filled: true,
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          vertical: 10.0,
                                                          horizontal: 10.0),
                                                ),
                                                validator: FormBuilderValidators
                                                    .compose([
                                                  FormBuilderValidators.required(
                                                      errorText:
                                                          "Select  Week Off 1"),
                                                ]),
                                                isExpanded: true,
                                                hint: const Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 0, 0, 0),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .calendar_view_day_rounded,
                                                        color: BLUE,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        "Select Week Off 1",
                                                        style: TextStyle(
                                                            color: GREY_DARK,
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                style: const TextStyle(
                                                  color: BLACK,
                                                  fontSize: 14,
                                                ),
                                                onChanged: (newValue) {
                                                  shiftController.weekOffFirst
                                                      .text = newValue!;
                                                  shiftController
                                                          .weekOffFirst.text =
                                                      shiftController
                                                          .weekOffFirst.text;
                                                },
                                                // value: leaveController
                                                //     .weekOffSecond.text,
                                                items: shiftController
                                                    .weekDayList1
                                                    .map((value) {
                                                  return DropdownMenuItem(
                                                    value: value,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 10.0,
                                                      ),
                                                      child: Text(value),
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                              const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10)),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 8.0,
                                                            left: 3.0),
                                                    child: Row(
                                                      children: [
                                                        normaltext(
                                                            "Select Week Off 2",
                                                            GREY_DARK),
                                                        // const SizedBox(
                                                        //   width: 2,
                                                        // ),
                                                        // normaltext("(Optional)",
                                                        //     GREY_DARK),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              DropdownButtonFormField(
                                                decoration: InputDecoration(
                                                  border:
                                                      const OutlineInputBorder(
                                                    borderSide:
                                                        BorderSide(color: GREY),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10.0),
                                                    ),
                                                  ),
                                                  disabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: GREY),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: GREY),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: GREY),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: GREY),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: GREY),
                                                  ),
                                                  fillColor: WHITE,
                                                  filled: true,
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          vertical: 10.0,
                                                          horizontal: 10.0),
                                                ),

                                                isExpanded: true,
                                                hint: const Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 0, 0, 0),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .calendar_view_day_rounded,
                                                        color: BLUE,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        "Select Week Off 2",
                                                        style: TextStyle(
                                                            color: GREY_DARK,
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                style: const TextStyle(
                                                  color: BLACK,
                                                  fontSize: 14,
                                                ),
                                                onChanged: (newValue) {
                                                  shiftController.weekOffSecond
                                                      .text = newValue!;
                                                  shiftController
                                                          .weekOffSecond.text =
                                                      shiftController
                                                          .weekOffSecond.text;
                                                },
                                                // value: leaveController
                                                //     .weekOffSecond.text,
                                                items: shiftController
                                                    .weekDayList2
                                                    .map((value) {
                                                  return DropdownMenuItem(
                                                    value: value,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 10.0,
                                                      ),
                                                      child: Text(value),
                                                    ),
                                                  );
                                                }).toList(),
                                              )
                                            ],
                                          )
                                        : const SizedBox(),
                                    const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10)),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          drawer: WeDrawer(),
          bottomNavigationBar: (shiftController.isLoadingadd.value)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: loadingWidget(),
                    ),
                  ],
                )
              : Container(
                  margin: EdgeInsets.only(
                    left: Get.height / 30,
                    right: Get.height / 30,
                    top: Get.height / 45,
                    bottom: Get.height / 45,
                  ),
                  child: ButtonWidget(
                    onPressed: () {
                      shiftController.addShift();
                      shiftController.update();
                    },
                    text: "Save",
                    buttonBorder: BLUE,
                    buttonColor: BLUE,
                    textcolor: WHITE,
                  ),
                ),
        );
      },
    );
  }
}
