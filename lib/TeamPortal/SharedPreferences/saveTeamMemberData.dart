import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveTeamMemberLoginData(Map<String, dynamic> teamMemberData) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('company_id', teamMemberData['company_id']);
  await prefs.setString('team_name', teamMemberData['team_name']);
  await prefs.setString('team_member_email', teamMemberData['team_member_email']);
  await prefs.setString('team_member_role', teamMemberData['team_member_role']);
}
