import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, dynamic>?> getTeamMemberLoginData() async {
  final prefs = await SharedPreferences.getInstance();

  if (prefs.containsKey('company_id')) {
    return {
      'company_id': prefs.getInt('company_id'),
      'team_name': prefs.getString('team_name'),
      'team_member_email': prefs.getString('team_member_email'),
      'team_member_role': prefs.getString('team_member_role'),
    };
  }
  return null;
}
