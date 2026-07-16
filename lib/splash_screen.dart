import 'package:first_project/signin_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _State();
}


class _State extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashDelay();
  }


  splashDelay()async{
    await Future.delayed(Duration(seconds: 3));

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignInScreen()));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Text(
            //   "Hellow",
            //   style: TextStyle(
            //     fontSize: 30,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.white,
            //   ),),


          Image.asset(
          "assets/images/fb icon.jpeg",
          height: 70,
        ),




            CircularProgressIndicator(
              color: Colors.white38,

            )
          ],
        ),
      ),
    );
  }
}
