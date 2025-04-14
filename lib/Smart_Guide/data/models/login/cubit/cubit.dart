import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_guide_to_medication/Smart_Guide/data/models/login/cubit/state.dart';


class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);

  bool isButtonLoginClicked = false;

  bool isPasswordObscure = true;
  IconData icon = Icons.visibility;
  void changePasswordVisibility() {
    isPasswordObscure = !isPasswordObscure;
    icon = isPasswordObscure ? Icons.visibility : Icons.visibility_off;
    emit(ShopLoginChangePasswordVisibilityState());
  }
}
