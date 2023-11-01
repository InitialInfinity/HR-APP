import 'dart:async';

import 'package:get/get.dart';
import 'package:hr/company/view/companyhome.dart';
import 'package:hr/staff/view/staffhome.dart';

import 'login.dart';
import 'service.dart';

class SplashController extends GetxController {
  late final Timer? timer;

  @override
  void onInit() {
    // timer = Timer(const Duration(seconds: 3), () async {
    //   Get.offAll(() => const LoginPage());
    // });
    checkLogin();
    super.onInit();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  checkLogin() async {
    var token = await Service.getToken();
    var companyId = await Service.getCompanyId();
    var loginId = await Service.getLoginId();
    var id = await Service.getId();
    if (companyId == null && token == null && loginId == null && id == null) {
      Get.offAll(() => const LoginPage());
    } else if (companyId == "" && token != "" && loginId != "" && id != "") {
      Get.to(() => const CompanyHomePage());
    } else if (companyId != "" && token != "" && id != "") {
      Get.to(() => const StaffHomePage());
    }
  }
}
