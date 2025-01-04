import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shift_ease_fyp/Modals/CompanyDataModal.dart';
import 'package:shift_ease_fyp/apiUrl.dart';
import 'package:shift_ease_fyp/widgets/custom_snakbar.dart';

class CompanyController extends GetxController {
  var companies = <CompanyDataModal>[].obs;
  var isLoading = true.obs;
  var companyDetails = Rxn<CompanyDataModal>();

  @override
  void onInit() {
    fetchCompanies();
    super.onInit();
  }

  Future<void> fetchCompanies() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('${ApiUrl.baseUrl}/adminapis/providersdata/'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        companies.value = data.map((json) => CompanyDataModal.fromJson(json)).toList();
        print('Loaded companies from API');
      } else {
        showErrorSnackbar('Failed to load company data');
        print('Failed to load company data');
      }
    } catch (e) {
      showErrorSnackbar('Error: $e');
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }
}
