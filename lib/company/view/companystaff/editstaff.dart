import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:hr/company/controller/staff.dart';
import 'package:hr/company/view/companystaff/stafflist.dart';
import 'package:hr/widget/drawer.dart';

import '../../../constant.dart';
import '../../../widget/appbar.dart';
import '../../../widget/bottomnavigationbar.dart';
import '../../../widget/button.dart';
import '../../../widget/datepicker.dart';
import '../../../widget/label.dart';
import '../../../widget/textformfield.dart';

class EditStaffPage extends StatelessWidget {
  EditStaffPage({super.key});
  var data;
  @override
  Widget build(BuildContext context) {
    StaffController staffController = Get.put(StaffController());
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: WillPopScope(
        onWillPop: () async => true,
        child: SafeArea(
          child: Column(
            children: [
              AppBarWidget("Edit Staff", false, () {}, true, false),
              FormBuilder(
                key: staffController.fbKeyEditStaff,
                child: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LabelWidget("Select Shift"),
                              const SizedBox(
                                width: 4,
                              ),
                              normaltext("*", RED)
                            ],
                          ),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: GREY),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(color: GREY),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(color: GREY),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(color: GREY),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(color: GREY),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(color: GREY),
                              ),
                              errorStyle: TextStyle(color: RED),
                              fillColor: WHITE,
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText: "Select Shift"),
                            ]),
                            isExpanded: true,
                            hint: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.filter_tilt_shift,
                                    color: BLUE,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    (staffController.shift.text == "")
                                        ? "Select Shift"
                                        : staffController.shift.text,
                                    style: TextStyle(
                                        color:
                                            (staffController.shift.text == "")
                                                ? GREY_DARK
                                                : BLACK,
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
                              staffController.shiftvalue.value =
                                  newValue.toString();
                              staffController.shift.text =
                                  staffController.shiftvalue.value;
                            },
                            items: staffController.shiftList.map((value) {
                              return DropdownMenuItem(
                                value: value['Id'],
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10.0,
                                  ),
                                  child: Text(value["ShiftDetails"]),
                                ),
                              );
                            }).toList(),
                            // value: staffController.shiftvalue.value,
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10)),
                          // LabelWidget("Staff Name"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LabelWidget("Staff Name"),
                              const SizedBox(
                                width: 4,
                              ),
                              normaltext("*", RED)
                            ],
                          ),
                          TextFormFieldWidget(
                            hinttext: "Enter Staff Name",
                            controller: staffController.staffName,
                            errortext: "Enter Staff Name",
                            keyboardType: TextInputType.name,
                            inputFormatter: r'[a-z A-Z]',
                            prefixIcon: const Icon(
                              Icons.person,
                              color: BLUE,
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10)),
                          // LabelWidget("Employee Id"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LabelWidget("Employee Id"),
                              const SizedBox(
                                width: 4,
                              ),
                              normaltext("*", RED)
                            ],
                          ),
                          TextFormFieldWidget(
                            hinttext: "Enter Employee Id",
                            controller: staffController.empId,
                            errortext: "Enter Employee Id",
                            keyboardType: TextInputType.number,
                            inputFormatter: r'[0-9]',
                            prefixIcon: const Icon(
                              Icons.person_add_sharp,
                              color: BLUE,
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10)),
                          // LabelWidget("Contact No"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LabelWidget("Contact No"),
                              const SizedBox(
                                width: 4,
                              ),
                              normaltext("*", RED)
                            ],
                          ),
                          TextFormFieldWidget(
                            hinttext: "Enter Contact No",
                            controller: staffController.contactNo,
                            errortext: "Enter Contact No",
                            keyboardType: TextInputType.number,
                            inputFormatter: r'[0-9]',
                            prefixIcon: const Icon(
                              Icons.phone,
                              color: BLUE,
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10)),
                          // LabelWidget("Designation"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LabelWidget("Designation"),
                              const SizedBox(
                                width: 4,
                              ),
                              normaltext("*", RED)
                            ],
                          ),
                          TextFormFieldWidget(
                            hinttext: "Enter Designation",
                            controller: staffController.designation,
                            errortext: "Enter Designation",
                            keyboardType: TextInputType.name,
                            inputFormatter: r'[a-z A-Z ,]',
                            prefixIcon: const Icon(
                              Icons.cast_for_education,
                              color: BLUE,
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10)),
                          // LabelWidget("Email Id"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LabelWidget("Email Id"),
                              const SizedBox(
                                width: 4,
                              ),
                              normaltext("*", RED)
                            ],
                          ),
                          TextFormField(
                              controller: staffController.emailId,
                              textCapitalization: TextCapitalization.words,
                              textAlign: TextAlign.left,
                              enabled: true,
                              style: const TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: BLUE,
                                ),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: GREY),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(color: GREY),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(color: GREY),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(color: GREY),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(color: GREY),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(color: GREY),
                                ),
                                filled: true,
                                hintStyle: const TextStyle(
                                  color: GREY_DARK,
                                  fontSize: 12,
                                ),
                                hintText: "Enter Email Id",
                                fillColor: Colors.white,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: validateEmail),
                          const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10)),
                          // LabelWidget("Basic Salary"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LabelWidget("Basic Salary"),
                              const SizedBox(
                                width: 4,
                              ),
                              normaltext("*", RED)
                            ],
                          ),
                          TextFormFieldWidget(
                            hinttext: "Enter Basic Salary",
                            controller: staffController.basicSalary,
                            errortext: "Enter Basic Salary",
                            keyboardType: TextInputType.number,
                            inputFormatter: r'[0-9]',
                            prefixIcon: const Icon(
                              Icons.request_page_sharp,
                              color: BLUE,
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10)),
                          // LabelWidget("Working Hours"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LabelWidget("Working Hours"),
                              const SizedBox(
                                width: 4,
                              ),
                              normaltext("*", RED)
                            ],
                          ),
                          TextFormFieldWidget(
                            hinttext: "Enter Working Hours",
                            controller: staffController.workinghours,
                            errortext: "Enter Working Hours",
                            keyboardType: TextInputType.datetime,
                            inputFormatter: r'[0-9 :]',
                            prefixIcon: const Icon(
                              Icons.av_timer_rounded,
                              color: BLUE,
                            ),
                            // onTap: () {},
                            onTap: () async {
                              // showTime(staffController.workinghours);
                            },
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10)),
                          // LabelWidget("Address"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LabelWidget("Address"),
                              const SizedBox(
                                width: 4,
                              ),
                              normaltext("*", RED)
                            ],
                          ),
                          TextFormFieldWidget(
                            hinttext: "Enter Address",
                            controller: staffController.address,
                            errortext: "Enter Address",
                            keyboardType: TextInputType.name,
                            inputFormatter: r'[a-z A-Z 0-9 , ]',
                            prefixIcon: const Icon(
                              Icons.location_on_outlined,
                              color: BLUE,
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10)),
                          // LabelWidget("PF No"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LabelWidget("PF No"),
                              const SizedBox(
                                width: 4,
                              ),
                              normaltext("*", RED)
                            ],
                          ),
                          TextFormFieldWidget(
                            hinttext: "Enter PF No",
                            controller: staffController.pfNo,
                            errortext: "Enter PF No",
                            keyboardType: TextInputType.number,
                            inputFormatter: r'[0-9]',
                            prefixIcon: const Icon(
                              Icons.numbers,
                              color: BLUE,
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10)),
                          // LabelWidget("Account No"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LabelWidget("Account No"),
                              const SizedBox(
                                width: 4,
                              ),
                              normaltext("*", RED)
                            ],
                          ),
                          TextFormFieldWidget(
                            hinttext: "Enter Account No",
                            controller: staffController.accountNo,
                            errortext: "Enter Account No",
                            keyboardType: TextInputType.number,
                            inputFormatter: r'[0-9]',
                            prefixIcon: const Icon(
                              Icons.account_balance,
                              color: BLUE,
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10)),
                          // LabelWidget("ESIC No"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LabelWidget("ESIC No"),
                              const SizedBox(
                                width: 4,
                              ),
                              normaltext("*", RED)
                            ],
                          ),
                          TextFormFieldWidget(
                            hinttext: "Enter ESIC No",
                            controller: staffController.esicNo,
                            errortext: "Enter ESIC No",
                            keyboardType: TextInputType.number,
                            inputFormatter: r'[0-9 A-Z a-z]',
                            prefixIcon: const Icon(
                              Icons.account_balance,
                              color: BLUE,
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10)),
                          // LabelWidget("Date Of Birth"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LabelWidget("Date Of Birth"),
                              const SizedBox(
                                width: 4,
                              ),
                              normaltext("*", RED)
                            ],
                          ),
                          TextFormFieldWidget(
                            hinttext: "Select Date Of Birth",
                            controller: staffController.dob,
                            errortext: "Select Date Of Birth",
                            keyboardType: TextInputType.none,
                            inputFormatter: r'[0-9 A-Z a-z]',
                            prefixIcon: const Icon(
                              Icons.date_range,
                              color: BLUE,
                            ),
                            onTap: () {
                              showDatePickerStaffDOB(staffController.dob,
                                  staffController.dateofBirth);
                            },
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10)),
                          // LabelWidget("Date Of "),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LabelWidget("Date Of Joining"),
                              const SizedBox(
                                width: 4,
                              ),
                              normaltext("*", RED)
                            ],
                          ),
                          TextFormFieldWidget(
                            hinttext: "Select Date Of Joining",
                            controller: staffController.doj,
                            errortext: "Select Date Of Joining",
                            keyboardType: TextInputType.none,
                            inputFormatter: r'[0-9 A-Z a-z]',
                            onTap: () {
                              showDatePickerStaffDOJ(staffController.doj,
                                  staffController.dateofjoining);
                            },
                            prefixIcon: const Icon(
                              Icons.calendar_month_rounded,
                              color: BLUE,
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10)),
                          // LabelWidget("Exit Date"),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     LabelWidget("Exit Date"),
                          //     const SizedBox(
                          //       width: 4,
                          //     ),
                          //     normaltext("*", RED)
                          //   ],
                          // ),
                          // TextFormFieldWidget(
                          //   hinttext: "Select Exit Date",
                          //   controller: staffController.exitDate,
                          //   errortext: "Select Exit Date",
                          //   keyboardType: TextInputType.none,
                          //   inputFormatter: r'[0-9 A-Z a-z]',
                          //   onTap: () {
                          //     showDatePickerStaffDOE(staffController.exitDate,
                          //         staffController.exitDatevalue);
                          //   },
                          //   prefixIcon: const Icon(
                          //     Icons.calendar_month_rounded,
                          //     color: BLUE,
                          //   ),
                          // ),
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
      bottomNavigationBar: Obx(
        () {
          return staffController.isLoading.value
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: loadingWidget(),
                    ),
                  ],
                )
              : Container(
                  margin: EdgeInsets.only(
                    left: Get.height / 30,
                    right: Get.height / 30,
                    // top: Get.height / 15,
                    bottom: Get.height / 25,
                  ),
                  child: ButtonWidget(
                    onPressed: () {
                      if (staffController.fbKeyEditStaff.currentState!
                          .saveAndValidate()) {
                        staffController.updateStaffSave();
                        staffController.update();
                      }
                    },
                    text: "Save",
                    buttonBorder: BLUE,
                    buttonColor: BLUE,
                    textcolor: WHITE,
                  ),
                );
        },
      ),
    );
  }
}
