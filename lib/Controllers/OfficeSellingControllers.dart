import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shift_ease_fyp/widgets/custom_snakbar.dart';

import '../Modals/RentAdsModal.dart';

class OfficeSellingController extends GetxController {
  final ImagePicker picker = ImagePicker();
  var imageFileList = <XFile>[].obs;
  var selectedCountry = ''.obs;
  var selectedCity = ''.obs;
  var address = ''.obs;
  var title = ''.obs;
  var description = ''.obs;
  var officeType = ''.obs;
  var floorNumber=''.obs;
  var area = ''.obs;
  var buildingType=''.obs;
  var price = ''.obs;
  var ownerName = ''.obs;
  var mobileNumber = ''.obs;
  var isLoading = false.obs;

  final Map<String, List<String>> citiesByCountry = {
    'Pakistan':
    ['Karachi', 'Lahore', 'Islamabad', 'Rawalpindi', 'Faisalabad', 'Peshawar',
      'Quetta', 'Multan', 'Sialkot', 'Gujranwala', 'Hyderabad', 'Sargodha',
      'Bahawalpur', 'Sukkur', 'Mardan', 'Sheikhupura', 'Jhelum', 'Gujrat',
      'Sahiwal', 'Larkana', 'Kasur', 'Abbottabad', 'Okara', 'Dera Ghazi Khan',
      'Muzaffargarh', 'Mingora', 'Sadiqabad', 'Nawabshah', 'Chiniot', 'Khushab',
      'Muzaffarabad', 'Mirpur', 'Kotli', 'Bagh', 'Rawalakot', 'Pallandri',
      'Haveli', 'Bhimber', 'Sudhnoti', 'Hattian Bala', 'Neelum Valley'],
    'USA':
    [ 'New York', 'Los Angeles', 'Chicago', 'Houston', 'Phoenix', 'Philadelphia',
      'San Antonio', 'San Diego', 'Dallas', 'San Jose', 'Austin', 'Jacksonville',
      'Fort Worth', 'Columbus', 'Charlotte', 'San Francisco', 'Indianapolis',
      'Seattle', 'Denver', 'Washington D.C.'],
    'UK':
    ['London', 'Birmingham', 'Leeds', 'Glasgow', 'Sheffield', 'Bradford',
      'Liverpool', 'Edinburgh', 'Manchester', 'Bristol', 'Kirklees', 'Fife',
      'Wirral', 'North Lanarkshire', 'Wakefield', 'Cardiff', 'Dudley', 'Wigan',
      'East Riding', 'South Lanarkshire'],
    'Canada':
    ['Toronto', 'Montreal', 'Vancouver', 'Calgary', 'Edmonton', 'Ottawa',
      'Winnipeg', 'Quebec City', 'Hamilton', 'Kitchener', 'London', 'Victoria',
      'Halifax', 'Oshawa', 'Windsor', 'Saskatoon', 'St. Catharines', 'Regina',
      'St. John\'s', 'Kelowna']
  };

  Future<void> takePhoto() async {
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      imageFileList.add(photo);
    }
  }

  Future<void> selectFromGallery() async {
    final List<XFile>? photos = await picker.pickMultiImage();
    if (photos != null && photos.isNotEmpty) {
      imageFileList.addAll(photos);
    }
  }
  void sendValues() {
    try{
      RentAdModal officeData = RentAdModal(
           images: imageFileList.map((image) => image.path).toList(),
           country: selectedCountry.value,
           city: selectedCity.value,
           address: address.value,
           title: title.value,
           description: description.value,
           pricePerMonth: price.value,
           officeType: officeType.value,
           officeSize: area.value,
           floorNumber: floorNumber.value,
           buildingType: buildingType.value,
           ownerName: ownerName.value,
           ownerNumber: mobileNumber.value,
           ownerEmail: 'moonshab355@gmail.com',
           requestStatus: 'Pending',
           propertyType: 'Office',
       );
    }
    catch(e){
      showErrorSnackbar(e.toString());
    }
  }
}