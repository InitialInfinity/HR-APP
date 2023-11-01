// ignore_for_file: depend_on_referenced_packages, no_logic_in_create_state, library_private_types_in_public_api

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr/changepassword.dart';
import 'package:hr/company/view/companyhome.dart';
import 'package:hr/company/view/profile/comapanymaster.dart';
import 'package:hr/company/view/leave/leavemaster.dart';
import 'package:hr/company/view/salary/salarylist.dart';
import 'package:hr/widget/popup.dart';
import '../company/view/companystaff/stafflist.dart';
import '../company/view/leaveapproval/leaveapproval.dart';
import '../company/view/shift/shift.dart';
import '../constant.dart';
import '../service.dart';

class WeDrawer extends StatefulWidget {
  WeDrawer({super.key}) {}
  @override
  _WeDrawerState createState() => _WeDrawerState();
}

class _WeDrawerState extends State<WeDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Uint8List convertBase64Image(String base64String) {
      return const Base64Decoder().convert(base64String.split(',').last);
    }

    return Obx(
      () {
        return Drawer(
          width: 270,
          backgroundColor: WHITE,
          child: ListView(
            // padding: EdgeInsets.zero,
            children: [
              Service.isLoading.value
                  ? Center(
                      child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: loadingWidget(),
                    ))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ListTile(
                            visualDensity: const VisualDensity(
                              horizontal: 4,
                            ),
                            horizontalTitleGap: 3,
                            minVerticalPadding: 15,
                            leading: (companyLogo.value == "")
                                ? const CircleAvatar(
                                    foregroundColor: Colors.transparent,
                                    radius: 40,
                                    // minRadius: 70,
                                    backgroundImage: AssetImage(
                                      'assets/images/profile.jpg',
                                    ),
                                  )
                                : Container(
                                    height: 60,
                                    width: 60,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: WHITE,
                                    ),
                                    child: ClipOval(
                                      child: Image.memory(
                                        convertBase64Image(companyLogo.value),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  companyname.value,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  emailid.value,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: GREY_DARK,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                            onTap: () {
                              Get.to(() => const CompanyHomePage());
                            },
                          ),
                        ),
                      ],
                    ),
              const Divider(
                thickness: 1,
                color: GREY_LIGHTER,
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                horizontalTitleGap: 0.5,
                leading: const Icon(
                  Icons.business_rounded,
                  color: BLUE,
                  size: 20,
                ),
                title: normaltext(
                  'Profile',
                  BLACK,
                ),
                onTap: () {
                  Get.to(() => CompanyMasterPage());
                },
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                ),
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                horizontalTitleGap: 0.5,
                leading: const Icon(
                  Icons.timelapse_outlined,
                  color: BLUE,
                  size: 20,
                ),
                title: normaltext(
                  'Shift',
                  BLACK,
                ),
                onTap: () {
                  Get.to(() => const ShiftList());
                },
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                ),
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                horizontalTitleGap: 0.5,
                leading: const Icon(
                  Icons.people,
                  color: BLUE,
                  size: 20,
                ),
                title: normaltext(
                  'Staff',
                  BLACK,
                ),
                onTap: () {
                  Get.to(() => const StaffListPage());
                },
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                ),
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                horizontalTitleGap: 0.5,
                leading: const Icon(
                  Icons.calendar_month,
                  color: BLUE,
                  size: 20,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                ),
                title: normaltext(
                  'Leave',
                  BLACK,
                ),
                onTap: () {
                  Get.to(() => const LeaveMasterPage());
                },
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                horizontalTitleGap: 0.5,
                leading: const Icon(
                  Icons.insert_page_break_outlined,
                  color: BLUE,
                  size: 20,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                ),
                title: normaltext(
                  'Leave Approval',
                  BLACK,
                ),
                onTap: () {
                  Get.to(() => const LeaveApproval());
                },
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                horizontalTitleGap: 0.5,
                leading: const Icon(
                  Icons.request_page_sharp,
                  color: BLUE,
                  size: 20,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                ),
                title: normaltext(
                  'Salary',
                  BLACK,
                ),
                onTap: () {
                  Get.to(() => const SalaryPage());
                },
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                horizontalTitleGap: 0.5,
                leading: const Icon(
                  Icons.lock_open_outlined,
                  color: BLUE,
                  size: 20,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                ),
                title: normaltext(
                  'Change Password',
                  BLACK,
                ),
                onTap: () {
                  Get.to(() => const ChangePasswordPage());
                },
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                horizontalTitleGap: 0.5,
                leading: const Icon(
                  Icons.logout_outlined,
                  color: BLUE,
                  size: 20,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                ),
                title: normaltext(
                  'Logout',
                  BLACK,
                ),
                onTap: () {
                  showMyDialog("", "Are you sure want to ", "logout ", "Logout",
                      () {
                    Service.logout();
                  });
                },
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                horizontalTitleGap: 0.5,
                leading: const Icon(
                  Icons.delete,
                  color: RED,
                  size: 20,
                ),
                title: normaltext(
                  'Delete Company',
                  RED,
                ),
                onTap: () {
                  showMyDialog(
                      "", "Are you sure want to  ", "Delete Company ", "Delete",
                      () {
                    // LoginController loginController = Get.put(LoginController());
                    Service.deleteCompany();
                    // Get.offAll(() => const LoginPage());
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
