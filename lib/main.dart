import 'package:firebase_core/firebase_core.dart';
import 'package:first_project/bottom_navbar.dart';
import 'package:first_project/theme_provider.dart';
import 'package:first_project/view/screens/home_screen/home_screen.dart';
import 'package:first_project/view/screens/mobile_catalog_screen/mobile_catalog_screen.dart';
import 'package:first_project/view/screens/QuickTools_screen/calculator_screen.dart';
import 'package:first_project/view/screens/counter_app/counter_app_provider.dart';
import 'package:first_project/view/screens/counter_app/counterapp_screen.dart';
import 'package:first_project/view/screens/QuickTools_screen/currency_converter_screen.dart';
import 'package:first_project/view/screens/dashboard_screen/dashboard_screen.dart';
import 'package:first_project/firebase_options.dart';
import 'package:first_project/view/screens/QuickTools_screen/language_translator_screen.dart';
import 'package:first_project/view/screens/QuickTools_screen/dictionary_screen.dart';
import 'package:first_project/view/screens/QuickTools_screen/quote_generator-screen.dart';
import 'package:first_project/view/screens/QuickTools_screen/unit_converter_screen.dart';
import 'package:first_project/view/screens/menu_screen/menu_screen.dart';
import 'package:first_project/view/screens/setting_screen/setting_screen.dart';
import 'package:first_project/view/screens/auth_screens/signin_screen/signin_screen.dart';
import 'package:first_project/view/screens/auth_screens/signup_screen/signup_screen.dart';
import 'package:first_project/splash_screen.dart';
import 'package:first_project/view/screens/student_profile/student_profile.dart';
import 'package:first_project/view/screens/Weather_App/weather_data_screen.dart';
import 'package:flutter/material.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,///to remove the red clr option of debug from app bar(present on extreme right)
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.green)),
      home: SplashScreen(),
      //home: CurrencyConverterScreen()
     // home:TranslatorApp()
     // home: UnitConverterApp()
      //home: DictionaryApp(),
     // home: QuoteScreen(),
     //  home: MobileCatalogScreen(),
      // home: HomeScreen(),
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

