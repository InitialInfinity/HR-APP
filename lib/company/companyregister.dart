import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:hr/location.dart';
import 'package:hr/login.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constant.dart';
import '../../../service.dart';
import '../../../widget/appbar.dart';
import '../../../widget/button.dart';
import '../../../widget/textformfield.dart';
import '../classes/company.dart';
import '../widget/label.dart';

class CompanyRegisterPage extends StatefulWidget {
  const CompanyRegisterPage({super.key});

  @override
  _CompanyRegisterPageState createState() => _CompanyRegisterPageState();
}

class _CompanyRegisterPageState extends State<CompanyRegisterPage> {
  @override
  void initState() {
    super.initState();
    setState(() {
      getCurrentLocation();
    });
  }

  bool? data;
  final TextEditingController companyName = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController latitude = TextEditingController();
  final TextEditingController longitude = TextEditingController();
  final TextEditingController contactNo = TextEditingController();
  final TextEditingController emailId = TextEditingController();
  final TextEditingController isPFCtrl = TextEditingController();
  final TextEditingController isESICCtrl = TextEditingController();
  final TextEditingController isOvertimeCtrl = TextEditingController();

  final fbKeyRegisterCompany = GlobalKey<FormBuilderState>();
  Company company = Company();
  String isPF = 'ONE';
  String isESIC = 'ONE';
  String isOvertime = 'ONE';
  int isPFid = 1;
  int isESICid = 1;
  int isOvertimeid = 1;
  bool isImage = false;
  bool isLoading = false;
  bool isLoadingSave = false;
  bool isLoadingSave1 = false;
  pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      var imageTemp = File(image.path);
      setState(() => Service.image1 = imageTemp);

      print(imageTemp);
      // });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  getCurrentLocation() async {
    LocationController locationController = Get.put(LocationController());
    setState(() {
      isLoading = true;
    });

    await locationController.getCurrentPosition();
    setState(() {
      latitude.text = locationController.lat.value.toString();
      longitude.text = locationController.long.value.toString();
      isLoading = false;
    });
    if (latitude.text != "0.0" && longitude.text != "0.0") {
      setState(() {
        isLoadingSave = false;
      });
      register();
    } else {
      getPermission();
    }
    print(latitude.text);
    print(longitude.text);
  }

  register() async {
    if (fbKeyRegisterCompany.currentState!.saveAndValidate()) {
      if (Service.image1 == null) {
        setState(() {
          isImage = true;
        });
      }
      setState(() {
        // isLoadingSave = true;
        isLoadingSave1 = true;
      });
      company.comapanyName = companyName.text;
      company.addressline = address.text;
      company.latitude = latitude.text;
      company.longitude = longitude.text;
      company.contactNo = contactNo.text;
      company.emailId = emailId.text;
      company.companylogo = Service.image1!;
      company.isPF = isPFCtrl.text;
      company.isESIC = isESICCtrl.text;
      company.isOvertime = isOvertimeCtrl.text;
      var data = await Service.registerCompany(company);
      setState(() {
        isLoadingSave1 = false;
      });
      if (data["outcome"]["outcomeId"] == 1) {
        Get.offAll(() => const LoginPage());
        setState(() {
          Service.role.value = "ADMIN";
        });

        flutterToastMsg("Company Registered!");
      } else {
        flutterToastMsg(data["outcome"]["outcomeDetail"].toString());
      }
      print(data);
    }
  }

  getPermission() async {
    LocationController locationController = Get.put(LocationController());
    await locationController.handleLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
          child: Column(
            children: [
              AppBarWidget("Company Profile", false, () {}, false, false),
              FormBuilder(
                key: fbKeyRegisterCompany,
                child: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: (isLoading)
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                    child: Column(
                                  children: [
                                    normaltext(
                                        "Location will be find please wait....",
                                        RED),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    loadingWidget()
                                  ],
                                )),
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Stack(
                                  children: [
                                    Service.image1 != null
                                        ? Container(
                                            height: 100,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.transparent,
                                              border: Border.all(
                                                color: WHITE,
                                              ),
                                            ),
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  pickImage();
                                                });
                                              },
                                              child: CircleAvatar(
                                                  radius: 40,
                                                  backgroundColor: Colors.grey,
                                                  backgroundImage: FileImage(
                                                      Service.image1!)),
                                            ),
                                          )
                                        : Column(
                                            children: [
                                              Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.transparent,
                                                  border: Border.all(
                                                    color: BLUE,
                                                  ),
                                                ),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        pickImage();
                                                      });
                                                    },
                                                    child: const Icon(
                                                      Icons.business,
                                                      size: 50,
                                                      color: BLUE,
                                                    )),
                                              ),
                                            ],
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
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: BLUE,
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(
                                                      50,
                                                    ),
                                                  ),
                                                  color: WHITE,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      offset:
                                                          const Offset(2, 4),
                                                      color: Colors.black
                                                          .withOpacity(
                                                        0.3,
                                                      ),
                                                      blurRadius: 3,
                                                    ),
                                                  ]),
                                              child: const Padding(
                                                padding: EdgeInsets.all(4.0),
                                                child: Icon(
                                                  Icons.add_a_photo,
                                                  color: BLUE,
                                                  size: 25,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                (isImage == true)
                                    ? smallText("Upload Company Logo", RED)
                                    : Container(),
                                const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  controller: companyName,
                                  errortext: "Enter Company Name",
                                  keyboardType: TextInputType.name,
                                  inputFormatter: r'[a-z A-Z]',
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
                                  controller: address,
                                  errortext: "Enter Company Address",
                                  keyboardType: TextInputType.name,
                                  inputFormatter: r'[a-zA-Z,0-9.:-()&]',
                                  prefixIcon: const Icon(
                                    Icons.location_city,
                                    color: BLUE,
                                  ),
                                  onTap: () {},
                                ),
                                const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  controller: latitude,
                                  errortext: "Latitude",
                                  keyboardType: TextInputType.none,
                                  inputFormatter: r'[0-9 .]',
                                  prefixIcon: const Icon(
                                    Icons.location_on_outlined,
                                    color: BLUE,
                                  ),
                                  onTap: () {},
                                  readonly: true,
                                ),
                                const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  controller: longitude,
                                  errortext: "Longitude",
                                  keyboardType: TextInputType.none,
                                  inputFormatter: r'[0-9 .]',
                                  prefixIcon: const Icon(
                                    Icons.location_on_outlined,
                                    color: BLUE,
                                  ),
                                  onTap: () {},
                                  readonly: true,
                                ),
                                const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10)),
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
                                  controller: contactNo,
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
                                  controller: emailId,
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
                                  validator: validateEmail,
                                ),
                                const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10)),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("Is PF?",
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Radio(
                                      value: 1,
                                      groupValue: isPFid,
                                      activeColor: BLUE,
                                      onChanged: (val) {
                                        setState(() {
                                          isPF = 'ONE';
                                          isPFid = 1;
                                          isPFCtrl.text = isPFid.toString();
                                        });
                                      },
                                    ),
                                    normaltext(
                                      'Yes',
                                      GREY_DARK,
                                    ),
                                    Radio(
                                      value: 0,
                                      groupValue: isPFid,
                                      activeColor: BLUE,
                                      onChanged: (val) {
                                        setState(() {
                                          isPF = 'ZERO';
                                          isPFid = 0;
                                          isPFCtrl.text = isPFid.toString();
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
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    // Text("Is ESIC?",
                                    //     style: TextStyle(
                                    //       color: GREY_DARK,
                                    //     )),
                                    // const SizedBox(
                                    //   width: 4,
                                    // ),
                                    // normaltext("*", RED)
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Radio(
                                      value: 1,
                                      groupValue: isESICid,
                                      activeColor: BLUE,
                                      onChanged: (val) {
                                        setState(() {
                                          isESIC = 'ONE';
                                          isESICid = 1;
                                          isESICCtrl.text = isESICid.toString();
                                        });
                                      },
                                    ),
                                    normaltext(
                                      'Yes',
                                      GREY_DARK,
                                    ),
                                    Radio(
                                      value: 0,
                                      groupValue: isESICid,
                                      activeColor: BLUE,
                                      onChanged: (val) {
                                        setState(() {
                                          isESIC = 'ZERO';
                                          isESICid = 0;
                                          isESICCtrl.text = isESICid.toString();
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
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Radio(
                                      value: 1,
                                      groupValue: isOvertimeid,
                                      activeColor: BLUE,
                                      onChanged: (val) {
                                        setState(() {
                                          isOvertime = 'ONE';
                                          isOvertimeid = 1;
                                          isOvertimeCtrl.text =
                                              isOvertimeid.toString();
                                        });
                                      },
                                    ),
                                    normaltext(
                                      'Yes',
                                      GREY_DARK,
                                    ),
                                    Radio(
                                      value: 0,
                                      groupValue: isOvertimeid,
                                      activeColor: BLUE,
                                      onChanged: (val) {
                                        setState(() {
                                          isOvertime = 'ZERO';
                                          isOvertimeid = 0;
                                          isOvertimeCtrl.text =
                                              isOvertimeid.toString();
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
                                (isLoadingSave)
                                    ? loadingWidget()
                                    : Container(
                                        margin: EdgeInsets.only(
                                          left: Get.height / 30,
                                          right: Get.height / 30,
                                          top: Get.height / 15,
                                        ),
                                        child: ButtonWidget(
                                          onPressed: () async {
                                            if (Service.image1 == null) {
                                              setState(() {
                                                isImage = true;
                                              });
                                            } else if (latitude.text == "0.0" &&
                                                longitude.text == "0.0") {
                                              getPermission();

                                              getCurrentLocation();
                                            } else {
                                              register();
                                            }
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
          ),
        ),
      ),
    );
  }
}
