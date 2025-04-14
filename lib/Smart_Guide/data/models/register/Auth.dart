// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
//
// class Auth1 {
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   User? get currentUser => _firebaseAuth.currentUser;
//   Stream<User?> get authState => _firebaseAuth.authStateChanges();
//
//   Future<void> create({
//     required String email,
//     required String password,
//   }) async {
//     await _firebaseAuth.createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//   }
// }
//
// class Auth extends StatelessWidget {
//   const Auth({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasData) {
//             return SplashScreen();
//           } else {
//             return RegisterScreen();
//           }
//         },
//       ),
//     );
//   }
// }
