import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:kpointapplication/model/profile.dart';
import 'package:kpointapplication/screenUser/HomeLoginRegister.dart';
import 'package:kpointapplication/screenUser/HomePage.dart';

class registerPage extends StatefulWidget {
  const registerPage({super.key});

  @override
  State<registerPage> createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
  final _formKey = GlobalKey<FormState>();
  Profile profile = Profile();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference _profilesCollection = FirebaseFirestore.instance.collection("profiles");
  void handleClikLogin() {}
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
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              body: Container(
                padding: const EdgeInsets.all(30.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Image.asset(
                          'assets/images/Logo.png',
                          height: 100,
                        ),
                        Text('กรุณาใส่ข้อมูลของคุณด้านล่าง'),
                        Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 150,
                                              child: TextFormField(
                                                validator: RequiredValidator(
                                                    errorText: "โปรดระบุชื่อ"),
                                                onSaved: (String? name) {
                                                  profile.name = name;
                                                },
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  hintText: 'ชื่อ',
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20.0,
                                            ),
                                            SizedBox(
                                              width: 150,
                                              child: TextFormField(
                                                validator: RequiredValidator(
                                                    errorText: "โปรดระบุนามสกุล"),
                                                onSaved: (String? lname) {
                                                  profile.lname = lname;
                                                },
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  hintText: 'นามสกุล',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        SizedBox(
                                          width: 320,
                                          child: TextFormField(
                                            validator: RequiredValidator(
                                                errorText:
                                                    "โปรดระบุเลขบัตรประชาชน"),
                                            onSaved: (String? idnum) {
                                              profile.idnum = idnum;
                                            },
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'เลขบัตรประชาชน',
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        SizedBox(
                                          width: 320,
                                          child: TextFormField(
                                            validator: RequiredValidator(
                                              errorText: "โปรดระบุอีเมล"),
                                            onSaved: (String? email) {
                                              profile.email = email;
                                            },
                                            keyboardType: TextInputType.emailAddress,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'อีเมล',
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        SizedBox(
                                          width: 320,
                                          child: TextFormField(
                                            validator: RequiredValidator(
                                                errorText:
                                                "โปรดระบุหมายเลขโทรศัพท์"),
                                            onSaved: (String? phone) {
                                              profile.phone = phone;
                                            },
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'หมายเลขโทรศัพท์',
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20.0,
                                        ),SizedBox(
                                          width: 320,
                                          child: TextFormField(
                                            obscureText: true,
                                            validator: RequiredValidator(
                                                errorText:
                                                "โปรดระบุรหัสผ่าน"),
                                            onSaved: (String? password) {
                                              profile.password = password;
                                            },
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'รหัสผ่าน',
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.black, // สีพื้นหลังของปุ่ม
                                              onPrimary: Colors.white, // สีของตัวอักษรบนปุ่ม
                                              elevation: 5, // ความสูงของปุ่ม (เงา)
                                            ),
                                            child: Text('สมัครสมาชิก'),
                                            onPressed: () async {
                                              if (_formKey.currentState!.validate()) {
                                                _formKey.currentState?.save();
                                                await _profilesCollection.add({
                                                  "name":profile.name,
                                                  "lname":profile.lname,
                                                  "idnum" : profile.idnum,
                                                  "email":profile.email,
                                                  "phone":profile.phone,
                                                  "password":profile.password,
                                                  "point" : 0,
                                                });
                                                _formKey.currentState?.reset();
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => HomeLoginRegister()),
                                                );
                                              }
                                            }),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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
