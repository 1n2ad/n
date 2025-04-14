import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_guide_to_medication/Smart_Guide/data/models/AddMedicineScreen.dart';
import 'package:smart_guide_to_medication/Smart_Guide/data/models/MedicinesListScreen.dart';
import 'package:smart_guide_to_medication/Smart_Guide/data/models/MedicinesListuser.dart';
import 'package:smart_guide_to_medication/Smart_Guide/presentation/pages/MainScreen.dart';
import 'package:smart_guide_to_medication/Smart_Guide/shared/components/components.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPharmacy = false;

  final Map<String, TextEditingController> _controllers = {
    'username': TextEditingController(),
    'email': TextEditingController(),
    'password': TextEditingController(),
    'phone': TextEditingController(),
    'location': TextEditingController(),
    'pharmacyNameAr': TextEditingController(),
    'pharmacyNameEn': TextEditingController(),
    'bankAccount': TextEditingController(),
    'binanceKey': TextEditingController(),
    'payerKey': TextEditingController(),
    'pharmacyDesc': TextEditingController(),
  };

  Future<void> _registerWithFirebase() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _controllers['email']!.text,
        password: _controllers['password']!.text,
      );

      String userId = userCredential.user!.uid;
      Map<String, dynamic> userData = {
        'username': _controllers['username']!.text,
        'email': _controllers['email']!.text,
        'phone': _controllers['phone']!.text,
        'location': _controllers['location']!.text,
      };


      if (_isPharmacy) {
        Map<String, dynamic> pharmacyData = {
          'pharmacyNameAr': _controllers['pharmacyNameAr']!.text,
          'pharmacyNameEn': _controllers['pharmacyNameEn']!.text,
          'bankAccount': _controllers['bankAccount']!.text,
          'binanceKey': _controllers['binanceKey']!.text,
          'payerKey': _controllers['payerKey']!.text,
          'pharmacyDesc': _controllers['pharmacyDesc']!.text,
          'phone': _controllers['phone']!.text,
          'location': _controllers['location']!.text,
        };
        await FirebaseFirestore.instance.collection('pharmacies').doc(userId).set(pharmacyData);
      } else {
        userData['isPharmacy'] = _isPharmacy;
        await FirebaseFirestore.instance.collection('users').doc(userId).set(userData);
      }

      navigateAndFinish(context, MedicinesListuser());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("حدث خطأ: ${e.toString()}")));
    }
  }

  Widget _buildTextField(String label, String controllerKey, {bool obscureText = false, TextInputType? keyboardType}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
          SizedBox(height: 3),
          TextField(
            controller: _controllers[controllerKey],
            obscureText: obscureText,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.blueGrey.shade900, Colors.blueGrey.shade600], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: Colors.white.withOpacity(0.95),
              elevation: 10,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                decoration: BoxDecoration(
                                  color: _isPharmacy ? Colors.grey.shade300 : Colors.blueGrey.shade800,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextButton(
                                  onPressed: () => setState(() => _isPharmacy = false),
                                  child: Text('مستخدم', style: TextStyle(color: _isPharmacy ? Colors.black : Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                decoration: BoxDecoration(
                                  color: !_isPharmacy ? Colors.grey.shade300 : Colors.blueGrey.shade800,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextButton(
                                  onPressed: () => setState(() => _isPharmacy = true),
                                  child: Text('صيدلية', style: TextStyle(color: !_isPharmacy ? Colors.black : Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            _buildTextField('اسم المستخدم', 'username'),
                            _buildTextField('البريد الإلكتروني', 'email', keyboardType: TextInputType.emailAddress),
                            _buildTextField('كلمة المرور', 'password', obscureText: true),
                            _buildTextField('رقم الهاتف', 'phone', keyboardType: TextInputType.phone),
                            _buildTextField('الموقع (أدخل الإحداثيات يدويا)', 'location'),  // حقل الموقع
                          ],
                        ),
                        if (_isPharmacy)
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              Row(children: [
                                Expanded(child: _buildTextField('اسم الصيدلية (عربي)', 'pharmacyNameAr')),
                                SizedBox(width: 10),
                                Expanded(child: _buildTextField('اسم الصيدلية (إنجليزي)', 'pharmacyNameEn')),
                              ]),
                              Row(children: [
                                Expanded(child: _buildTextField('رقم الحساب البنكي', 'bankAccount', keyboardType: TextInputType.number)),
                                SizedBox(width: 10),
                                Expanded(child: _buildTextField('مفتاح Binance', 'binanceKey')),
                              ]),
                              _buildTextField('مفتاح الدفع', 'payerKey'),
                              _buildTextField('وصف الصيدلية', 'pharmacyDesc'),
                            ],
                          ),
                        SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: _registerWithFirebase,
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey.shade800, padding: EdgeInsets.symmetric(vertical: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                          child: Center(child: Text('تسجيل', style: TextStyle(fontSize: 16, color: Colors.white))),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
