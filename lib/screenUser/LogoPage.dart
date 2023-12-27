import 'package:flutter/material.dart';
import 'package:kpointapplication/model/profile.dart';
import 'package:kpointapplication/screenUser/FormScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoPage extends StatefulWidget{
  const LogoPage({Key? key}) : super(key: key);
  @override
  State<LogoPage> createState() => _LogoPageState();
}
class _LogoPageState extends State<LogoPage>{
  Profile profile = Profile();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
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
    print('u');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringValue = prefs.getString('phone'); // อ่านค่า String
    //int? intValue = prefs.getInt('intKey'); // อ่านค่า Int
    //bool? boolValue = prefs.getBool('boolKey'); // อ่านค่า Boolean
print(stringValue);
    prefs.clear();
    }
    ),]
    ),
    );



  }

}