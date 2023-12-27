import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:kpointapplication/model/profile.dart';
import 'package:kpointapplication/screenAdmin/test.dart';
import 'package:kpointapplication/screenUser/FormScreen.dart';
import 'package:kpointapplication/screenUser/HomePage.dart';
import 'package:kpointapplication/screenUser/LogoPage.dart';
import 'package:kpointapplication/screenUser/registerPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeLoginRegister extends StatefulWidget {
  const HomeLoginRegister({super.key});

  @override
  State<HomeLoginRegister> createState() => _HomeLoginRegisterState();
}

class _HomeLoginRegisterState extends State<HomeLoginRegister> {
  final _formKey = GlobalKey<FormState>();
  Profile profile = Profile();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference _profileCollection = FirebaseFirestore.instance.collection("profiles");
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if(snapshot.hasError){
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
                        SizedBox(height: 100,),
                        Image.asset(
                          'assets/images/Logo.png',
                          height: 100,
                        ),
                        Column(
                          children: [
                            Text(
                              'เข้าสู่ระบบหรือสมัครสมาชิก',
                              style: new TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Column(
                          children: [
                            Container(
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 350,
                                      child: TextFormField(
                                        validator: RequiredValidator(
                                            errorText: "กรุณาป้อนหมายเลขโทรศัพท์"),
                                        onSaved: (String? phone) async{
                                          profile.phone = phone;
                                          var collectionReference = FirebaseFirestore.instance.collection('profiles');
                                          var query = await collectionReference.where('phone', isEqualTo: profile.phone).get();
                                          if (query.docs.isEmpty) {
                                            // ไม่มีข้อมูลที่มีค่าเท่ากับ yourValue อยู่ใน Firestore
                                            // ทำการเพิ่มข้อมูลใหม่
                                            // await collectionReference.add({
                                            //   'phone': profile.phone,
                                            //   // ข้อมูลอื่น ๆ
                                            // });
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => registerPage()),
                                            );
                                          } else {
                                            // มีข้อมูลที่มีค่าเท่ากับ yourValue อยู่ใน Firestore แล้ว
                                            // ทำการจัดการตามที่คุณต้องการ
                                            profile.phone = phone;
                                            String? p = profile.phone;
                                            SharedPreferences prefs = await SharedPreferences.getInstance();
                                            prefs.setString('phone', p!);

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => LogoPage()),
                                            );
                                          }
                                        },
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'เบอร์โทรศัพท์',
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Column(
                                      children: [
                                        ElevatedButton(
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
                                              if (_formKey.currentState!.validate()) {

                                                _formKey.currentState?.save();
                                                _formKey.currentState?.reset();

                                              }

                                            }
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ));
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });

  }
}
