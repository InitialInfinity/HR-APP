import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:hr/company/view/companystaff/editstaff.dart';

import '../../classes/staff.dart';
import '../../constant.dart';
import '../../service.dart';
import '../view/companystaff/stafflist.dart';

class StaffController extends GetxController {
  final TextEditingController staffName = TextEditingController();
  final TextEditingController emailId = TextEditingController();
  final TextEditingController empId = TextEditingController();
  final TextEditingController designation = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController basicSalary = TextEditingController();
  final TextEditingController contactNo = TextEditingController();
  final TextEditingController id = TextEditingController();
  final TextEditingController pfNo = TextEditingController();
  final TextEditingController accountNo = TextEditingController();
  final TextEditingController esicNo = TextEditingController();
  final TextEditingController dob = TextEditingController();
  final TextEditingController doj = TextEditingController();
  final TextEditingController workinghours = TextEditingController();
  final TextEditingController exitDate = TextEditingController();
  final TextEditingController shift = TextEditingController();
  RxString dateofBirth = "".obs;
  RxString dateofjoining = "".obs;
  RxString exitDatevalue = "".obs;
  RxString shiftvalue = "".obs;

  final fbKeyAddStaff = GlobalKey<FormBuilderState>();
  final fbKeyEditStaff = GlobalKey<FormBuilderState>();
  Staff staff = Staff();
  RxList staffList = [].obs;
  RxList shiftList = [].obs;
  RxBool isLoading = false.obs;
  RxBool isUpdate = false.obs;
  DateTime? checkdob = DateTime.now();
  @override
  void onInit() {
    getShift();
    getStaff();
    super.onInit();
  }

  getShift() async {
    isLoading.value = true;
    var data = await Service.getAllShiftDropDown();
    print(data);
    isLoading.value = false;
    if (data["outcome"]["outcomeId"] == 1) {
      shiftList.value = data["data"];
      print(shiftList);
    }
  }

  getStaff() async {
    isLoading.value = true;
    var data = await Service.getAllStaff();
    isLoading.value = false;
    if (data["outcome"]["outcomeId"] == 1) {
      staffList.value = data["data"];
      print(staffList);
    }
  }

  addStaff() async {
    isLoading.value = true;
    staff.staffName = staffName.text;
    staff.empId = empId.text;
    staff.emailId = emailId.text;
    staff.designation = designation.text;
    staff.address = address.text;
    staff.basic_Salary = basicSalary.text;
    staff.contact_No = contactNo.text;
    staff.pfNo = pfNo.text;
    staff.accountNo = accountNo.text;
    staff.esicNo = esicNo.text;
    staff.dob = dob.text;
    staff.doj = doj.text;
    staff.exitDate = exitDate.text;
    staff.workingHours = workinghours.text;

    var data = await Service.addStaffForCompany(staff);
    print(data);
    isLoading.value = false;
    if (data["outcome"]["outcomeId"] == 1) {
      flutterToastMsg(data["outcome"]["outcomeDetail"].toString());

      Get.offAll(() => const StaffListPage());
    } else {
      isLoading.value = false;
      flutterToastMsg("Something went wrong");
    }
  }

  deleteStaff(String staffId) async {
    isLoading.value = true;
    var data = await Service.deleteStaff(staffId);
    print(data);
    isLoading.value = false;
    if (data["outcome"]["outcomeId"] == 1) {
      flutterToastMsg(data["outcome"]["outcomeDetail"].toString());

      Get.offAll(() => const StaffListPage());
    } else {
      flutterToastMsg("Something went wrong");
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  updateStaff(var i) {
    isUpdate.value = true;
    staffName.text = i["StaffName"];
    shift.text = i["ShiftName"];
    contactNo.text = i["Contact_No"];
    empId.text = i["EmpId"];
    designation.text = i["Designation"];
    emailId.text = i["EmailId"];
    basicSalary.text = i["Basic_Salary"];
    address.text = i["Address"];
    id.text = i["Id"];
    workinghours.text = i["WorkingHours"];
    pfNo.text = i["PF_No"];
    esicNo.text = i["ESIC_No"];
    accountNo.text = i["Acc_No"];
    dob.text = i["DOB"];
    doj.text = i["DateOfJoining"];
    // exitDate.text = i["ExitDate"] == null ? "0" : i["ExitDate"];
    Get.to(() => EditStaffPage());
  }

  updateStaffSave() async {
    staff.id = id.text;
    staff.staffName = staffName.text;
    staff.emailId = emailId.text;
    staff.designation = designation.text;
    staff.address = address.text;
    staff.basic_Salary = basicSalary.text;
    staff.contact_No = contactNo.text;
    staff.pfNo = pfNo.text;
    staff.accountNo = accountNo.text;
    staff.esicNo = esicNo.text;
    staff.dob = dob.text;
    staff.doj = doj.text;
    staff.exitDate = exitDate.text;
    staff.workingHours = workinghours.text;
    isLoading.value = true;
    var data = await Service.updateStaffForCompany(staff);
    isLoading.value = false;
    print(data);
    if (data["outcome"]["outcomeId"] == 1) {
      flutterToastMsg(data["outcome"]["outcomeDetail"].toString());
      Get.offAll(() => const StaffListPage());
    } else {
      flutterToastMsg("Something went wrong");
    }
  }
}
