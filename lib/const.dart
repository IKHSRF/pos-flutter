import 'package:flutter/material.dart';
import 'package:get/get.dart';

final List<String> menuItems = ['Home', 'Barang', 'Merek', 'Distributor'];
final List<IconData> menuIcons = [
  Icons.home_outlined,
  Icons.devices_other_outlined,
  Icons.museum_outlined,
  Icons.store_mall_directory_outlined,
];

class SideBar {
  static double xoffset = 60;
  static double yoffset = 0;
  static double pageScale = 1;
  static bool sidebarOpen = false;
  static int selectedMenuItem = 0;

  static void setPage() {
    switch (selectedMenuItem) {
      case 0:
        Get.toNamed('/home');
        break;
      case 1:
        Get.toNamed('/barang');
        break;
      case 2:
        Get.toNamed('/merek');
        break;
      case 3:
        Get.toNamed('/distributor');
        break;
    }
  }
}
