import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_guide_to_medication/Smart_Guide/Auth.dart';
import 'package:smart_guide_to_medication/Smart_Guide/data/models/register/register_screen.dart';
import 'package:smart_guide_to_medication/Smart_Guide/layout/shop_layout/cubit/cubit.dart';
import 'package:smart_guide_to_medication/Smart_Guide/layout/shop_layout/cubit/states.dart';
import 'package:smart_guide_to_medication/Smart_Guide/styles/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // تهيئة Firebase
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShopCubit>(
      create: (_) {
        if (null == null) {
          return ShopCubit();
        } else {
          return ShopCubit()
          ;
        }
      },
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (ctx, state) {},
        builder: (ctx, state) {
          ShopCubit cubit = ShopCubit.get(ctx);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: cubit.themeMode,
            theme: lightTheme(color: cubit.primaryColor),
            darkTheme: darkTheme(color: cubit.primaryColor),
            home: RegisterScreen(),
          );
        },
      ),
    );
  }
}
