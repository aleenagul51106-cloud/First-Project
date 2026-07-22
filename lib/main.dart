import 'package:first_project/bottom_navbar.dart';
import 'package:first_project/calculator_screen.dart';
import 'package:first_project/counterapp_screen.dart';
import 'package:first_project/home_screen.dart';
import 'package:first_project/menu_screen.dart';
import 'package:first_project/practice_screen.dart';
import 'package:first_project/setting_screen.dart';
import 'package:first_project/signin_screen.dart';
import 'package:first_project/signup_screen.dart';
import 'package:first_project/splash_screen.dart';
import 'package:first_project/student_profile.dart';
import 'package:first_project/weather_data_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.green)),
     //  home: PracticeScreen(),
     // home: StudentProfile(),
      // home: SignInScreen(),
       //  home: SplashScreen(),
      //home: SignUpScreen()
       // home: HomeScreen(),
         // home: MenuScreen(),
     // home: BottomNavbar(),
    // home: SettingScreen(),
     //home: CounterScreen(),
      //home: CalculatorScreen(),
      home: WeatherScreen(),
    );
  }
}

// class FrontScreen extends StatelessWidget {
//   const FrontScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: Icon(Icons.menu,color: Colors.white,),
//
// actions: [Padding(
//   padding: const EdgeInsets.only(right: 20.0),
//   child: Icon(Icons.notifications,color: Colors.white,),
// )],
//         backgroundColor: Colors.green,
//         centerTitle: true,
//
//         title: Text(
//           "First Screen",
//           style: TextStyle(color: Colors.white, fontSize: 20),
//         ),
//
//
//       ),
//
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//
//
//               children: [
//                 Center(child: Icon(Icons.home,color: Colors.red,size: 50,)),
//                 Row(
//                   children: [
//                     Text("Telenor"), Text("Jazz"),
//                   ],
//                 ),
//                 Text("HELLOW WORLD"),
//                 Text("HELLOW WORLD"),
//                 Text("HELLOW WORLD"),
//               ],
//
//
//         ),
//       ),
//     );
//   }
// }



// class StudentProfile extends StatelessWidget {
//   const StudentProfile({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: const Text("StudentProfile"),
//         centerTitle: true,
//         leading: const Icon(Icons.menu, color: Colors.white)
//
//         ,actions:[
//           const Icon(Icons.person, color: Colors.white),
//         const SizedBox(width: 15),
//         ] ,
//
//       ),
//
//       body: Padding(padding: const EdgeInsetsGeometry.all(20),
//           child: Column(
//          children: [
//           Center(child: Icon(Icons.person,size: 50,)),
//
//            Text("Name"),
//            Text("Mobile App Dev"),
//
//
//            Row(
//              children: [
//                Icon(Icons.email,),
//                Text("Mobile App Dev"),
//
//
//
//              ],
//            ),
//            Row(
//              children: [
//                Icon(Icons.email,),
//                Text("Mobile App Dev"),
//
//
//
//              ],
//            ),
//            Row(
//              children: [
//                Icon(Icons.email,),
//                Text("Mobile App Dev"),
//
//
//
//              ],
//            ),
//            Row(
//              children: [
//                Icon(Icons.email,),
//                Text("Mobile App Dev"),
//
//
//
//              ],
//            )
//          ],
//           )));
//   }
// }

