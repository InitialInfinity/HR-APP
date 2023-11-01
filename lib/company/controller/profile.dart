import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:hr/classes/company.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import '../../constant.dart';
import '../../service.dart';
import '../view/companyhome.dart';
import '../view/companystaff/stafflist.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  final TextEditingController companyName = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController latitude = TextEditingController();
  final TextEditingController longitude = TextEditingController();
  final TextEditingController contactNo = TextEditingController();
  final TextEditingController emailId = TextEditingController();
  final TextEditingController isPFCtrl = TextEditingController();
  final TextEditingController isESICCtrl = TextEditingController();
  final TextEditingController isOvertimeCtrl = TextEditingController();
  RxString companyLogoImage = "".obs;
  RxString presentCount = "".obs;
  RxString absentCount = "".obs;
  RxString onLeaveCount = "".obs;
  RxString wfhCount = "".obs;
  Company company = Company();
  final fbKeyAddCompany = GlobalKey<FormBuilderState>();
  RxString dailystatus = "".obs;
  RxString isPF = '1'.obs;
  RxString isESIC = '1'.obs;
  RxString isOvertime = '1'.obs;
  RxInt isPFid = 1.obs;
  RxInt isESICid = 1.obs;
  RxInt isOvertimeid = 1.obs;
  RxList birthday = [].obs;
  RxList workAnniversary = [].obs;
  RxList onPresent = [].obs;
  RxList onAbsent = [].obs;
  RxList onLeave = [].obs;
  RxList onWFH = [].obs;
  @override
  void onInit() {
    getCompanyProfile();
    getDashboard();
    getPresent();
    getAbsent();
    getOnLeave();
    getOnWFH();
    greetings();
    getBirthday();
    getWorkAnniversary();
    super.onInit();
  }

  RxString greetings() {
    final timenow = TimeOfDay.now().hour;
    if (timenow < 12) {
      dailystatus.value = "Morning";
      return 'Morning'.obs;
    } else if ((timenow >= 12) && (timenow <= 16)) {
      dailystatus.value = "Afternoon";
      return 'Afternoon'.obs;
    } else if ((timenow > 16) && (timenow < 20)) {
      dailystatus.value = "Evening";
      return 'Evening'.obs;
    } else {
      dailystatus.value = "Night";
      return 'Night'.obs;
    }
  }

  getCompanyProfile() async {
    isLoading.value = true;
    Service.isLoading.value = true;
    var data = await Service.getCompanyProfile();
    Service.isLoading.value = false;
    isLoading.value = false;
    print(data);
    if (data["outcome"]["outcomeId"] == 1) {
      companyName.text = (data["data"]["CompanyName"] == null)
          ? "Unknown"
          : data["data"]["CompanyName"].toString();
      companyname.value = companyName.text;
      address.text = data["data"]["Address_line"].toString();
      latitude.text = data["data"]["Lattitude"].toString();
      longitude.text = data["data"]["Longitude"].toString();
      contactNo.text = data["data"]["ContactNo"].toString();
      emailId.text = data["data"]["EmailId"].toString();
      // isPF.value = data["data"]["IsPF"].toString();

      // isOvertimeid.value = int.parse(isPF.value.toString());
      // isESIC.value = data["data"]["IsESIC"].toString();
      // isESICid.value = int.parse(isESIC.value);

      isOvertime.value = data["data"]["IsOvertime"].toString();
      isOvertimeid.value = int.parse(isOvertime.value);
      emailid.value = emailId.text;
      var bytes = data["data"]["CompanyLogo"];

      // File? bytesImage;
      companyLogoImage.value = bytes;
      companyLogo.value = companyLogoImage.value;
      // bytesImage = const Base64Decoder().convert(bytes) as File?;

      // Service.image1 = bytesImage;
      print(Service.image1);
    } else {
      flutterToastMsg("No data");
    }
  }

  getUpdatedImage() async {
    var data = await Service.getUpdatedCompanyProfileImage();
    print(data);
    if (data["outcome"]["outcomeId"] == 1) {
      companyLogoImage.value = data["data"]["CompanyLogo"];
      print(companyLogoImage);
    }
  }

  getPresent() async {
    var data = await Service.getTodaysPresentData();
    print(data);
    if (data["outcome"]["outcomeId"] == 1) {
      onPresent.value = data["data"];
      print(onPresent);
    }
  }

  getAbsent() async {
    var data = await Service.getTodaysAbsentData();
    print(data);
    if (data["outcome"]["outcomeId"] == 1) {
      onAbsent.value = data["data"];
      print(onAbsent);
    }
  }

  getOnLeave() async {
    var data = await Service.getTodaysOnLeaveData();
    print(data);
    if (data["outcome"]["outcomeId"] == 1) {
      onLeave.value = data["data"];
      print(onLeave);
    }
  }

  getOnWFH() async {
    var data = await Service.getTodaysWFHData();
    print(data);
    if (data["outcome"]["outcomeId"] == 1) {
      onWFH.value = data["data"];
      print(onWFH);
    }
  }

  uploadImage() async {
    isLoading.value = true;
    company.companylogo = Service.image1!;
    var data = await Service.updateCompanyImage(company);
    getUpdatedImage();
    isLoading.value = false;
    print(data);
    if (data["outcome"]["outcomeId"] == 1) {
      flutterToastMsg("Image Uploaded Successfully");
    }
  }

  updateCompanyDetails() async {
    if (fbKeyAddCompany.currentState!.saveAndValidate()) {
      company.comapanyName = companyName.text;
      company.addressline = address.text;
      company.latitude = latitude.text;
      company.longitude = longitude.text;
      company.contactNo = contactNo.text;
      company.emailId = emailId.text;
      company.isPF = isPFCtrl.text;
      company.isESIC = isESICCtrl.text;
      company.isOvertime = isOvertimeCtrl.text;
      isLoading.value = true;
      var data = await Service.updateCompany(company);
      isLoading.value = false;
      if (data["outcome"]["outcomeId"] == 1) {
        Get.offAll(() => const CompanyHomePage());

        getCompanyProfile();
        flutterToastMsg(data["outcome"]["outcomeDetail"].toString());
      } else {
        flutterToastMsg("Something went wrong");
      }
      print(data);
    }
  }

  // addCompanyLogo() async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //     if (image == null) return;
  //     isLoading.value = true;
  //     Rx imageTemp = File(image.path).obs;

  //     Service.image1 = imageTemp.value;
  //     // companyLogoImage.value = imageTemp.toString();

  //     if (Service.image1 != null) {
  //       flutterToastMsg(
  //         "Photo uploaded successfully".toString(),
  //       );

  //       isLoading.value = false;

  //       update();
  //     } else {
  //       flutterToastMsg(
  //         "Error for uploading image",
  //       );
  //     }

  //     // });
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image: $e');
  //   }
  // }

  getDashboard() async {
    var data = await Service.getDashboard();
    print(data);
    for (var i in data["data"]) {
      presentCount.value = i["PresentCount"].toString();
      absentCount.value = i["AbsentStaff"].toString();
      onLeaveCount.value = i["OnLeaveStaff"].toString();
      wfhCount.value = i["WFHStaff"].toString();
    }
  }

  getBirthday() async {
    var data = await Service.getBirthday();
    print(data);
    if (data["outcome"]["outcomeId"] == 1) {
      birthday.value = data['data'];
    }
  }

  getWorkAnniversary() async {
    var data = await Service.getWorkAnnivesary();
    print(data);
    if (data["outcome"]["outcomeId"] == 1) {
      workAnniversary.value = data['data'];
    }
  }
}
