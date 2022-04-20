import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';


class ThemeServices {
  final GetStorage box = GetStorage();
  final key = 'isDarkMode';

   saveThemeToBox(bool isDarkMode) {
     box.write(key, isDarkMode);
  }

  bool loadThemeFromBox() {
     return box.read<bool>(key) ?? false;

  }

  ThemeMode get theme => loadThemeFromBox()? ThemeMode.dark : ThemeMode.light;

  void switchTheme() {
    Get.changeThemeMode(loadThemeFromBox()? ThemeMode.light:ThemeMode.dark);
    saveThemeToBox(!loadThemeFromBox());
  }
}
