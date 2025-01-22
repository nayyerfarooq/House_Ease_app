import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shift_ease_fyp/TeamPortal/SharedPreferences/saveTeamMemberData.dart';
import 'package:shift_ease_fyp/widgets/custom_snakbar.dart';
import '../../apiUrl.dart';
import '../Pages/teamMemberDashboard.dart';

Future<void> teamLeaderLogin({
  required String email,
  required String occupation,
}) async {
  final url = Uri.parse('${ApiUrl.baseUrl}/teamportalApis/teamLogin/');

  try {
    final Map<String, dynamic> requestData = {
      'email': email,
      'team_member_occupation': occupation,
    };

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['message'] == 'Login successful') {
        await saveTeamMemberLoginData(data['team_member']);
        Get.to(TeamMemberDashboard());
      }
    } else if (response.statusCode == 400) {
      final responseData = jsonDecode(response.body);
      showErrorSnackbar('Login failed: ${responseData['error']}');
    } else {
      showErrorSnackbar('Unexpected error: ${response.statusCode}');
    }
  } catch (e) {
    showErrorSnackbar('An error occurred: $e');
  }
}
