import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:hr/company/controller/salary.dart';
import 'package:hr/widget/drawer.dart';
import 'package:hr/widget/label.dart';

import '../../../constant.dart';
import '../../../widget/appbar.dart';
import '../../../widget/bottomnavigationbar.dart';
import '../../../widget/button.dart';
import '../../../widget/datepicker.dart';
import '../../../widget/textformfield.dart';

class AddSalaryPage extends StatelessWidget {
  const AddSalaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    SalaryController salaryController = Get.put(SalaryController());
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: WillPopScope(
        onWillPop: () async => true,
        child: SafeArea(
          child: Obx(
            () {
              return Column(
                children: [
                  AppBarWidget("Add Salary", false, () {}, true, true),
                  FormBuilder(
                    key: salaryController.fbKeyAddSalary,
                    child: Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SingleChildScrollView(
                          child: (salaryController.isLoading.value)
                              ? Center(child: loadingWidget())
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            showMonth("en",
                                                salaryController.salarymonth);
                                          },
                                          child: Container(
                                            width: 130,
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              border: Border.all(color: BLUE),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: normaltext(
                                                salaryController
                                                    .salarymonth.value
                                                    .toString(),
                                                BLUE,
                                                FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showYear("en",
                                                salaryController.salaryyear);
                                          },
                                          child: Container(
                                            width: 130,
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              border: Border.all(color: BLUE),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: normaltext(
                                                salaryController
                                                    .salaryyear.value
                                                    .toString(),
                                                BLUE,
                                                FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10)),
                                    LabelWidget("Staff Name"),
                                    DropdownButtonFormField(
                                      icon: const SizedBox(),
                                      isExpanded: true,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
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
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide:
                                              const BorderSide(color: GREY),
                                        ),
                                        filled: true,
                                        prefixIcon: Icon(
                                          Icons.person,
                                          color: BLUE,
                                          size: 18,
                                        ),
                                        isDense: true,
                                        suffixIcon: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: GREY_DARK,
                                          size: 18,
                                        ),
                                        contentPadding:
                                            EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        labelText:
                                            (salaryController.staffName.value ==
                                                    "")
                                                ? "Select Staff Name"
                                                : "",
                                        labelStyle: TextStyle(
                                          color: GREY_DARK,
                                          fontSize: 12,
                                        ),
                                        fillColor: WHITE,
                                        errorStyle: TextStyle(color: RED),
                                      ),
                                      onChanged: (newValue) {
                                        salaryController.selectedstaff.text =
                                            newValue.toString();
                                        salaryController.staffName.value =
                                            salaryController.selectedstaff.text;
                                        salaryController.getBasicSalary(
                                            salaryController
                                                .selectedstaff.text);
                                        salaryController.getPresentDays(
                                            salaryController
                                                .selectedstaff.text);
                                      },
                                      items:
                                          salaryController.staffList.map((map) {
                                        return DropdownMenuItem(
                                          value: map["Id"],
                                          child: Text(
                                            map["StaffName"],
                                          ),
                                        );
                                      }).toList(),
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(
                                            errorText: "Select Staff Name"),
                                      ]),
                                    ),
                                    const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10)),
                                    LabelWidget("Basic Salary"),
                                    TextFormFieldWidget(
                                      hinttext: "Enter Basic Salary",
                                      controller: salaryController.basicSalary,
                                      errortext: "Enter Basic Salary",
                                      keyboardType: TextInputType.number,
                                      inputFormatter: r'[0-9,.]',
                                      readonly: true,
                                      prefixIcon: const Icon(
                                        Icons.request_page_sharp,
                                        color: BLUE,
                                      ),
                                      onTap: () {},
                                    ),
                                    const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10)),
                                    LabelWidget("Present Days"),
                                    TextFormFieldWidget(
                                      hinttext: "Enter Present Days",
                                      controller: salaryController.presentDays,
                                      errortext: "Enter Present Days",
                                      keyboardType: TextInputType.number,
                                      inputFormatter: r'[0-9,.]',
                                      readonly: true,
                                      prefixIcon: const Icon(
                                        Icons.calendar_month,
                                        color: BLUE,
                                      ),
                                      onTap: () {},
                                    ),
                                    const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10)),
                                    LabelWidget("Bonus"),
                                    TextFormFieldWidget(
                                      hinttext: "Enter Bonus",
                                      controller: salaryController.bonus,
                                      errortext: "Enter Bonus",
                                      keyboardType: TextInputType.number,
                                      inputFormatter: r'[0-9,.]',
                                      prefixIcon: const Icon(
                                        Icons.request_page_sharp,
                                        color: BLUE,
                                      ),
                                      onTap: () {},
                                    ),
                                    const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10)),
                                    LabelWidget("Tax"),
                                    TextFormFieldWidget(
                                      hinttext: "Enter Tax",
                                      controller: salaryController.tax,
                                      errortext: "Enter Tax",
                                      keyboardType: TextInputType.number,
                                      inputFormatter: r'[0-9,.]',
                                      prefixIcon: const Icon(
                                        Icons.local_offer,
                                        color: BLUE,
                                      ),
                                      onTap: () {},
                                    ),
                                    const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10)),
                                    LabelWidget("Other Allowance"),
                                    TextFormFieldWidget(
                                      hinttext: "Enter Other Allowance",
                                      controller:
                                          salaryController.otherAllowance,
                                      errortext: "Enter Other Allowance",
                                      keyboardType: TextInputType.number,
                                      inputFormatter: r'[0-9,.]',
                                      prefixIcon: const Icon(
                                        Icons.info,
                                        color: BLUE,
                                      ),
                                      onTap: () {},
                                    ),
                                    const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10)),
                                    LabelWidget("PF Amount"),
                                    TextFormFieldWidget(
                                      hinttext: "Enter PF Amount",
                                      controller: salaryController.pfAmount,
                                      errortext: "Enter PF Amount",
                                      keyboardType: TextInputType.number,
                                      inputFormatter: r'[0-9]',
                                      readonly: false,
                                      prefixIcon: const Icon(
                                        Icons.currency_rupee,
                                        color: BLUE,
                                      ),
                                      onTap: () {},
                                    ),
                                    const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10)),
                                    LabelWidget("ESIC Amount"),
                                    TextFormFieldWidget(
                                      hinttext: "Enter ESIC Amount",
                                      controller: salaryController.esicAmount,
                                      errortext: "Enter ESIC Amount",
                                      keyboardType: TextInputType.number,
                                      inputFormatter: r'[0-9]',
                                      readonly: false,
                                      prefixIcon: const Icon(
                                        Icons.currency_rupee,
                                        color: BLUE,
                                      ),
                                      onTap: () {},
                                    ),
                                    const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10)),
                                    LabelWidget("Overtime"),
                                    TextFormFieldWidget(
                                      hinttext: "Enter Overtime",
                                      controller: salaryController.overtime,
                                      errortext: "Enter ovetime",
                                      keyboardType: TextInputType.datetime,
                                      inputFormatter: r'[0-9 :]',
                                      readonly: false,
                                      prefixIcon: const Icon(
                                        Icons.punch_clock_rounded,
                                        color: BLUE,
                                      ),
                                      onTap: () {},
                                    ),
                                    const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10)),
                                    LabelWidget("Overtime Per Hour"),
                                    TextFormFieldWidget(
                                      hinttext: "Enter Overtime Per Hour",
                                      controller:
                                          salaryController.overtimePerhours,
                                      errortext: "Enter ovetime Per Hour",
                                      keyboardType: TextInputType.datetime,
                                      inputFormatter: r'[0-9 : ]',
                                      readonly: false,
                                      prefixIcon: const Icon(
                                        Icons.currency_rupee,
                                        color: BLUE,
                                      ),
                                      onTap: () {},
                                    ),
                                    (salaryController.isLoading.value)
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: loadingWidget())
                                        : Container(
                                            margin: EdgeInsets.only(
                                              left: Get.height / 30,
                                              right: Get.height / 30,
                                              top: Get.height / 15,
                                            ),
                                            child: ButtonWidget(
                                              onPressed: () {
                                                salaryController.addSalary();
                                                salaryController.update();
                                              },
                                              text: "Save",
                                              buttonBorder: BLUE,
                                              buttonColor: BLUE,
                                              textcolor: WHITE,
                                            ),
                                          ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      drawer: WeDrawer(),
      bottomNavigationBar: BottomNavigationBarWidget(2),
    );
  }
}
