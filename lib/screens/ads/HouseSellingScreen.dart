import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shift_ease_fyp/widgets/app_colors.dart'; // Import the custom color file

class HouseSellingScreen extends StatefulWidget {
  @override
  _HouseSellingScreenState createState() => _HouseSellingScreenState();
}

class _HouseSellingScreenState extends State<HouseSellingScreen> {
  final ImagePicker _picker = ImagePicker();
  List<XFile> _imageFileList = [];

  String? _selectedCountry; // Variable to store the selected country
  String? _selectedCity; // Variable to store the selected city
  String? _address; // Variable to store the entered address

  // Map to store lists of cities for each country
  final Map<String, List<String>> citiesByCountry = {
    'Pakistan': [
      'Karachi', 'Lahore', 'Islamabad', 'Rawalpindi', 'Faisalabad', 'Peshawar',
      'Quetta', 'Multan', 'Sialkot', 'Gujranwala', 'Hyderabad', 'Sargodha',
      'Bahawalpur', 'Sukkur', 'Mardan', 'Sheikhupura', 'Jhelum', 'Gujrat',
      'Sahiwal', 'Larkana', 'Kasur', 'Abbottabad', 'Okara', 'Dera Ghazi Khan',
      'Muzaffargarh', 'Mingora', 'Sadiqabad', 'Nawabshah', 'Chiniot', 'Khushab',
      'Muzaffarabad', 'Mirpur', 'Kotli', 'Bagh', 'Rawalakot', 'Pallandri',
      'Haveli', 'Bhimber', 'Sudhnoti', 'Hattian Bala', 'Neelum Valley'
    ],
    'USA': [
      'New York', 'Los Angeles', 'Chicago', 'Houston', 'Phoenix', 'Philadelphia',
      'San Antonio', 'San Diego', 'Dallas', 'San Jose', 'Austin', 'Jacksonville',
      'Fort Worth', 'Columbus', 'Charlotte', 'San Francisco', 'Indianapolis',
      'Seattle', 'Denver', 'Washington D.C.'
    ],
    'UK': [
      'London', 'Birmingham', 'Leeds', 'Glasgow', 'Sheffield', 'Bradford',
      'Liverpool', 'Edinburgh', 'Manchester', 'Bristol', 'Kirklees', 'Fife',
      'Wirral', 'North Lanarkshire', 'Wakefield', 'Cardiff', 'Dudley', 'Wigan',
      'East Riding', 'South Lanarkshire'
    ],
    'Canada': [
      'Toronto', 'Montreal', 'Vancouver', 'Calgary', 'Edmonton', 'Ottawa',
      'Winnipeg', 'Quebec City', 'Hamilton', 'Kitchener', 'London', 'Victoria',
      'Halifax', 'Oshawa', 'Windsor', 'Saskatoon', 'St. Catharines', 'Regina',
      'St. John\'s', 'Kelowna'
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryDarkColor, // Use custom color
        title: Text(
          'Sell Your House',
          style: TextStyle(color: AppColors.accentColor), // Use custom color
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageList(),
            _buildAddPhotoButton(context),
            SizedBox(height: 20),
            _buildLocationSection(),
            SizedBox(height: 20),
            _buildFormFields(),
            SizedBox(height: 20),
            _buildFeaturesSection(),
            SizedBox(height: 20),
            _buildContactInformation(),
            SizedBox(height: 20),
            _buildPostAdButton(),
          ],
        ),
      ),
    );
  }

  Future<void> _takePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        _imageFileList.add(photo);
      });
    }
  }

  Future<void> _selectFromGallery() async {
    final List<XFile>? photos = await _picker.pickMultiImage();
    if (photos != null && photos.isNotEmpty) {
      setState(() {
        _imageFileList.addAll(photos);
      });
    }
  }

  Widget _buildImageList() {
    return _imageFileList.isEmpty
        ? Center(child: Text('No Images Selected'))
        : GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: _imageFileList.length,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            Image.file(File(_imageFileList[index].path), fit: BoxFit.cover),
            Positioned(
              right: 0,
              top: 0,
              child: IconButton(
                icon: Icon(Icons.cancel, color: Colors.red),
                onPressed: () {
                  setState(() {
                    _imageFileList.removeAt(index);
                  });
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAddPhotoButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return buildBottomSheet(context);
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.camera_alt_outlined, size: 40, color: AppColors.primaryDarkColor),
              SizedBox(height: 8),
              Text(
                'Add Photo',
                style: TextStyle(color: AppColors.primaryDarkColor, fontSize: 16),
              ),
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
            Text('Location', style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedCountry,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Select Country',
                prefixIcon: Icon(Icons.flag),
              ),
              items: citiesByCountry.keys
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCountry = value;
                  _selectedCity = null; // Reset city when country changes
                });
              },
            ),
            SizedBox(height: 16),
            if (_selectedCountry != null)
              DropdownButtonFormField<String>(
                value: _selectedCity,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Select City',
                  prefixIcon: Icon(Icons.location_city),
                ),
                items: citiesByCountry[_selectedCountry]!
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCity = value;
                  });
                },
              ),
            SizedBox(height: 16),
            if (_selectedCity != null)
              TextFormField(
                initialValue: _address,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Address',
                  prefixIcon: Icon(Icons.home),
                ),
                onChanged: (value) {
                  setState(() {
                    _address = value;
                  });
                },
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
            buildHouseTypeField(),
            buildInputField('Built Year', icon: Icons.calendar_today),
            buildInputField('Number of Bedrooms', icon: Icons.king_bed),
            buildInputField('Number of Bathrooms', icon: Icons.bathtub),
            buildInputField('Area (Square Feet)', icon: Icons.square_foot),
            buildFurnishingField(),
            buildInputField('Price (PKR)', icon: Icons.money),
            buildInputField('Write Useful Description', maxLines: 4, icon: Icons.description),
          ],
        ),
      ),
    );
  }

  Widget buildHouseTypeField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'House Type',
          prefixIcon: Icon(Icons.home),
        ),
        items: [
          'Detached House',
          'Semi-Detached House',
          'Townhouse',
          'Apartment',
          'Penthouse',
          'Bungalow',
          'Duplex',
          'Villa',
          'Farmhouse',
          'Cottage',
          'Condo/Condominium',
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            // Handle the selected value here
          });
        },
      ),
    );
  }

  Widget buildFurnishingField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Furnishing',
          prefixIcon: Icon(Icons.chair),
        ),
        items: [
          'Fully Furnished',
          'Semi-Furnished',
          'Unfurnished',
          'Partially Furnished',
          'Customizable',
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            // Handle the selected value here
          });
        },
      ),
    );
  }

  Widget _buildFeaturesSection() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Features', style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: [
                Chip(label: Text('Garage')),
                Chip(label: Text('Garden')),
                Chip(label: Text('Pool')),
              ],
            ),
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
            Text('Contact Information', style: Theme.of(context).textTheme.titleLarge),
            buildInputField('Name', icon: Icons.person),
            buildInputField('Mobile Number', icon: Icons.phone),
            SwitchListTile(
              title: Text('Allow WhatsApp Contact'),
              value: true,
              onChanged: (val) {},
              secondary: Icon(Icons.message),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostAdButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        child: Text('Post Your Ad', style: TextStyle(color: AppColors.accentColor)),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15),
          backgroundColor: AppColors.primaryDarkColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }

  Widget buildInputField(String label, {int maxLines = 1, IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        maxLines: maxLines,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
          prefixIcon: icon != null ? Icon(icon) : null,
        ),
      ),
    );
  }

  Widget buildBottomSheet(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      height: 195,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Upload Photos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              IconButton(
                icon: Icon(Icons.close, color: Colors.red),
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.camera_alt, color: Colors.blue),
            title: Text('Take photos with camera'),
            onTap: () async {
              Navigator.pop(context);
              await _takePhoto();
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_library, color: Colors.blue),
            title: Text('Upload photos from gallery'),
            onTap: () async {
              Navigator.pop(context);
              await _selectFromGallery();
            },
          ),
        ],
      ),
    );
  }
}
