import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:shift_ease_fyp/widgets/custom_snakbar.dart';
import '../Modals/RentAdsModal.dart';
import '../apiUrl.dart';

Future<void> postRentAd(RentAdModal rentAd) async {
  const String url = '${ApiUrl.baseUrl}/adminapis/RentAdData/';

  try {
    var request = http.MultipartRequest('POST', Uri.parse(url));


    request.fields['title'] = rentAd.title;
    request.fields['propertyType'] = rentAd.propertyType;
    request.fields['country'] = rentAd.country;
    request.fields['city'] = rentAd.city;
    request.fields['address'] = rentAd.address;
    request.fields['price_per_month'] = rentAd.pricePerMonth;
    request.fields['ownerName'] = rentAd.ownerName;
    request.fields['ownerNumber'] = rentAd.ownerNumber;
    request.fields['ownerEmail'] = rentAd.ownerEmail;
    request.fields['requestStatus'] = rentAd.requestStatus;
    if (rentAd.furnishing != null) request.fields['furnishing'] = rentAd.furnishing!;
    request.fields['Description'] = rentAd.description;
    if (rentAd.houseType != null) request.fields['houseType'] = rentAd.houseType!;
    if (rentAd.builtYear != null) request.fields['builtYear'] = rentAd.builtYear!;
    if (rentAd.bedrooms != null) request.fields['bedrooms'] = rentAd.bedrooms!;
    if (rentAd.bathrooms != null) request.fields['bathrooms'] = rentAd.bathrooms!;
    if (rentAd.area != null) request.fields['area'] = rentAd.area!;
    if (rentAd.officeType != null) request.fields['officeType'] = rentAd.officeType!;
    if (rentAd.officeSize != null) request.fields['officeSize'] = rentAd.officeSize!;
    if (rentAd.floorNumber != null) request.fields['floorNumber'] = rentAd.floorNumber!;
    if (rentAd.buildingType != null) request.fields['buildingType'] = rentAd.buildingType!;
    if (rentAd.apartmentType != null) request.fields['apartmentType'] = rentAd.apartmentType!;
    if (rentAd.apartmentSize != null) request.fields['apartmentSize'] = rentAd.apartmentSize!;

    for (var imagePath in rentAd.images) {
      var file = File(imagePath);
      var fileName = basename(file.path);
      request.files.add(await http.MultipartFile.fromPath('images', file.path, filename: fileName));
    }

    var response = await request.send();

    if (response.statusCode == 201) {
      showSuccessSnackbar('Rent ad posted successfully');
    } else {
      showErrorSnackbar('Failed to post rent ad. Status code: ${response.statusCode}');
      print('Error: ${await response.stream.bytesToString()}');
    }
  } catch (e) {
    print('Error posting rent ad: $e');
    showErrorSnackbar('Error posting rent ad: $e');
  }
}
