import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:kpointapplication/model/ShopProfile.dart';
import 'package:kpointapplication/screenAdmin/addpoint.dart';
import 'package:kpointapplication/screenAdmin/registerAdminPage.dart';

class loginShop extends StatefulWidget {
  const loginShop({super.key});

  @override
  State<loginShop> createState() => _loginShopState();
}

class _loginShopState extends State<loginShop> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  ShopProfile shopprofile = ShopProfile();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  //CollectionReference _profileCollection = FirebaseFirestore.instance.collection("shopprofiles");

  void handleClick() {}
  final FirebaseFirestore firestore = FirebaseFirestore.instance;


  Future<void> getData() async {
    // เชื่อมต่อ Firestore
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // ใช้ where สำหรับการค้นหาเอกสารที่มีฟิลด์และค่าที่ต้องการ
    QuerySnapshot querySnapshot = await firestore
        .collection('shopprofiles') // ชื่อคอลเลคชันของคุณ
        .where('phone', isEqualTo: shopprofile.phone) // เงื่อนไขของฟิลด์แรก
        .where('password', isEqualTo: shopprofile.password) // เงื่อนไขของฟิลด์ที่สอง
        .get();

    // นำข้อมูลที่ได้มาใช้งาน
      querySnapshot.docs.forEach((doc) {
        if(doc['phone']==shopprofile.phone&&doc['password']==shopprofile.password){
          shopprofile.shopname =doc['shopname'];
          //print('true');
          print(shopprofile.shopname);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    addPoint()),
          );
        }
      //print('phone: ${doc['phone']}, password: ${doc['password']}');
    });
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Error"),
              ),
              body: Center(child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
                body: Container(
                  padding: const EdgeInsets.all(30.0),
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(height: 50,),
                        Image.asset(
                          'assets/images/Logo.png',
                          height: 100,
                        ),
                        Text(
                              'เข้าสู่ระบบร้านค้า',
                              style: new TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              TextFormField(
                                controller: _phoneController,
                                keyboardType: TextInputType.number,
                                validator: RequiredValidator(
                                    errorText: "กรุณาป้อนหมายเลขโทรศัพท์"),
                                onSaved: (String? phone) async {
                                  shopprofile.phone = phone;
                                  },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'เบอร์โทรศัพท์',
                                ),
                              ),
                              SizedBox(height: 16.0),
                              TextFormField(
                                controller: _passwordController,
                                obscureText: true,
                                validator: RequiredValidator(
                                    errorText: "กรุณาป้อนรหัสผ่าน"),
                                onSaved: (String? password) async {
                                  shopprofile.password = password;
                                  },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'รหัสผ่าน',
                                ),
                              ),
                              SizedBox(height: 16.0),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black,
                                  // สีพื้นหลังของปุ่ม
                                  onPrimary: Colors.white,
                                  // สีของตัวอักษรบนปุ่ม
                                  elevation: 5, // ความสูงของปุ่ม (เงา)
                                  // เพิ่ม property อื่น ๆ ตามต้องการ
                                ),
                                onPressed: () {
                                  shopprofile.phone = _phoneController.text;
                                  shopprofile.password = _passwordController.text;
                                  getData();
                                  _formKey.currentState?.reset();
                                },
                                child: Text('เข้าสู่ระบบ'),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      registerAdminPage()),
                            );
                          },
                          child: Text('สร้างร้านค้า'),
                          style: ElevatedButton.styleFrom(
                            // กำหนดลักษณะต่าง ๆ ของปุ่ม เช่น สีพื้นหลัง
                            primary: Colors.grey,
                            // ขนาดของตัวอักษร
                            textStyle: TextStyle(fontSize: 12),
                            // กำหนดขอบของปุ่ม
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}