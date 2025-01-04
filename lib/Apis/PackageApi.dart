import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shift_ease_fyp/apiUrl.dart';
import 'dart:convert';
import '../Modals/ShiftingPackagesModal.dart';

class ShiftHouseController extends GetxController {
  var shiftingPackages = <ShiftingPackagesModal>[].obs;
  var decoratingPackages = <ShiftingPackagesModal>[].obs;
  var AllinOnePackages = <ShiftingPackagesModal>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPackages();
  }
  Future<void> fetchPackages() async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse('${ApiUrl.baseUrl}/providerapis/packagesdata/'));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        List<ShiftingPackagesModal> ShiftingFetchedPackages = (data as List)
            .map((package) => ShiftingPackagesModal.fromJson(package))
            .where((package) => package.service == 'Shifting')
            .toList();
        shiftingPackages.value = ShiftingFetchedPackages;

        // For decorating packages
        List<ShiftingPackagesModal> DecoratingfetchedPackages = (data as List)
            .map((package) => ShiftingPackagesModal.fromJson(package))
            .where((package) => package.service == 'Decorating')
            .toList();
        decoratingPackages.value = DecoratingfetchedPackages;
        // For all-in-one packages
        List<ShiftingPackagesModal> AllfetchedPackages = (data as List)
            .map((package) => ShiftingPackagesModal.fromJson(package))
            .where((package) => package.service == 'Shifting and Decorating')
            .toList();
        AllinOnePackages.value = AllfetchedPackages;
      } else {
        errorMessage('Failed to load Packages');
      }
    } catch (e) {
      errorMessage('Error: $e');
      print(e.toString());
    } finally {
      isLoading(false); // Stop loading
    }
  }
}
