// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:kpointapplication/screenAdmin/addpoint.dart';
// import 'package:kpointapplication/screenUser/FormScreen.dart';
//
//
// // void main(){
// //   // WidgetsFlutterBinding.ensureInitialized();
// //   // Firebase.initializeApp();
// //   runApp(const MyApp());
// // }
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized(); // ตรวจสอบการเริ่มต้น Flutter
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }
//
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: registerPage()
//     );
//   }
// }
//
//

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kpointapplication/UserAdmin/UserAdminHome.dart';
import 'package:kpointapplication/screenAdmin/addpoint.dart';
import 'package:kpointapplication/screenAdmin/test.dart';
import 'package:kpointapplication/screenUser/HomeLoginRegister.dart';
import 'package:kpointapplication/screenUser/HomePage.dart';
import 'package:kpointapplication/screenUser/LogoPage.dart';
import 'package:kpointapplication/screenUser/TabBottom.dart';
import 'package:kpointapplication/screenUser/display.dart';
import 'package:kpointapplication/screenUser/FormScreen.dart';
import 'package:kpointapplication/screenUser/registerPage.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: UserAdminHome(),
      //home: TabBottom(),
    );
  }
}
