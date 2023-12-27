import 'package:flutter/material.dart';
import 'package:kpointapplication/screenAdmin/addpoint.dart';
import 'package:kpointapplication/screenAdmin/loginShop.dart';
import 'package:kpointapplication/screenUser/HomeLoginRegister.dart';

class UserAdminHome extends StatefulWidget {
  const UserAdminHome({super.key});

  @override
  State<UserAdminHome> createState() => _UserAdminHomeState();
}

class _UserAdminHomeState extends State<UserAdminHome> {
  handleClickShop(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => loginShop()),
    );
  }
  handleClickCust(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeLoginRegister()),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 100,),
          Image.asset(
          'assets/images/Logo.png',
          height: 150,
        ),SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white, // สีพื้นหลังของปุ่ม
                      onPrimary: Colors.black, // สีของตัวอักษรบนปุ่ม
                      elevation: 15, // ความสูงของปุ่ม (เงา)
                      // เพิ่ม property อื่น ๆ ตามต้องการ
                    ),
                    onPressed:handleClickShop,
                    child:Row(
                      children: [
                        Column(
                          children: [
                            Icon(Icons.add_business_rounded,color: Colors.black,size: 70,),
                            Text('SHOP',style: TextStyle(color: Colors.black,fontSize: 30),),
                          ],
                        ),
                      ],
                    ),
                  ),
                SizedBox(width: 30,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white, // สีพื้นหลังของปุ่ม
                      onPrimary: Colors.black, // สีของตัวอักษรบนปุ่ม
                      elevation: 15, // ความสูงของปุ่ม (เงา)
                      // เพิ่ม property อื่น ๆ ตามต้องการ
                    ),
                    onPressed: handleClickCust,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Icon(Icons.account_circle_rounded,color: Colors.black,size: 70,),
                            Text('GUEST',style: TextStyle(color: Colors.black,fontSize: 30),),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
