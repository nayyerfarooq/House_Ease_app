import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../apiUrl.dart';

class TeamCompanyController extends GetxController {
  var companies = <String>[].obs;
  var selectedCompany = ''.obs;

  @override
  void onInit() {
    fetchCompanies();
    super.onInit();
  }

  void fetchCompanies() async {
    try {
      final response = await http.get(Uri.parse('${ApiUrl.baseUrl}/adminapis/providersdata/'));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        companies.value = data.map((company) => company['company_name'] as String).toList();
      } else {
        Get.snackbar("Error", "Failed to load companies");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred");
    }
  }
}
