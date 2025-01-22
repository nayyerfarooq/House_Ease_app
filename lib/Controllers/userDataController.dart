import 'package:get/get.dart';
import '../utils/SharedPreferences.dart';

class UserController extends GetxController {
  RxBool isLoading = false.obs;
  RxMap<String, dynamic> userData = RxMap();

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      isLoading.value = true;
      final data = await getUserData();
      userData.value = data ?? {};
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch user data: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
