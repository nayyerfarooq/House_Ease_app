import 'package:shared_preferences/shared_preferences.dart';

Future<void> clearTeamMemberLoginData() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('company_id');
  await prefs.remove('team_name');
  await prefs.remove('team_member_email');
  await prefs.remove('team_member_role');
}
