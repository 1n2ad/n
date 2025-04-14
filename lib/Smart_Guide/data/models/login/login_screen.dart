// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:smart_guide_to_medication/Smart_Guide/layout/shop_layout/cubit/cubit.dart';
// import 'package:smart_guide_to_medication/Smart_Guide/presentation/pages/MainScreen.dart';
// import 'package:smart_guide_to_medication/Smart_Guide/shared/components/components.dart';
// import 'package:smart_guide_to_medication/Smart_Guide/shared/constant/constant.dart';
// import 'package:smart_guide_to_medication/Smart_Guide/styles/fonts_style.dart';
//
// class RegisterScreen extends StatefulWidget {
//   @override
//   _RegisterScreenState createState() => _RegisterScreenState();
// }
//
// class _RegisterScreenState extends State<RegisterScreen> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   bool _isLoading = false;
//
//   Future<void> _registerWithFirebase() async {
//     if (!_formKey.currentState!.validate()) return;
//     setState(() => _isLoading = true);
//     try {
//       UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: _emailController.text,
//         password: _passwordController.text,
//       );
//
//       String userId = userCredential.user!.uid;
//       await FirebaseFirestore.instance.collection('users').doc(userId).set({
//         'username': _usernameController.text,
//         'email': _emailController.text,
//         'phone': _phoneController.text,
//       });
//       navigateAndFinish(context, MainScreen());
//     } on FirebaseAuthException catch (e) {
//       String errorMessage = e.message ?? 'An error occurred';
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<ShopCubit>(
//       create: (_) => ShopCubit(),
//       child: BlocBuilder<ShopCubit, ShopState>(
//         builder: (ctx, state) {
//           ShopCubit shopCubit = ShopCubit.get(ctx);
//           return Scaffold(
//             appBar: AppBar(title: Text('Register')),
//             body: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Create an Account', style: getLightStyle(fontSize: 18)),
//                     const SizedBox(height: 20),
//                     defaultTextField(
//                       controller: _usernameController,
//                       labelText: 'Username',
//                       validateFun: (value) => value!.isEmpty ? 'Enter username' : null,
//                     ),
//                     defaultTextField(
//                       controller: _emailController,
//                       labelText: 'Email',
//                       keyboardType: TextInputType.emailAddress,
//                       validateFun: (value) => value!.isEmpty ? 'Enter valid email' : null,
//                     ),
//                     defaultTextField(
//                       controller: _passwordController,
//                       labelText: 'Password',
//                       obscureText: true,
//                       validateFun: (value) => value!.length < 6 ? 'Password too short' : null,
//                     ),
//                     defaultTextField(
//                       controller: _phoneController,
//                       labelText: 'Phone Number',
//                       keyboardType: TextInputType.phone,
//                       validateFun: (value) => value!.isEmpty ? 'Enter phone number' : null,
//                     ),
//                     const SizedBox(height: 20),
//                     ConditionalBuilder(
//                       condition: !_isLoading,
//                       builder: (_) => ElevatedButton(
//                         onPressed: _registerWithFirebase,
//                         child: Text('Register'),
//                       ),
//                       fallback: (_) => Center(child: CircularProgressIndicator()),
//                     ),
//                     const SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text("Already have an account?"),
//                         defaultTextButton(
//                           btnText: "Login",
//                           btnFunction: () => Navigator.pop(context),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }