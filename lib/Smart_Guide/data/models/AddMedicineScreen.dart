import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_guide_to_medication/Smart_Guide/data/models/MedicinesListScreen.dart';
import 'package:smart_guide_to_medication/Smart_Guide/shared/components/components.dart';

class AddMedicineScreen extends StatefulWidget {
  @override
  _AddMedicineScreenState createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {
    'scientificName': TextEditingController(),
    'scientificName_en': TextEditingController(),
    'commonName': TextEditingController(),
    'price': TextEditingController(),
    'description': TextEditingController(),
  };

  XFile? _image;
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  Future<void> _addMedicine() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        String? imageUrl;
        if (_image != null) {
          final storageRef = FirebaseStorage.instance.ref().child('medicines/${DateTime.now().millisecondsSinceEpoch}.jpg');
          await storageRef.putFile(File(_image!.path));
          imageUrl = await storageRef.getDownloadURL();
        }

        String? pharmacyId = FirebaseAuth.instance.currentUser?.uid;

        if (pharmacyId == null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('لم يتم العثور على معرف الصيدلية')));
          return;
        }

        DocumentSnapshot pharmacySnapshot = await FirebaseFirestore.instance.collection('pharmacies').doc(pharmacyId).get();
        String ownerName = pharmacySnapshot['pharmacyNameAr'];
        String ownerPhone = pharmacySnapshot['phone'];
        String ownerAddress = pharmacySnapshot['location'];

        Map<String, dynamic> medicineData = {
          'scientificName': _controllers['scientificName']!.text,
          'scientificName_en': _controllers['scientificName_en']!.text,
          'commonName': _controllers['commonName']!.text,
          'price': double.tryParse(_controllers['price']!.text) ?? 0.0,
          'description': _controllers['description']!.text,
          'imageUrl': imageUrl ?? '',
          'addedAt': Timestamp.now(),
          'pharmacyNameAr': ownerName,
          'phone': ownerPhone,
          'location': ownerAddress,
        };

        await FirebaseFirestore.instance
            .collection('pharmacies')
            .doc(pharmacyId)
            .collection('medicines')
            .add(medicineData);

        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تم إضافة الدواء بنجاح')));
        navigateAndFinish(context, MedicinesListScreen());

      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('حدث خطأ: ${e.toString()}')));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إضافة دواء'),
        backgroundColor: Colors.blueGrey.shade800,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade200,
                    ),
                    child: _image == null
                        ? Icon(Icons.camera_alt, color: Colors.grey.shade600, size: 50)
                        : Image.file(File(_image!.path), fit: BoxFit.cover),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _controllers['scientificName'],
                  decoration: InputDecoration(labelText: 'الاسم العلمي'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الاسم العلمي مطلوب';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _controllers['scientificName_en'],
                  decoration: InputDecoration(labelText: 'الاسم العلمي انجليزي'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الاسم العلمي مطلوب';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _controllers['commonName'],
                  decoration: InputDecoration(labelText: 'الاسم الشائع'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الاسم الشائع مطلوب';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _controllers['price'],
                  decoration: InputDecoration(labelText: 'السعر'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'السعر مطلوب';
                    }
                    if (double.tryParse(value) == null) {
                      return 'يرجى إدخال سعر صحيح';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _controllers['description'],
                  decoration: InputDecoration(labelText: 'وصف الدواء'),
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الوصف مطلوب';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isLoading ? null : _addMedicine,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey.shade800,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text('إضافة الدواء', style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
