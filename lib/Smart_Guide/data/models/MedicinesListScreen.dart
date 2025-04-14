import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class MedicinesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String pharmacyId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text('قائمة الأدوية'),
        backgroundColor: Colors.blueGrey.shade800,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('pharmacies')
            .doc(pharmacyId)
            .collection('medicines')
            .orderBy('addedAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('حدث خطأ: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('لا توجد أدوية لعرضها.'));
          }

          var medicines = snapshot.data!.docs;

          return ListView.builder(
            itemCount: medicines.length,
            itemBuilder: (context, index) {
              var medicine = medicines[index];
              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  leading: medicine['imageUrl'] != ''
                      ? Image.network(medicine['imageUrl'], width: 50, height: 50, fit: BoxFit.cover)
                      : Icon(Icons.image, size: 50),
                  title: Text(medicine['scientificName']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('الاسم الشائع: ${medicine['commonName']}'),
                      Text('السعر: \$${medicine['price']}'),
                      Text('الوصف: ${medicine['description']}'),
                      Text('اسم صاحب الصيدلية: ${medicine['pharmacyNameAr']}'),
                      Text('رقم الهاتف: ${medicine['phone']}'),
                      Text('العنوان: ${medicine['location']}'),
                    ],
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
