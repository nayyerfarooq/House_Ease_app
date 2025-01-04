import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shift_ease_fyp/Modals/RentAdFetchModal.dart';
import 'package:shift_ease_fyp/apiUrl.dart';
import 'package:shift_ease_fyp/widgets/custom_snakbar.dart';

class FetchingAdsData extends GetxController {
  var rentAdsData = <FetchRentAdModal>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  var activeAds = <FetchRentAdModal>[].obs;
  var pendingAds = <FetchRentAdModal>[].obs;
  var rejectedAds = <FetchRentAdModal>[].obs;

  Future<void> fetchAdsData() async {
    String apiUrl = '${ApiUrl.baseUrl}/adminapis/RentAdData/';

    try {
      isLoading(true);
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var data = json.decode(response.body) as List;
        rentAdsData.value = data.map((json) => FetchRentAdModal.fromJson(json)).toList();

        activeAds.clear();
        pendingAds.clear();
        rejectedAds.clear();

        for (var ad in rentAdsData) {
          switch (ad.requestStatus) {
            case 'Active':
              activeAds.add(ad);
              break;
            case 'Pending':
              pendingAds.add(ad);
              break;
            case 'Rejected':
              rejectedAds.add(ad);
              break;
            default:
              break;
          }
        }
      } else {
        errorMessage.value = 'Failed to load house data. Status code: ${response.statusCode}';
        showErrorSnackbar(errorMessage.value);
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
      showErrorSnackbar(errorMessage.value);
    } finally {
      isLoading(false);
    }
  }
}


