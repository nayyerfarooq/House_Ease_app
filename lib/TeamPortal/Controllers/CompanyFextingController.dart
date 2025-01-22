// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:shift_ease_fyp/widgets/custom_snakbar.dart';
// import 'dart:convert';
// import '../../apiUrl.dart';
//
// class TeamCompanyController extends GetxController {
//   var companies = <String>[].obs;
//   var selectedCompany = ''.obs;
//   var companiesId = <String>[].obs;
//   @override
//   void onInit() {
//     fetchCompanies();
//     super.onInit();
//   }
//
//   void fetchCompanies() async {
//     try {
//       final response = await http.get(Uri.parse('${ApiUrl.baseUrl}/adminapis/providersdata/'));
//       if (response.statusCode == 200) {
//         List<dynamic> data = json.decode(response.body);
//         companies.value = data.map((company) => company['id'] as String).toList();
//       } else {
//         Get.snackbar("Error", "Failed to load companies");
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
// }
