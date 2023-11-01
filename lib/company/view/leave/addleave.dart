import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:hr/company/controller/leave.dart';
import 'package:hr/company/view/leave/leavemaster.dart';
import 'package:hr/widget/drawer.dart';
import 'package:hr/widget/label.dart';

import '../../../constant.dart';
import '../../../widget/appbar.dart';
import '../../../widget/button.dart';
import '../../../widget/datepicker.dart';
import '../../../widget/dropdown.dart';
import '../../../widget/textformfield.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AddLeavePage extends StatelessWidget {
  const AddLeavePage({super.key});

  @override
  Widget build(BuildContext context) {
    LeaveController leaveController = Get.put(LeaveController());
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: Obx(
          () {
            return SafeArea(
              child: Column(
                children: [
                  AppBarWidget("Add Leave", false, () {}, true, true),
                  FormBuilder(
                    key: leaveController.fbKeyAddLeave,
                    child: Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10)),
                              Container(
                                  child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  for (var c in leaveController.titleList)
                                    // child: ElevatedButton(
                                    //   style: ElevatedButton.styleFrom(
                                    //     shape: RoundedRectangleBorder(
                                    //       borderRadius:
                                    //           BorderRadius.circular(10.0),
                                    //     ),
                                    //     backgroundColor: BLUE,
                                    //     side: BorderSide(color: BLUE),
                                    //   ),
                                    //   onPressed: () {
                                    //     leaveController.showWeekOffcontainer();
                                    //   },
                                    //   child: Text(
                                    //     "Add Week Off",
                                    //     style: TextStyle(
                                    //       color: WHITE,
                                    //       fontWeight: FontWeight.bold,
                                    //       fontSize: 10,
                                    //     ),
                                    //   ),
                                    // ),

                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: categoryContainer(
                                        leaveController.titleList.indexOf(
                                          c,
                                        ),
                                        c.toString(),
                                        leaveController
                                                    .selectedContainer.value ==
                                                leaveController.titleList
                                                    .indexOf(
                                                  c,
                                                )
                                            ? WHITE
                                            : BLUE,
                                        leaveController
                                                    .selectedContainer.value ==
                                                leaveController.titleList
                                                    .indexOf(
                                                  c,
                                                )
                                            ? BLUE
                                            : WHITE,
                                      ),
                                    ),
                                ],
                              )),
                              (leaveController.showHoliday.value == true)
                                  ? Column(
                                      children: [
                                        const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10)),
                                        // LabelWidget("Date"),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            LabelWidget("Date"),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            normaltext("*", RED)
                                          ],
                                        ),
                                        TextFormFieldWidget(
                                          controller:
                                              leaveController.selectDate,
                                          hinttext: "Select Date",
                                          keyboardType: TextInputType.none,
                                          errortext: "Select Date",
                                          inputFormatter: r'[a-z A-Z]',
                                          prefixIcon: const Icon(
                                            Icons.date_range,
                                            color: BLUE,
                                          ),
                                          onTap: () {
                                            showDatePickerLeaveDate(
                                                leaveController.selectDate,
                                                leaveController.date);
                                          },
                                        ),
                                        const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10)),
                                        // LabelWidget("Description"),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            LabelWidget("Description"),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            normaltext("*", RED)
                                          ],
                                        ),
                                        TextFormFieldWidget(
                                          controller:
                                              leaveController.addDescription,
                                          hinttext: "Add Description",
                                          errortext: "Enter Description",
                                          keyboardType: TextInputType.name,
                                          inputFormatter: r'[a-z A-Z , ]',
                                          maxline: 20,
                                          prefixIcon: const Icon(
                                            Icons.info,
                                            color: BLUE,
                                          ),
                                        ),
                                      ],
                                    )
                                  : const SizedBox(),
                              (leaveController.showLeave.value == true)
                                  ? Column(
                                      children: [
                                        const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10)),
                                        // LabelWidget("Staff Name"),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            LabelWidget("Staff Name"),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            normaltext("*", RED)
                                          ],
                                        ),
                                        DropdownButtonFormField(
                                          icon: const SizedBox(),
                                          decoration: InputDecoration(
                                            border: const OutlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: GREY),
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
                                            floatingLabelAlignment:
                                                FloatingLabelAlignment.start,
                                            alignLabelWithHint: false,
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
                                            prefixIcon: const Icon(
                                              Icons.person,
                                              color: BLUE,
                                              size: 18,
                                            ),
                                            suffixIcon: const Icon(
                                              Icons.keyboard_arrow_down,
                                              color: BLACK,
                                              size: 18,
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 10.0,
                                                    horizontal: 10.0),
                                            // contentPadding:
                                            //     EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            labelText: leaveController
                                                        .selectedStaffName
                                                        .text ==
                                                    ""
                                                ? "Select Staff Name"
                                                : leaveController
                                                    .selectedStaffName.text,

                                            labelStyle: const TextStyle(
                                              color: GREY_DARK,
                                              fontSize: 12,
                                            ),
                                            fillColor: WHITE,
                                            errorStyle:
                                                const TextStyle(color: RED),
                                          ),
                                          onChanged: (newValue) {
                                            leaveController.selectedStaffName
                                                .text = newValue.toString();
                                            leaveController.staffName.value =
                                                leaveController
                                                    .selectedStaffName.text;
                                          },
                                          items: leaveController.staffList
                                              .map((map) {
                                            return DropdownMenuItem(
                                              value: map["Id"],
                                              child: Text(
                                                map["StaffName"],
                                              ),
                                            );
                                          }).toList(),
                                          validator:
                                              FormBuilderValidators.compose([
                                            FormBuilderValidators.required(
                                                errorText: "Select Staff Name"),
                                          ]),
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
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: normaltext(
                                                  "Privilege Leave", GREY_DARK),
                                            ),
                                            normaltext("*", RED)
                                          ],
                                        ),
                                        TextFormFieldWidget(
                                          controller:
                                              leaveController.privilegeleave,
                                          hinttext: "Enter Privilege Leave",
                                          errortext: "Add Number of Days",
                                          keyboardType: TextInputType.number,
                                          inputFormatter: r'[0-9]',
                                          maxline: 20,
                                          prefixIcon: const Icon(
                                            Icons.logout,
                                            color: BLUE,
                                          ),
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
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: normaltext(
                                                  "Sick Leave", GREY_DARK),
                                            ),
                                            normaltext("*", RED)
                                          ],
                                        ),
                                        TextFormFieldWidget(
                                          controller: leaveController.sickleave,
                                          hinttext: "Enter Sick Leave",
                                          errortext: "Add Number of Days",
                                          keyboardType: TextInputType.number,
                                          inputFormatter: r'[0-9]',
                                          maxline: 20,
                                          prefixIcon: const Icon(
                                            Icons.local_hospital,
                                            color: BLUE,
                                          ),
                                        ),
                                      ],
                                    )
                                  : const SizedBox(),
                              (leaveController.showWeekOff.value == true)
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
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
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: normaltext(
                                                  "Select Week Off 1",
                                                  GREY_DARK),
                                            ),
                                            normaltext("*", RED)
                                          ],
                                        ),
                                        DropDownWidget(
                                          hinttext: "Select Week Off 1",
                                          errortext:
                                              "Select at least one Week Off",
                                          isExpanded: true,
                                          selectedvalue: leaveController
                                              .weekOffFirst.text
                                              .toString(),
                                          list: leaveController.weekDayList,
                                          controller:
                                              leaveController.weekOffFirst,
                                          icon: const Icon(
                                            Icons.calendar_view_day_rounded,
                                            color: BLUE,
                                          ),
                                        ),
                                        const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10)),
                                        // normaltext(
                                        //     "Select 2nd Week Off", GREY_DARK),

                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: normaltext(
                                                  "Select Week Off 2",
                                                  GREY_DARK),
                                            ),
                                          ],
                                        ),
                                        // DropDownWidget(
                                        //   hinttext: "Select Week Off 2",
                                        //   errortext: "Select Week Off 2",
                                        //   isExpanded: true,
                                        //   selectedvalue: leaveController
                                        //       .weekOffFirst.text
                                        //       .toString(),
                                        //   list: leaveController.weekDayList,
                                        //   controller:
                                        //       leaveController.weekOffSecond,
                                        //   icon: const Icon(
                                        //     Icons.calendar_view_day_rounded,
                                        //     color: BLUE,
                                        //   ),
                                        // ),

                                        DropdownButtonFormField(
                                          decoration: InputDecoration(
                                            border: const OutlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: GREY),
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
                                            fillColor: WHITE,
                                            filled: true,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
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
                                            leaveController.weekOffSecond.text =
                                                newValue!;
                                            leaveController.weekOffSecond.text =
                                                leaveController
                                                    .weekOffSecond.text;
                                          },
                                          // value: leaveController
                                          //     .weekOffSecond.text,
                                          items: leaveController
                                              .weekDayList.value
                                              .map((value) {
                                            return DropdownMenuItem(
                                              value: value,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
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
                              (leaveController.isLoading.value)
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: loadingWidget())
                                  : Container(
                                      margin: EdgeInsets.only(
                                        left: Get.height / 30,
                                        right: Get.height / 30,
                                        top: Get.height / 15,
                                      ),
                                      child: ButtonWidget(
                                        onPressed: () {
                                          if (leaveController
                                                  .showHoliday.value ==
                                              true) {
                                            leaveController.addHoliday();
                                            leaveController.update();
                                          } else if (leaveController
                                                  .showLeave.value ==
                                              true) {
                                            leaveController.addLeave();
                                            leaveController.update();
                                          } else if (leaveController
                                                  .showWeekOff.value ==
                                              true) {
                                            leaveController.addWeekOff();
                                            leaveController.update();
                                          } else {
                                            flutterToastMsg(
                                                "Choose one from above");
                                          }
                                        },
                                        text: "Save",
                                        buttonBorder: BLUE,
                                        buttonColor: BLUE,
                                        textcolor: WHITE,
                                      ),
                                    )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      drawer: WeDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: BLUE,
        foregroundColor: WHITE,
        onPressed: () {
          Get.to(() => const LeaveMasterPage());
        },
        child: Center(
            child: Icon(
          Icons.arrow_back_ios,
          size: 14,
        )),
      ),
    );
  }
}

categoryContainer(int index, String catName, Color txtColor, Color boxColor) {
  LeaveController leaveController = Get.put(LeaveController());
  return Container(
    alignment: Alignment.centerRight,
    height: 30,
    width: 90,
    decoration: BoxDecoration(
      color: boxColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: InkWell(
      child: Center(
        child: Text(
          catName,
          style: TextStyle(
            color: txtColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      onTap: () {
        leaveController.selectedContainer.value = index;
        if (leaveController.selectedContainer.value == 0) {
          leaveController.showWeekOffcontainer();
          leaveController.update();
        } else if (leaveController.selectedContainer.value == 1) {
          leaveController.showHolidaycontainer();
          leaveController.update();
        } else if (leaveController.selectedContainer.value == 2) {
          leaveController.showLeavecontainer();
          leaveController.update();
        }
        print(leaveController.selectedContainer.value);
      },
    ),
  );
}
