import 'package:first_project/signup_screen.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                SizedBox(height: 30),

                Row(
                  children: [
                    Icon(Icons.person, color: Colors.white),

                    Text(
                      " LOGO",
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
                  "Welcome Back!",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),

                Text(
                  "Sign in to continue your journey with us",
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

              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Email", style: TextStyle(fontSize: 16)),
                    SizedBox(height: 15),

                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter your email";
                        }

                        // Remove extra spaces
                        value = value.trim();

                        // Email validation
                        final emailRegex = RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                        );

                        if (!emailRegex.hasMatch(value)) {
                          return "Please enter a valid email address";
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Enter your email",
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),

                    SizedBox(height: 40),

                    Text("Password", style: TextStyle(fontSize: 16)),
                    SizedBox(height: 15),

                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your password";
                        }

                        if (value.length < 8) {
                          return "Password must be at least 8 characters long";
                        }

                        if (!RegExp(r'[A-Z]').hasMatch(value)) {
                          return "Password must contain at least one uppercase letter";
                        }

                        if (!RegExp(r'[a-z]').hasMatch(value)) {
                          return "Password must contain at least one lowercase letter";
                        }

                        if (!RegExp(r'[0-9]').hasMatch(value)) {
                          return "Password must contain at least one number";
                        }

                        if (!RegExp(
                          r'[!@#$%^&*(),.?":{}|<>]',
                        ).hasMatch(value)) {
                          return "Password must contain at least one special character";
                        }

                        return null;
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

                    SizedBox(height: 40),

                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpScreen(
                                userName: "ALEENA",
                                userNumber: 111111111,
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
                            "Sign in",
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
                          width: 200,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.black45),
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

                        Container(
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.black45),
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
                        Text("Don't have an account? "),
                        Text(
                          "Sign up",
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
        ],
      ),
    );
  }
}
