import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shift_ease_fyp/screens/home/UserDashboard.dart';
import 'package:shift_ease_fyp/utils/SharedPreferences.dart';
import 'package:shift_ease_fyp/widgets/custom_snakbar.dart';
import 'dart:convert';
import '../apiUrl.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> loginUser(String email, String password) async {
    isLoading(true);
    try {
      String apiUrl = '${ApiUrl.baseUrl}/adminapis/UserSignUp/?email=$email&password=$password';
      var response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var userDataList = json.decode(response.body);

        Map<String, dynamic> userData = userDataList[0];
        await saveData(email);
        await saveUserData(userData);
        Get.off(UserDashBoardScreen());
      } else {
        showErrorSnackbar('Email or password is not correct');
      }
    } catch (e) {
      showErrorSnackbar('An error occurred: $e');
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
