import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../widgets/app_colors.dart'; // Import your custom color file

class ApartmentSellingScreen extends StatefulWidget {
  @override
  _ApartmentSellingScreenState createState() => _ApartmentSellingScreenState();
}

class _ApartmentSellingScreenState extends State<ApartmentSellingScreen> {
  final ImagePicker _picker = ImagePicker();
  List<XFile> _imageFileList = [];

  // Variables for apartment details
  String? _selectedCountry; // Variable to store the selected country
  String? _selectedCity;    // Variable to store the selected city
  String? _address;         // Variable to store the entered address
  String? _title;
  String? _description;
  String? _price;
  String? _apartmentType;
  double? _size;
  int? _floorNumber;
  int? _bedrooms;
  int? _bathrooms;
  String? _furnishingStatus;
  String? _contactPerson;
  String? _phoneNumber;
  String? _emailAddress;
  String? _availability;
  String? _hoaFees;

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

  Future<void> _pickImage(ImageSource source) async {
    try {
      if (source == ImageSource.camera) {
        final XFile? image = await _picker.pickImage(source: source);
        if (image != null) {
          setState(() {
            _imageFileList.add(image);
          });
        }
      } else if (source == ImageSource.gallery) {
        final List<XFile>? images = await _picker.pickMultiImage();
        if (images != null && images.isNotEmpty) {
          setState(() {
            _imageFileList.addAll(images);
          });
        }
      }
    } catch (e) {
      print("Error picking image: $e");
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
            _buildInputField('Title', icon: Icons.title),
            _buildInputField('Description', icon: Icons.description, maxLines: 3),
            _buildInputField('Price', icon: Icons.attach_money),
            _buildApartmentTypeField(),
            _buildInputField('Size (sq ft)', icon: Icons.space_bar),
            _buildInputField('Floor Number', icon: Icons.grid_on),
            _buildInputField('Number of Bedrooms', icon: Icons.bedroom_parent),
            _buildInputField('Number of Bathrooms', icon: Icons.bathtub),
            _buildFurnishingField(),
            _buildInputField('Availability', icon: Icons.calendar_today),
            _buildInputField('HOA Fees', icon: Icons.money),
          ],
        ),
      ),
    );
  }

  Widget _buildApartmentTypeField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Apartment Type',
          prefixIcon: Icon(Icons.home),
        ),
        items: [
          DropdownMenuItem(value: 'Studio', child: Text('Studio')),
          DropdownMenuItem(value: '1 Bedroom', child: Text('1 Bedroom')),
          DropdownMenuItem(value: '2 Bedroom', child: Text('2 Bedroom')),
          DropdownMenuItem(value: 'Penthouse', child: Text('Penthouse')),
        ],
        onChanged: (value) {
          setState(() {
            _apartmentType = value;
          });
        },
      ),
    );
  }

  Widget _buildFurnishingField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Furnishing Status',
          prefixIcon: Icon(Icons.chair),
        ),
        items: [
          DropdownMenuItem(value: 'Fully Furnished', child: Text('Fully Furnished')),
          DropdownMenuItem(value: 'Semi-Furnished', child: Text('Semi-Furnished')),
          DropdownMenuItem(value: 'Unfurnished', child: Text('Unfurnished')),
          DropdownMenuItem(value: 'Partially Furnished', child: Text('Partially Furnished')),
        ],
        onChanged: (value) {
          setState(() {
            _furnishingStatus = value;
          });
        },
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
            _buildInputField('Contact Person', icon: Icons.person),
            _buildInputField('Phone Number', icon: Icons.phone),
            _buildInputField('Email Address', icon: Icons.email),
          ],
        ),
      ),
    );
  }

  Widget _buildPostAdButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Handle form submission
        },
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

  Widget _buildInputField(String label, {IconData? icon, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon != null ? Icon(icon) : null,
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          switch (label) {
            case 'Title':
              _title = value;
              break;
            case 'Description':
              _description = value;
              break;
            case 'Price':
              _price = value;
              break;
            case 'Size (sq ft)':
              _size = double.tryParse(value);
              break;
            case 'Floor Number':
              _floorNumber = int.tryParse(value);
              break;
            case 'Number of Bedrooms':
              _bedrooms = int.tryParse(value);
              break;
            case 'Number of Bathrooms':
              _bathrooms = int.tryParse(value);
              break;
            case 'Availability':
              _availability = value;
              break;
            case 'HOA Fees':
              _hoaFees = value;
              break;
            case 'Contact Person':
              _contactPerson = value;
              break;
            case 'Phone Number':
              _phoneNumber = value;
              break;
            case 'Email Address':
              _emailAddress = value;
              break;
          }
        },
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
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
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.camera_alt, color: Colors.blue),
            title: Text('Take Photo with Camera', style: TextStyle(color: Colors.black)),
            onTap: () {
              _pickImage(ImageSource.camera);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_library, color: Colors.blue),
            title: Text('Choose from Gallery', style: TextStyle(color: Colors.black)),
            onTap: () {
              _pickImage(ImageSource.gallery);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryDarkColor,
        title: Text('Sell Your Apartment', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageList(),
            SizedBox(height: 10),
            _buildAddPhotoButton(context),
            SizedBox(height: 20),
            _buildLocationSection(),
            SizedBox(height: 20),
            _buildFormFields(),
            SizedBox(height: 20),
            _buildContactInformation(),
            SizedBox(height: 20),
            _buildPostAdButton(),
          ],
        ),
      ),
    );
  }
}
