
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_project/view/screens/auth_screens/signin_screen/signin_screen.dart';
import 'package:flutter/material.dart';

import '../../ProductListScreen/ProductListScreen.dart';

class SignUpScreen extends StatefulWidget {
  // final String userName; //constructor
  // final int userNumber;
  SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  ///variable of switch widget
  String gender = 'Male';

  ///loading state for signup button
  bool isLoading = false;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> signUpUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      final uid = userCredential.user!.uid;

      // Store user data in Firestore
      try {
        await storeUserData(
          uid,
          firstNameController.text.trim(),
          lastNameController.text.trim(),
          emailController.text.trim(),
          adressController.text.trim(),
          countryController.text.trim(),
          phoneNumberController.text.trim(),

        );
      }
      on FirebaseException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Firestore Error: ${e.message}"),
            backgroundColor: Colors.red,
          ),
        );

        debugPrint("Firestore Error Code: ${e.code}");
        debugPrint("Firestore Error Message: ${e.message}");
        return; // Stop execution if Firestore fails
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Account Created Successfully"),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProductListScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String message = "";

      switch (e.code) {
        case "email-already-in-use":
          message = "This email is already registered.";
          break;
        case "invalid-email":
          message = "Please enter a valid email.";
          break;
        case "weak-password":
          message = "Password should be at least 6 characters.";
          break;
        case "operation-not-allowed":
          message = "Email/Password sign in is disabled.";
          break;
        case "network-request-failed":
          message = "No internet connection.";
          break;
        default:
          message = e.message ?? "Something went wrong.";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red),
      );

      debugPrint("Firebase Auth Error: ${e.code}");
      debugPrint("Message: ${e.message}");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
      );

      debugPrint(e.toString());
    }
  }

  Future<void> storeUserData(
    String uid,
    String firstName,
    String lastName,
    String email,
      String adress,
      String country,
      String phoneNumber,
  ) async {
    await FirebaseFirestore.instance.collection("AppUser").doc(uid).set({
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "adress":adress,
      "country":country,
      "phoneNumber":phoneNumber,
      "createdAt": DateTime.now(),
    });
  }

  @override
  @override

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
                      " User Name", //putting signin screen variable here with $ sign
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
                        controller: firstNameController,
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
                        controller: lastNameController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter your Last  name";
                          }
                        },
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
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter your email";
                          }

                          if (!RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          ).hasMatch(value)) {
                            return "Enter a valid email";
                          }

                          return null;
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

                      Text("Adress", style: TextStyle(fontSize: 16)),
                      SizedBox(height: 10),

                      TextFormField(
                        controller: adressController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter your Adress";
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Enter your Adress",
                          // labelText: "Enter your email",
                          prefixIcon: Icon(Icons.person),
                          suffixIcon: Icon(Icons.remove_red_eye_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      Text("Country", style: TextStyle(fontSize: 16)),
                      SizedBox(height: 10),

                      TextFormField(
                        controller: countryController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter your Country Name";
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Enter your Country Name",
                          // labelText: "Enter your email",
                          prefixIcon: Icon(Icons.person),
                          suffixIcon: Icon(Icons.remove_red_eye_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),
                      Text("Phone Number", style: TextStyle(fontSize: 16)),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: phoneNumberController,
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
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: false,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter your Password";
                          }

                          if (value.length < 6) {
                            return "Password must be at least 6 characters";
                          }

                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Enter your password",
                          prefixIcon: Icon(Icons.lock_outline),
                          suffixIcon: Icon(Icons.remove_red_eye_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),

                      ///Radio button widget
                      RadioListTile(
                        value: "Male",
                        groupValue: gender,
                        title: Text("Male"),
                        onChanged: (value) {
                          setState(() {
                            gender = value!;
                          });
                        },
                      ),
                      RadioListTile(
                        value: "Female",
                        groupValue: gender,
                        title: Text("Female"),
                        onChanged: (value) {
                          setState(() {
                            gender = value!;
                          });
                        },
                      ),

                      /// ================== CHANGED PORTION START ==================
                      InkWell(
                        onTap: isLoading
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });

                                  await signUpUser();

                                  if (mounted) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
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
                            child:
                            isLoading
                                ? SizedBox(
                                    height: 22,
                                    width: 22,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                :
                            Text(
                                    "Sign up",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ),

                      /// ================== CHANGED PORTION END ==================
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
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignInScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Sign in",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
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
