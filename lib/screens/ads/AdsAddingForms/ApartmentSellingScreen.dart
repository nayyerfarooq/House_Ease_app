import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shift_ease_fyp/Controllers/ApartmentSellingController.dart';
import 'package:shift_ease_fyp/widgets/CustomElevatedButton.dart';
import 'package:shift_ease_fyp/widgets/CustomTextWidget.dart';
import 'package:shift_ease_fyp/widgets/app_colors.dart';

import '../../../widgets/custom_snakbar.dart';

class ApartmentSellingScreen extends StatefulWidget {
  @override
  State<ApartmentSellingScreen> createState() => _ApartmentSellingScreenState();
}

class _ApartmentSellingScreenState extends State<ApartmentSellingScreen> {
  final Apartmentsellingcontroller controller = Get.put(Apartmentsellingcontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryDarkColor,
        title: const Text('Sell Your Apartment', style: TextStyle(color: AppColors.accentColor)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => _buildImageList()),
            _buildAddPhotoButton(context),
            const SizedBox(height: 20),
            _buildLocationSection(),
            const SizedBox(height: 20),
            _buildFormFields(),
            const SizedBox(height: 20),
            _buildContactInformation(),
            const SizedBox(height: 20),
            _buildPostAdButton(),
          ],
        ),
      ),
    );
  }
  Widget _buildImageList() {
    return controller.imageFileList.isEmpty
        ? const Center(child: Text('No Images Selected'))
        : SizedBox(
      height: 200,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Display 3 images in a row
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: controller.imageFileList.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Image.file(
                File(controller.imageFileList[index].path),
                fit: BoxFit.cover,
              ),
              Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                  icon: const Icon(Icons.cancel, color: Colors.red),
                  onPressed: () {
                    controller.imageFileList.removeAt(index);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
  Widget _buildAddPhotoButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return _buildBottomSheet(context);
          },
        );
      },
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: AppColors.primaryDarkColor.withOpacity(0.1),
          border: Border.all(color: AppColors.primaryDarkColor, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.camera_alt_outlined, size: 40, color: AppColors.primaryDarkColor),
              SizedBox(height: 8),
              Text('Add Photo', style: TextStyle(color: AppColors.primaryDarkColor, fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildLocationSection() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomTextWidget(title: 'Location',size: 25,),
            const SizedBox(height: 16),
            Obx(
                  () => DropdownButtonFormField<String>(
                value: controller.selectedCountry.value.isEmpty
                    ? null
                    : controller.selectedCountry.value,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Select Country',
                  prefixIcon: Icon(Icons.flag),
                ),
                items: controller.citiesByCountry.keys
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.selectedCountry.value = value!;
                  controller.selectedCity.value = '';
                },
              ),
            ),
            const SizedBox(height: 16),
            Obx(
                  () => DropdownButtonFormField<String>(
                value: controller.selectedCity.value.isEmpty
                    ? null
                    : controller.selectedCity.value,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Select City',
                  prefixIcon: Icon(Icons.location_city),
                ),
                items: controller.citiesByCountry[controller.selectedCountry.value]
                    ?.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList() ??
                    [],
                onChanged: (value) {
                  controller.selectedCity.value = value!;
                },
              ),
            ),
            const SizedBox(height: 16),
            Obx(
                  () => TextFormField(
                initialValue: controller.address.value,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Address',
                  prefixIcon: Icon(Icons.home),
                ),
                onChanged: (value) {
                  controller.address.value = value;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildFormFields() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildInputField(TextInputType.text,'Title', controller.title, Icons.title),
            _buildDropdownField('Apartment Type', controller.apartmentType, [
              'Studio', 'One Bed Room',
              'Two bed Rooms','Penthouse',
            ]),
            _buildInputField(TextInputType.number,'Floor Number', controller.floorNumber, Icons.numbers),
            _buildInputField(TextInputType.number,'Number of Bedrooms', controller.bedrooms, Icons.king_bed),
            _buildInputField(TextInputType.number,'Number of Bathrooms', controller.bathrooms, Icons.bathtub),
            _buildInputField(TextInputType.number,'Area (Square Feet)', controller.area, Icons.square_foot),
            _buildDropdownField('Furnishing', controller.furnishing, [
              'Fully Furnished', 'Semi-Furnished', 'Unfurnished', 'Partially Furnished',
            ]),
            _buildInputField(TextInputType.number,'Price Per Month (PKR)', controller.price, Icons.money),
            _buildInputField(TextInputType.text,'Write Useful Description', controller.description, Icons.description, maxLines: 4),
          ],
        ),
      ),
    );
  }
  Widget _buildContactInformation() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CustomTextWidget(title: 'Contact Information',size: 22,),
            _buildInputField(TextInputType.text,'Your Name', controller.ownerName, Icons.person),
            _buildInputField(TextInputType.number,'Mobile Number', controller.mobileNumber, Icons.phone),
          ],
        ),
      ),
    );
  }
  Widget _buildPostAdButton() {
    return Center(
      child:Obx((){
        return controller.isLoading.value ?
        const CircularProgressIndicator() :
        CustomElevatedButton(
            text:'Post Ad',
            color: Colors.white,
            width: Get.width,
            height: 20,
            radius: 10,
            padding: 18,
            backcolor:AppColors.primaryDarkColor,
            path: (){
              controller.isLoading.value = true;
              try{
                controller.sendValues();
              }catch(e){
                showErrorSnackbar(e.toString());
              }finally{
                controller.isLoading.value = false;
              }
            }
        );
      }),
    );
  }

  // Bottom Sheet for selecting photo options
  Widget _buildBottomSheet(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      height: 195,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Upload Photos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              IconButton(
                icon: const Icon(Icons.close,color: Colors.red,),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt, color: Colors.blue),
            title: const Text('Take Photo with Camera', style: TextStyle(color: Colors.black)),
            onTap: () {
              controller.selectFromGallery();
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library, color: Colors.blue),
            title: const Text('Choose from Gallery', style: TextStyle(color: Colors.black)),
            onTap: () {
              controller.takePhoto();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
  Widget _buildDropdownField(String label, RxString selectedValue, List<String> items) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: DropdownButtonFormField<String>(
          value: selectedValue.value.isEmpty ? null : selectedValue.value,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: label,
            prefixIcon: const Icon(Icons.home),
          ),
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            selectedValue.value = value!;
          },
        ),
      );
    });
  }
  Widget _buildInputField(TextInputType type,String label, RxString field, IconData icon, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        initialValue: field.value,
        keyboardType: type,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
          prefixIcon: Icon(icon),
        ),
        maxLines: maxLines,
        onChanged: (value) {
          field.value = value;
        },
      ),
    );
  }
}
