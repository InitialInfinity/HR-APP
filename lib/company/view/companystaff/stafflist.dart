import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr/company/controller/staff.dart';
import 'package:hr/company/view/companystaff/addstaff.dart';
import 'package:hr/company/view/companystaff/editstaff.dart';
import 'package:hr/widget/drawer.dart';

import '../../../constant.dart';
import '../../../widget/appbar.dart';
import '../../../widget/bottomnavigationbar.dart';
import '../../../widget/button.dart';
import '../../../widget/listtile.dart';
import '../../../widget/listtileclmname.dart';
import '../../../widget/popup.dart';
import '../../../widget/textformfield.dart';

class StaffListPage extends StatelessWidget {
  const StaffListPage({super.key});

  @override
  Widget build(BuildContext context) {
    StaffController staffController = Get.put(StaffController());
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
          child: Obx(
            () {
              return Column(
                children: [
                  AppBarWidget("Staff", true, () {
                    Get.to(() => AddStaffPage());
                    // staffController.update();
                  }, true, false),
                  (staffController.isLoading.value)
                      ? Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Center(child: loadingWidget()),
                        )
                      : Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SingleChildScrollView(
                              child: (staffController.staffList.isEmpty == true)
                                  ? const Center(
                                      child: Text(
                                        "There is no added staff member.\nPlease add staff from above add icon.",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: BLUE,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const ListTileColumNameWidget(
                                          "Staff Name",
                                          clumnname2: "Mobile",
                                          clumnname3: "Action",
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        for (var i in staffController.staffList)
                                          ListTileWidget(
                                            name: (i["StaffName"]) == null
                                                ? "no Name"
                                                : i["StaffName"],
                                            contactno: i["Contact_No"],
                                            onTapEdit: () {
                                              staffController.updateStaff(i);
                                            },
                                            onTap: () {
                                              return null;
                                            },
                                            onTapDelete: () {
                                              showMyDialog(
                                                  i,
                                                  "Are you sure to delete ",
                                                  i["StaffName"],
                                                  "Delete", () {
                                                staffController
                                                    .deleteStaff(i["Id"]);
                                              });

                                              staffController.update();
                                            },
                                          ),
                                      ],
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
    );
  }
}
