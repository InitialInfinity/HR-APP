import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:hr/company/companyregister.dart';
import 'package:hr/logincontroller.dart';
import 'package:hr/widget/textformfield.dart';
import 'company/view/profile/comapanymaster.dart';
import 'constant.dart';
import 'service.dart';
import 'widget/button.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage(this.role, {super.key});
  var role;
  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.put(LoginController());
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Obx(
        () {
          return SafeArea(
            child: FormBuilder(
              key: loginController.fbKeyforgotpass,
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: Get.height / 15,
                                  bottom: Get.height / 20),
                              child: Text(
                                "Forgot Password",
                                style: TextStyle(
                                  fontSize: Get.width / 18,
                                  color: BLUE,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.symmetric(
                                horizontal: Get.width / 15,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextFormFieldWidget(
                                    hinttext: "Mobile No",
                                    controller:
                                        loginController.mobileController,
                                    errortext: "Enter Mobile No",
                                    keyboardType: TextInputType.phone,
                                    inputFormatter: r'[0-9]',
                                    prefixIcon: const Icon(
                                      Icons.phone,
                                      color: BLUE,
                                    ),
                                    onTap: () {},
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormFieldWidget(
                                    hinttext: "Role",
                                    controller: loginController.roleController,
                                    errortext: "Enter role",
                                    readonly: false,
                                    keyboardType: TextInputType.visiblePassword,
                                    inputFormatter: r'[a-z A-Z]',
                                    prefixIcon: const Icon(
                                      Icons.person,
                                      color: BLUE,
                                    ),
                                    onTap: () {},
                                  ),
                            
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                left: Get.height / 30,
                                right: Get.height / 30,
                                top: Get.height / 15,
                              ),
                              child: (loginController.isLoading.value)
                                  ? loadingWidget()
                                  : ButtonWidget(
                                      onPressed: () {
                                        loginController.forgotPassword();
                                        loginController.update();
                                      },
                                      text: "Save",
                                      buttonBorder: BLUE,
                                      buttonColor: BLUE,
                                      textcolor: WHITE,
                                    ),
                            ),
                          ],
                        )
                      
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
