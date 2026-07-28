import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  bool isOn = false;
  String gender = 'Male';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: const Text("My Profile"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ///switch widget
          Switch(
            activeTrackColor: Colors.blue.shade900,
            value: isOn,
            onChanged: (value) {
              setState(() {
                isOn = value;
              });
            },
          ),

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
        ],
      ),
    );
  }
}
