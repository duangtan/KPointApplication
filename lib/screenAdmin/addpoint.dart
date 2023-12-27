import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kpointapplication/model/ShopProfile.dart';
import 'package:kpointapplication/model/profile.dart';

class addPoint extends StatefulWidget {
  const addPoint({super.key});

  @override
  State<addPoint> createState() => _addPointState();
}

class _addPointState extends State<addPoint> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController searchController = TextEditingController();
  final TextEditingController updateController = TextEditingController();
  ShopProfile shopprofile = ShopProfile();

  Future<void> updateField() async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('profiles')
          .where('phone', isEqualTo: searchController.text)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String documentId = querySnapshot.docs.first.id;
        Map<String, dynamic> data = querySnapshot.docs.first.data() as Map<String, dynamic>;

        // ตรวจสอบว่าฟิลด์ที่ต้องการอัปเดตมีค่าตัวเลขหรือไม่
        if (data['point'] is num && updateController.text is String) {
          int oldValue = data['point'];
          int newValue = int.tryParse(updateController.text) ?? 0;
          //print(shopprofile.shopname);

          await firestore.collection('profiles').doc(documentId).update({
            'point': oldValue + newValue,
            // add more fields as needed
          });
        } else {
          print('Field is not a number');
        }
        setState(() {
          searchController.text ='';
          updateController.text = '';
        });
        print('Field updated successfully');
      } else {
        setState(() {
          searchController.text ='';
        });
        print('No matching document found');
      }
    } catch (e) {
      print('Error updating field: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Enter phone',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: updateController,
              decoration: InputDecoration(
                labelText: 'Enter point',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: updateField,
            child: Text('Confirm'),
          ),
        ],
      ),
    );
  }
}
