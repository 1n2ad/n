import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_guide_to_medication/Smart_Guide/data/models/register/cubit/state.dart';


class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());
  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  bool isButtonRegisterClicked = false;
  String selectedGender = '';

  void selectGender(String gender) {
    selectedGender = gender;
    emit(ShopRegisterGenderSelectedState());
  }


  /////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////
  bool isPasswordObscure = true;
  IconData icon = Icons.visibility;
  void changePasswordVisibility() {
    isPasswordObscure = !isPasswordObscure;
    icon = isPasswordObscure ? Icons.visibility : Icons.visibility_off;
    emit(ShopRegisterChangePasswordVisibilityState());
  }
}
