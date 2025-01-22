import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shift_ease_fyp/apiUrl.dart';
import '../Models/AssignedTasksModal.dart';

class AssignedTasksController extends GetxController {
  final RxList<AssignedTasksModal> assignedTasks = <AssignedTasksModal>[].obs;
  final RxBool isLoading = false.obs;

  Future<void> fetchAssignedTasks(String companyId, String teamName) async {
    final url = Uri.parse('${ApiUrl.baseUrl}/teamportalApis/teamAssignedTasks/?Company_id=$companyId&team_name=$teamName');

    try {
      isLoading.value = true;
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List tasks = data['orders'];
        assignedTasks.assignAll(tasks.map((task) => AssignedTasksModal.fromJson(task)).toList());
      } else {
        throw Exception('Failed to fetch assigned tasks');
      }
    } catch (e) {
      print('Error fetching tasks: $e');
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }
}