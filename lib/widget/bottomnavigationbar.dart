import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr/company/view/profile/comapanymaster.dart';
import 'package:hr/company/view/report.dart';
import 'package:hr/company/view/salary/salarylist.dart';

import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../company/view/companyhome.dart';
import '../constant.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  int _selectedIndex = 0;
  BottomNavigationBarWidget(int selectedIndex, {super.key}) {
    _selectedIndex = selectedIndex;
  }
  @override
  _BottomNavigationBarWidgetState createState() =>
      _BottomNavigationBarWidgetState(_selectedIndex);
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _selectedIndex = 0;
  _BottomNavigationBarWidgetState(int selectedIndex) {
    _selectedIndex = selectedIndex;
  }

  void _onItemTapped(int index) async {
    if (index == 0) {
      Get.to(() => const CompanyHomePage());
    } else if (index == 1) {
      Get.offAll(() => CompanyMasterPage());
    } else if (index == 2) {
      Get.to(() => const SalaryPage());
    } else if (index == 3) {
      Get.to(() => const ReportPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5.0,
              offset: Offset(0, 0),
            ),
          ],
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          child: SalomonBottomBar(
            items: <SalomonBottomBarItem>[
              SalomonBottomBarItem(
                icon: const Icon(Icons.home),
                title: const Text("Home"),
                selectedColor: BLUE,
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.business_rounded),
                title: const Text("Profile"),
                selectedColor: BLUE,
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.request_page_sharp),
                title: const Text("Salary"),
                selectedColor: BLUE,
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.note_alt_rounded),
                title: const Text("Report"),
                selectedColor: BLUE,
              ),
            ],
            selectedItemColor: BLUE,
            onTap: _onItemTapped,
            currentIndex: _selectedIndex,
            unselectedItemColor: BLUE,
          ),
        ),
      ),
    );
  }
}
