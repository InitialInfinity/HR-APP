import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constant.dart';
import '../../../widget/appbar.dart';
import '../../../widget/button.dart';
import '../../../widget/datepicker.dart';
import '../../../widget/dropdown.dart';
import '../../../widget/textformfield.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../controller/staffleave.dart';
import 'leave.dart';

class AddStaffLeavePage extends StatelessWidget {
  const AddStaffLeavePage({super.key});

  @override
  Widget build(BuildContext context) {
    StaffLeaveController leaveController = Get.put(StaffLeaveController());
    return Obx(
      () {
        return Scaffold(
          body: WillPopScope(
            onWillPop: () async => true,
            child: SafeArea(
              child: Column(
                children: [
                  AppBarWidget("Leave Application", false, () {}, false, true),
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  normaltext(
                                    "Select Leave Type",
                                    GREY_DARK,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  normaltext("*", RED)
                                ],
                              ),
                              const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5)),
                              DropDownWidget(
                                hinttext: "Select leave type",
                                errortext: "Select at least leave type",
                                isExpanded: true,
                                selectedvalue:
                                    leaveController.leaveType.text.toString(),
                                list: leaveController.leaveTypeAdd,
                                controller: leaveController.leaveType,
                                icon: const Icon(
                                  Icons.logout,
                                  color: BLUE,
                                ),
                              ),
                              const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  normaltext(
                                    "From Date",
                                    GREY_DARK,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  normaltext("*", RED)
                                ],
                              ),
                              const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5)),
                              TextFormFieldWidget(
                                controller: leaveController.fromDate,
                                hinttext: "From Date",
                                errortext: "Select from date",
                                keyboardType: TextInputType.none,
                                prefixIcon: const Icon(
                                  Icons.date_range,
                                  color: BLUE,
                                ),
                                onTap: () {
                                  showDatePickerLeaveDate(
                                      leaveController.fromDate,
                                      leaveController.fromDateValue);
                                },
                              ),
                              const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  normaltext(
                                    "To Date",
                                    GREY_DARK,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  normaltext("*", RED)
                                ],
                              ),
                              const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5)),
                              TextFormFieldWidget(
                                controller: leaveController.toDate,
                                hinttext: "To Date",
                                errortext: "Select to Date",
                                keyboardType: TextInputType.none,
                                prefixIcon: const Icon(
                                  Icons.date_range,
                                  color: BLUE,
                                ),
                                onTap: () {
                                  showDatePickerLeaveDate(
                                      leaveController.toDate,
                                      leaveController.toDateValue);
                                },
                              ),
                              const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  normaltext(
                                    "Leave Reason",
                                    GREY_DARK,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  normaltext("*", RED)
                                ],
                              ),
                              const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5)),
                              TextFormFieldWidget(
                                controller: leaveController.leaveReason,
                                hinttext: "Leave Reason",
                                errortext: "Enter Leave Reason",
                                keyboardType: TextInputType.name,
                                maxline: 50,
                                prefixIcon: const Icon(
                                  Icons.note,
                                  color: BLUE,
                                ),
                                onTap: () {},
                              ),
                              const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  normaltext(
                                    "No Of Days",
                                    GREY_DARK,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  normaltext("*", RED)
                                ],
                              ),
                              const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5)),
                              TextFormFieldWidget(
                                controller: leaveController.noOfDays,
                                hinttext: "No Of Days",
                                errortext: "Enter No. Of Days",
                                keyboardType: TextInputType.number,
                                maxline: 50,
                                prefixIcon: const Icon(
                                  Icons.format_list_numbered,
                                  color: BLUE,
                                ),
                                onTap: () {
                                  leaveController.calculateTravelDays();
                                },
                                readonly: true,
                              ),
                              const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  normaltext(
                                    "Contact No",
                                    GREY_DARK,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  normaltext("*", RED)
                                ],
                              ),
                              const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5)),
                              TextFormFieldWidget(
                                controller: leaveController.contactNo,
                                hinttext: "Contact Number",
                                errortext: "Enter Contact Number",
                                keyboardType: TextInputType.number,
                                maxline: 50,
                                prefixIcon: const Icon(
                                  Icons.call,
                                  color: BLUE,
                                ),
                                onTap: () {},
                              ),
                              const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10)),
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
          bottomNavigationBar: (leaveController.isLoading.value)
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: loadingWidget()),
                    ],
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(
                    left: Get.height / 30,
                    right: Get.height / 30,
                    bottom: Get.height / 30,
                  ),
                  child: ButtonWidget(
                    onPressed: () {
                      leaveController.addLeave();
                      leaveController.update();
                      // Get.to(() => const StaffLeaveMasterPage());
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
