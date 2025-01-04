import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shift_ease_fyp/widgets/custom_snakbar.dart';

import '../apiUrl.dart';

class SignupController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var isLoading = false.obs;

  Future<void> signupUser({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      isLoading.value = true;
      // UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      //   email: email,
      //   password: password,
      // );
      // User? user = userCredential.user;
      // if (user != null) {
      //   await _firestore.collection('Users').doc(user.uid).set({
      //     'fullName': fullName,
      //     'email': email,
      //     'password': password,
      //     'createdAt': DateTime.now(),
      //     'uid': user.uid,
      //   });
      // }
      await sendUserDataToAPI(
        fullName: fullName,
        email: email,
        password: password,
        userId: 'gwgwgdgvdgsvxgvsgcv',
      );
      showSuccessSnackbar('Data Saved Sucessfully');
    } catch (e) {
      showErrorSnackbar(e.toString());
      print(e.toString());
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> sendUserDataToAPI({
    required String fullName,
    required String email,
    required String password,
    required String userId,
  }) async {
    var  apiUrl = '${ApiUrl.baseUrl}/adminapis/UserSignUp/';

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': fullName,
          'email': email,
          'password': password,
          'users_uid': userId,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        showSuccessSnackbar("Data sent to API successfully");
      } else {
        showErrorSnackbar("Failed to send data to API: ${response.statusCode}");
      }
    } catch (e) {
      showErrorSnackbar("API Error: $e");
    }
  }
}
