import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  File? _image;
  File? _image2;

  void pickimage() async {
    final pickFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickFile != null) {
      setState(() {
        _image = File(pickFile!.path);
      });
    }
  }



///function calling
  void pickimagefromcamera() async {
    final pickFile2 = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickFile2 != null) {
      setState(() {
        _image2 = File(pickFile2!.path);
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.blue,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _image == null ? Text("No Image") : Image.file(_image!,height: 100,),
              const SizedBox(height: 20),

              _image2 == null ? Text("No Image") : Image.file(_image2!,height: 100,),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  pickimage();
                },
                child: const Text("Pick Image"),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  pickimagefromcamera();

                },
                child: const Text("Camera Image"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
