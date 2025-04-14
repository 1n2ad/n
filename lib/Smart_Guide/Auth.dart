import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_guide_to_medication/Smart_Guide/layout/shop_layout/cubit/cubit.dart';
import 'package:smart_guide_to_medication/Smart_Guide/layout/shop_layout/cubit/states.dart';
import 'package:smart_guide_to_medication/Smart_Guide/styles/fonts_style.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Auth1();
  }
}
class Auth1 extends StatefulWidget {
  const Auth1({super.key});

  @override
  State<Auth1> createState() => _Auth1State();
}

class _Auth1State extends State<Auth1> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShopCubit>(
        create: (_) {
          return ShopCubit();
        },
        child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (ctx, state) {},
    builder: (ctx, state) {
    ShopCubit cubit = ShopCubit.get(ctx);
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.account_circle,color: cubit.primaryColor,),
        title: Text('Smart_Guide_to_Medication',style: getBoldStyle(color: cubit.textColor),),
      ),
    );
  }));}
}
