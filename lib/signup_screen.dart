import 'package:first_project/home_screen.dart';
import 'package:first_project/signin_screen.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  final String userName; //constructor
  final int userNumber;
  SignUpScreen({required this.userName, required this.userNumber});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.blue.shade900,
      //   iconTheme: IconThemeData(color: Colors.white),
      // ),
      backgroundColor: Colors.blue.shade900,

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                SizedBox(height: 35),

                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },

                  child: Icon(Icons.arrow_back_outlined, color: Colors.white),
                ),

                SizedBox(height: 15),
                Row(
                  children: [
                    Icon(Icons.autorenew, color: Colors.white),

                    Text(
                      " ${widget.userName}, ${widget.userNumber}", //putting signin screen variable here with $ sign
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),

                Text(
                  "Create Your \nNew Account  ",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),

                Text(
                  "Join smart and secure app made for you.",
                  style: TextStyle(color: Colors.white38, fontSize: 15),
                ),
              ],
            ),
          ),

          SizedBox(height: 25),

          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),

              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("First Name", style: TextStyle(fontSize: 16)),
                      SizedBox(height: 10),

                      TextFormField(
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter your First name";
                          }
                        },

                        decoration: InputDecoration(
                          hintText: "Enter your First Name",
                          // labelText: "Enter your email",
                          prefixIcon: Icon(Icons.person),
                          suffixIcon: Icon(Icons.remove_red_eye_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      Text("Last Name", style: TextStyle(fontSize: 16)),
                      SizedBox(height: 10),

                      TextFormField(
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter your Last  name";
                          }
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Enter your Last Name",
                          // labelText: "Enter your email",
                          prefixIcon: Icon(Icons.person),
                          suffixIcon: Icon(Icons.remove_red_eye_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),
                      Text("Email", style: TextStyle(fontSize: 16)),
                      SizedBox(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter your email adress";
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Enter your email",
                          // labelText: "Enter your email",
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),
                      Text("Phone Number", style: TextStyle(fontSize: 16)),
                      SizedBox(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter your Phone Number";
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Enter your Phone Number",
                          // labelText: "Enter your email",
                          prefixIcon: Icon(Icons.phone_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),

                      Text("Password", style: TextStyle(fontSize: 16)),
                      SizedBox(height: 10),

                      TextFormField(
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter your Password";
                          }
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Enter your password",
                          // labelText: "Enter your email",
                          prefixIcon: Icon(Icons.lock_open),
                          suffixIcon: Icon(Icons.remove_red_eye_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),

                      InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(

                                ),
                              ),
                            ); //putting value of the variable
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Please fill all the Textfields..!",
                                ),
                              ),
                            );
                          }
                        },
                        child: Container(
                          height: 50,
                          width: double.infinity,

                          decoration: BoxDecoration(
                            color: Colors.blue.shade900,
                            borderRadius: BorderRadius.circular(50),
                          ),

                          child: Center(
                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 25),

                      Row(
                        children: [
                          Expanded(child: Divider()),
                          Text("   Or   ", style: TextStyle(fontSize: 16)),
                          Expanded(child: Divider()),
                        ],
                      ),

                      SizedBox(height: 25),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 50,
                            width: 180,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.black45,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // CircleAvatar(
                                // radius: 12,
                                //
                                // backgroundImage: AssetImage("assets/images/google icon.png"),),
                                //
                                Image.asset(
                                  "assets/images/google icon.png",
                                  height: 25,
                                ),

                                Text(
                                  "Google",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 12),

                          Container(
                            height: 50,
                            width: 180,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.black45,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                Image.asset(
                                  "assets/images/fb icon.jpeg",
                                  height: 30,
                                ),

                                //
                                // CircleAvatar(
                                // radius: 15,
                                //
                                // backgroundImage: AssetImage("assets/images/fb icon.jpeg"),),
                                Text(
                                  "Facebook",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account? "),
                          Text(
                            "Sign in",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
