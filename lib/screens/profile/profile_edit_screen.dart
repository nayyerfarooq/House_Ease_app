import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileEditScreen extends StatefulWidget {
  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  File? _image; // Variable to store the selected image
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: _image != null
                      ? FileImage(_image!)
                      : AssetImage('assets/images/homeease_logo.png') as ImageProvider,
                  backgroundColor: Colors.grey.shade200,
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.shade800,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(Icons.camera_alt, color: Colors.white, size: 20),
                      onPressed: _pickImage,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            buildTextField('Name', 'Nayyer', false),
            SizedBox(height: 20),
            buildTextField('Email', 'nayyer123@gmail.com', false),
            SizedBox(height: 20),
            buildTextField('Password', '************', true),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Add your cancel action here
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    backgroundColor: Colors.grey.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add your update action here
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    backgroundColor: Colors.blue.shade800,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadowColor: Colors.blue.shade800.withOpacity(0.5),
                    elevation: 5,
                  ),
                  child: Text(
                    'Update',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String placeholder, bool isPassword) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: placeholder,
        hintStyle: TextStyle(
          fontSize: 16,
          color: Colors.grey.shade500,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.grey.shade200,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.blue.shade800, width: 2),
        ),
      ),
    );
  }
}
