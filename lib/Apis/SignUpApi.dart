import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shift_ease_fyp/apiUrl.dart';
import 'package:shift_ease_fyp/routes/app_routes.dart';
import 'dart:convert';
import 'package:shift_ease_fyp/widgets/custom_snakbar.dart';
class SignUpApis{
  Future<void> sendUserDataToApi(String fullName, String email, String password,String uid) async {
    const url = '${ApiUrl.baseUrl}/adminapis/UserSignUp/';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': fullName,
          'email': email,
          'password':password ,
          'user_uid':uid,
        }),
      );
      if (response.statusCode == 201) {
        showSuccessSnackbar(response.body.toString());
        Get.toNamed(AppRoutes.login);
      } else {
        showErrorSnackbar('Failed to send user data: ${response.body}');
        print(response.body);
      }
    } catch (e) {
      showErrorSnackbar('Error sending user data to API: $e');
      print(e);
    }
  }
}