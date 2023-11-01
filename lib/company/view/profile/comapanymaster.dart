import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hr/company/controller/profile.dart';
import 'package:hr/company/view/companystaff/addstaff.dart';
import 'package:hr/widget/drawer.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constant.dart';
import '../../../location.dart';
import '../../../service.dart';
import '../../../widget/appbar.dart';
import '../../../widget/bottomnavigationbar.dart';
import '../../../widget/button.dart';
import '../../../widget/label.dart';
import '../../../widget/textformfield.dart';
import '../leave/leavemaster.dart';
import '../companystaff/stafflist.dart';

class CompanyMasterPage extends StatefulWidget {
  CompanyMasterPage({super.key});

  @override
  _CompanyMasterPageState createState() => _CompanyMasterPageState();
}

class _CompanyMasterPageState extends State<CompanyMasterPage> {
  @override
  void initState() {
    super.initState();
    setState(() {
      getCurrentLocation();
    });
  }

  bool? data;
  ProfileController profileController = Get.put(ProfileController());

  pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      var imageTemp = File(image.path);
      setState(() => Service.image1 = imageTemp);
      profileController.uploadImage();
      print(imageTemp);
      // });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  getCurrentLocation() async {
    LocationController locationController = Get.put(LocationController());
    await locationController.getCurrentPosition();
    setState(() {
      profileController.latitude.text = locationController.lat.value.toString();
      profileController.longitude.text =
          locationController.long.value.toString();
    });
    print(profileController.latitude.text);
    print(profileController.longitude.text);
  }

  @override
  Widget build(BuildContext context) {
    Uint8List convertBase64Image(String base64String) {
      return const Base64Decoder().convert(base64String.split(',').last);
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: WillPopScope(
        onWillPop: () async => true,
        child: SafeArea(
          child: Obx(
            () {
              return Column(
                children: [
                  AppBarWidget("Company Profile", false, () {}, true, false),
                  FormBuilder(
                    key: profileController.fbKeyAddCompany,
                    child: Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SingleChildScrollView(
                          child: (profileController.isLoading.value)
                              ? Center(child: loadingWidget())
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Stack(
                                      children: [
                                        (companyLogo.value == "")
                                            ? const CircleAvatar(
                                                foregroundColor:
                                                    Colors.transparent,
                                                radius: 40,
                                                // minRadius: 70,
                                                backgroundImage: AssetImage(
                                                  'assets/images/profile.jpg',
                                                ),
                                              )
                                            : Container(
                                                height: 100,
                                                width: 100,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: WHITE,
                                                ),
                                                child: ClipOval(
                                                  child: Image.memory(
                                                    convertBase64Image(
                                                        companyLogo.value),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                        Positioned(
                                          bottom: 1,
                                          right: 1,
                                          child: GestureDetector(
                                            onTap: () {
                                              pickImage();
                                            },
                                            child: Column(
                                              children: [
                                                Container(
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(4.0),
                                                    child: Icon(
                                                      Icons.add_a_photo,
                                                      color: BLUE,
                                                      size: 25,
                                                    ),
                                                  ),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: BLUE,
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(
                                                          50,
                                                        ),
                                                      ),
                                                      color: WHITE,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          offset: const Offset(
                                                              2, 4),
                                                          color: Colors.black
                                                              .withOpacity(
                                                            0.3,
                                                          ),
                                                          blurRadius: 3,
                                                        ),
                                                      ]),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10)),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        LabelWidget("Company Name"),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        normaltext("*", RED)
                                      ],
                                    ),
                                    TextFormFieldWidget(
                                      hinttext: "Enter Company Name",
                                      controller: profileController.companyName,
                                      errortext: "Enter Company Name",
                                      keyboardType: TextInputType.name,
                                      inputFormatter: r'[a-z A-Z , ]',
                                      prefixIcon: const Icon(
                                        Icons.business,
                                        color: BLUE,
                                      ),
                                      onTap: () {},
                                    ),
                                    const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10)),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                      controller: profileController.address,
                                      errortext: "Enter Address",
                                      keyboardType: TextInputType.name,
                                      inputFormatter: r'[a-z A-Z,0-9.:-()&]',
                                      prefixIcon: const Icon(
                                        Icons.location_city,
                                        color: BLUE,
                                      ),
                                      onTap: () {},
                                    ),
                                    const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10)),
                                    // LabelWidget("Latitude"),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        LabelWidget("Latitude"),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        normaltext("*", RED)
                                      ],
                                    ),
                                    TextFormFieldWidget(
                                      hinttext: "Latitude",
                                      controller: profileController.latitude,
                                      errortext: "Latitude",
                                      readonly: true,
                                      keyboardType: TextInputType.number,
                                      inputFormatter: r'[0-9 .]',
                                      prefixIcon: const Icon(
                                        Icons.location_on_outlined,
                                        color: BLUE,
                                      ),
                                      onTap: () {},
                                    ),
                                    const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10)),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        LabelWidget("Longitude"),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        normaltext("*", RED)
                                      ],
                                    ),
                                    TextFormFieldWidget(
                                      hinttext: "Longitude",
                                      controller: profileController.longitude,
                                      errortext: "Longitude",
                                      readonly: true,
                                      keyboardType: TextInputType.number,
                                      inputFormatter: r'[0-9 .]',
                                      prefixIcon: const Icon(
                                        Icons.location_on_outlined,
                                        color: BLUE,
                                      ),
                                      onTap: () {},
                                    ),
                                    const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10)),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                      controller: profileController.contactNo,
                                      errortext: "Enter Contact No",
                                      keyboardType: TextInputType.number,
                                      inputFormatter: r'[0-9]',
                                      prefixIcon: const Icon(
                                        Icons.phone,
                                        color: BLUE,
                                      ),
                                      onTap: () {},
                                    ),
                                    const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10)),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        LabelWidget("Email Id"),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        normaltext("*", RED)
                                      ],
                                    ),
                                    TextFormField(
                                        controller: profileController.emailId,
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
                                          hintText: "Enter Email Id",
                                          fillColor: Colors.white,
                                        ),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: validateEmail),
                                    const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10)),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Text("Is PF?",
                                            style: TextStyle(
                                              color: GREY_DARK,
                                            )),
                                        // const SizedBox(
                                        //   width: 4,
                                        // ),
                                        // normaltext("*", RED)
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Radio(
                                          value: 1,
                                          groupValue:
                                              profileController.isPFid.value,
                                          activeColor: BLUE,
                                          onChanged: (val) {
                                            setState(() {
                                              profileController.isPF.value =
                                                  'ONE';
                                              profileController.isPFid.value =
                                                  1;
                                              profileController.isPFCtrl.text =
                                                  profileController.isPFid.value
                                                      .toString();
                                            });
                                          },
                                        ),
                                        normaltext(
                                          'Yes',
                                          GREY_DARK,
                                        ),
                                        Radio(
                                          value: 0,
                                          groupValue:
                                              profileController.isPFid.value,
                                          activeColor: BLUE,
                                          onChanged: (val) {
                                            setState(() {
                                              profileController.isPF.value =
                                                  'ZERO';
                                              profileController.isPFid.value =
                                                  0;
                                              profileController.isPFCtrl.text =
                                                  profileController.isPFid.value
                                                      .toString();
                                            });
                                          },
                                        ),
                                        normaltext(
                                          'No',
                                          GREY_DARK,
                                        ),
                                      ],
                                    ),
                                    const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10)),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("Is ESIC?",
                                            style: TextStyle(
                                              color: GREY_DARK,
                                            )),
                                        // const SizedBox(
                                        //   width: 4,
                                        // ),
                                        // normaltext("*", RED)
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Radio(
                                          value: 1,
                                          groupValue:
                                              profileController.isESICid.value,
                                          activeColor: BLUE,
                                          onChanged: (val) {
                                            setState(() {
                                              profileController.isESIC.value =
                                                  'ONE';
                                              profileController.isESICid.value =
                                                  1;
                                              profileController
                                                      .isESICCtrl.text =
                                                  profileController
                                                      .isESICid.value
                                                      .toString();
                                            });
                                          },
                                        ),
                                        normaltext(
                                          'Yes',
                                          GREY_DARK,
                                        ),
                                        Radio(
                                          value: 0,
                                          groupValue:
                                              profileController.isESICid,
                                          activeColor: BLUE,
                                          onChanged: (val) {
                                            setState(() {
                                              profileController.isESIC.value =
                                                  'ZERO';
                                              profileController.isESICid.value =
                                                  0;
                                              profileController
                                                      .isESICCtrl.text =
                                                  profileController
                                                      .isESICid.value
                                                      .toString();
                                            });
                                          },
                                        ),
                                        normaltext(
                                          'No',
                                          GREY_DARK,
                                        ),
                                      ],
                                    ),
                                    const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10)),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("Is Overtime?",
                                            style: TextStyle(
                                              color: GREY_DARK,
                                            )),
                                        // const SizedBox(
                                        //   width: 4,
                                        // ),
                                        // normaltext("*", RED)
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Radio(
                                          value: 1,
                                          groupValue: profileController
                                              .isOvertimeid.value,
                                          activeColor: BLUE,
                                          onChanged: (val) {
                                            setState(() {
                                              profileController
                                                  .isOvertime.value = 'ONE';
                                              profileController
                                                  .isOvertimeid.value = 1;
                                              profileController
                                                      .isOvertimeCtrl.text =
                                                  profileController
                                                      .isOvertimeid.value
                                                      .toString();
                                            });
                                          },
                                        ),
                                        normaltext(
                                          'Yes',
                                          GREY_DARK,
                                        ),
                                        Radio(
                                          value: 0,
                                          groupValue: profileController
                                              .isOvertimeid.value,
                                          activeColor: BLUE,
                                          onChanged: (val) {
                                            setState(() {
                                              profileController
                                                  .isOvertime.value = 'ZERO';
                                              profileController
                                                  .isOvertimeid.value = 0;
                                              profileController
                                                      .isOvertimeCtrl.text =
                                                  profileController
                                                      .isOvertimeid.value
                                                      .toString();
                                            });
                                          },
                                        ),
                                        normaltext(
                                          'No',
                                          GREY_DARK,
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        left: Get.height / 30,
                                        right: Get.height / 30,
                                        top: Get.height / 15,
                                      ),
                                      child: ButtonWidget(
                                        onPressed: () {
                                          profileController
                                              .updateCompanyDetails();
                                          profileController.update();
                                          // Get.to(() => StaffListPage());
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
      bottomNavigationBar: BottomNavigationBarWidget(1),
    );
  }
}
