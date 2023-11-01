import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hr/constant.dart';

import 'login.dart';
import 'service.dart';
import 'staff/view/staffhome.dart';
import 'company/view/companyhome.dart';

class LoginController extends GetxController {
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController newpasswordController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  RxBool selectLoginTypeCompany = false.obs;
  RxBool selectLoginTypeStaff = false.obs;
  RxBool showBottom = false.obs;
  RxBool isLoading = false.obs;
  RxBool isLoading1 = false.obs;
  RxString lType = "".obs;

  final fbKeyLogin = GlobalKey<FormBuilderState>();
  final fbKeyforgotpass = GlobalKey<FormBuilderState>();
  final fbKeychangepass = GlobalKey<FormBuilderState>();
  @override
  void onInit() {
    super.onInit();
    // mobileController.text =
    //     (role.value == "ADMIN") ? "8828712177" : "9997774445";
    // passwordController.text = "1234@";
  }

  loginType() {
    if (lType.value == "Companay") {
      Service.role.value = "ADMIN";
      selectLoginTypeCompany.value = !selectLoginTypeCompany.value;
      selectLoginTypeStaff.value = false;
    } else if (lType.value == "STAFF") {
      Service.role.value = "STAFF";
      selectLoginTypeCompany.value = false;
      selectLoginTypeStaff.value = !selectLoginTypeStaff.value;
    }
  }

  login() async {
    if (fbKeyLogin.currentState!.saveAndValidate()) {
      // (role.value == "ADMIN") ? "8828712177" : "9997774445";
      // passwordController.text = "1234@";
      isLoading.value = true;
      var data = await Service.login(
          mobileController.text, passwordController.text, Service.role.value);
      print(data);
      if (data["outcomeId"] == 0) {
        isLoading.value = false;
        flutterToastMsg("Invalid Credential");
      } else if (data["result"]["outcome"]["outcomeId"] == 1) {
        await Service.storage.write(
            key: 'token',
            value: data["result"]["outcome"]["tokens"].toString());
        await Service.storage
            .write(key: 'id', value: data["result"]["data"]["Id"].toString());
        await Service.storage.write(
            key: 'companyId',
            value: data["result"]["data"]["CompanyId"].toString());
        await Service.storage.write(
            key: 'loginId',
            value: data["result"]["data"]["LoginId"].toString());
        await Service.storage
            .write(key: 'userId', value: data["result"]["userId"].toString());
        if (Service.role.value == "ADMIN" &&
            selectLoginTypeCompany.value == true) {
          flutterToastMsg("Login Successful");
          Get.to(() => const CompanyHomePage());
        } else if (Service.role.value == "STAFF" &&
            selectLoginTypeStaff.value == true) {
          flutterToastMsg("Login Successful");
          Get.to(() => const StaffHomePage());
        } else {
          isLoading.value = false;
          flutterToastMsg(
            "Select Company Or Staff From Above",
          );
        }
      }
      // } else if (Service.role.value == "ADMIN") {
      //   Get.to(() => const CompanyHomePage());
      // } else if (Service.role.value == "STAFF") {
      //   Get.to(() => const StaffHomePage());
      // } else {
      //   flutterToastMsg(
      //     "Select Company Or Staff From Above",
      //   );
      // }
      //   isLoading.value = false;
      //   if (Service.role.value == "ADMIN") {
      //     Get.to(() => const CompanyHomePage());
      //   } else if (Service.role.value == "STAFF") {
      //     Get.to(() => const StaffHomePage());
      //   } else {
      //     flutterToastMsg(
      //       "Invalid Credentials",
      //     );
      //   }
      // } else {
      //   flutterToastMsg(
      //     "Select Company Or Staff From Above",
      //   );
    }
  }

  logout() async {
    var resp = await Service.logout();
    print(resp);
  }

  forgotPassword() async {
    if (fbKeyforgotpass.currentState!.saveAndValidate()) {
      isLoading.value = true;
      var data = await Service.forgotPassword(
          mobileController.text, roleController.text);
      isLoading.value = false;
      print(data);
      if (data["outcome"]["outcomeId"] == 1) {
        flutterToastMsg("Login details will sent to your email");
        Get.offAll(() => const LoginPage());
      }
    }
  }

  resetPassword() async {
    if (fbKeychangepass.currentState!.saveAndValidate()) {
      isLoading1.value = true;
      var data = await Service.newPassword(
          mobileController.text,
          passwordController.text,
          newpasswordController.text,
          roleController.text);
      print(data);
      isLoading1.value = false;
      if (data["outcome"]["outcomeId"] == 1) {
        flutterToastMsg(data["outcome"]["outcomeDetail"]);
        Get.offAll(() => const LoginPage());
      }
    }
  }
}
