import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MedicinesListuser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('قائمة الأدوية من جميع الصيدليات'),
        backgroundColor: Colors.blueGrey.shade800,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collectionGroup('medicines')
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
              String pharmacyName = medicine['pharmacyNameAr'] ?? 'غير متوفر';
              String phone = medicine['phone'] ?? 'غير متوفر';
              String location = medicine['location'] ?? 'غير متوفر';

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
                      Text('الاسم العلمي: ${medicine['scientificName']}'),
                      Text('الاسم بلانجليزي: ${medicine['scientificName_en']}'),
                      Text('السعر: \$${medicine['price']}'),
                      Text('الوصف: ${medicine['description']}'),
                      Text('اسم الصيدلية: ${medicine['pharmacyNameAr'] ?? 'غير متوفر'}'),
                      Text('رقم الهاتف: ${medicine['phone'] ?? 'غير متوفر'}'),
                      Text('العنوان: ${medicine['location'] ?? 'غير متوفر'}'),
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
