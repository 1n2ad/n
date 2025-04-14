import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_guide_to_medication/Smart_Guide/layout/shop_layout/cubit/states.dart';
class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState()) {
  }
  static ShopCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
  ];
  bool isThemeContainerOpen = false;
  void changeThemeContainerStatus() {
    isThemeContainerOpen = !isThemeContainerOpen;
    emit(ShopSettingsChangeThemeContainerStatusState());
  }

  bool isLanguageContainerOpen = false;
  void changeLanguageContainerStatus() {
    isLanguageContainerOpen = !isLanguageContainerOpen;
    emit(ShopSettingsChangeLanguageContainerStatusState());
  }

  ThemeMode themeMode = ThemeMode.light;
  Color textColor = Colors.black;
  void changeThemeMode(ThemeMode newThemeMode, Color newTextColor)  {
    themeMode = newThemeMode;
    textColor = newTextColor;
    emit(ShopChangeThemeModeState());

  }

  int primaryColorIndex = 0;
  List defaultColors = [
    Colors.blue,
    Colors.teal,
    Colors.blue,
    Colors.deepOrange,
    Colors.deepPurple,
  ];
  dynamic primaryColor = Colors.blue;
  void changePrimaryColorIndex(int newIndex, dynamic color)  {
    primaryColorIndex = newIndex;
    primaryColor = color;
    emit(ShopChangePrimaryColorIndexState());

  }

  String appLanguage = 'ar';
  int changingLanguage = 0;
  void changeAppLanguage(String newValue) {
    appLanguage = newValue;
    changingLanguage = 1;
    emit(ShopChangeAppLanguageState());

  }

  void changeAppLanguageLoginRegister() {
    if (appLanguage == 'en') {
      appLanguage = 'ar';
    } else {
      appLanguage = 'en';
    }
    emit(ShopChangeAppLanguageState());

  void getAllSavedDataSharedPreferences() {
    int? pcIndex =
    primaryColor = defaultColors[primaryColorIndex];

  }
}}
