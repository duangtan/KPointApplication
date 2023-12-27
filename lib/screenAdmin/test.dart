import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kpointapplication/model/profile.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Profile profile = Profile();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Data Example'),
      ),
      body: StreamBuilder(
        stream: firestore.collection('profiles').where('phone', isEqualTo: profile.phone).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          // ดึงข้อมูลจาก snapshot
          List<DocumentSnapshot> documents = snapshot.data!.docs;
          return Scaffold(body: Column(children: [ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black, // สีพื้นหลังของปุ่ม
                onPrimary: Colors.white, // สีของตัวอักษรบนปุ่ม
                elevation: 5, // ความสูงของปุ่ม (เงา)
                // เพิ่ม property อื่น ๆ ตามต้องการ
              ),
              child: Text(
                "ดำเนินการต่อ",
                style: TextStyle(fontSize: 20),
              ),

              onPressed: () async{


              }
          ),],),);
          // สร้าง Widget สำหรับแสดงข้อมูล
          // return ListView.builder(
          //   itemCount: documents.length,
          //   itemBuilder: (context, index) {
          //     Map<String, dynamic> data = documents[index].data() as Map<String, dynamic>;
          //     String documentId = documents[index].id;
          //
          //     // สามารถแสดงข้อมูลที่คุณต้องการทำได้ที่นี่
          //     return ListTile(
          //       title: Text('Document ID: $documentId'),
          //       subtitle: Text('name: ${data['name']}, phone: ${data['phone']}'),
          //     );
          //   },
          // );
        },
      ),
    );
  }
}