class RentAdImage {
  final String image;

  RentAdImage({required this.image});

  factory RentAdImage.fromJson(Map<String, dynamic> json) {
    return RentAdImage(
      image: json['image'] ?? '',
    );
  }
}

class FetchRentAdModal {
  final String title;
  final String propertyType;
  final String country;
  final String city;
  final String address;
  final String pricePerMonth;
  final String ownerName;
  final String ownerNumber;
  final String ownerEmail;
  final String requestStatus;
  final String? furnishing;
  final String description;

  final String? houseType;
  final String? builtYear;
  final String? bedrooms;
  final String? bathrooms;
  final String? area;

  final String? officeType;
  final String? officeSize;
  final String? floorNumber;
  final String? buildingType;

  final String? apartmentType;
  final String? apartmentSize;

  final List<RentAdImage> images;

  FetchRentAdModal({
    required this.title,
    required this.propertyType,
    required this.country,
    required this.city,
    required this.address,
    required this.pricePerMonth,
    required this.ownerName,
    required this.ownerNumber,
    required this.ownerEmail,
    required this.requestStatus,
    this.furnishing,
    required this.description,
    this.houseType,
    this.builtYear,
    this.bedrooms,
    this.bathrooms,
    this.area,
    this.officeType,
    this.officeSize,
    this.floorNumber,
    this.buildingType,
    this.apartmentType,
    this.apartmentSize,
    this.images = const [],
  });

  factory FetchRentAdModal.fromJson(Map<String, dynamic> json) {
    return FetchRentAdModal(
      title: json['title'] ?? '',
      propertyType: json['propertyType'] ?? '',
      country: json['country'] ?? '',
      city: json['city'] ?? '',
      address: json['address'] ?? '',
      pricePerMonth: json['price_per_month'] ?? '',
      ownerName: json['ownerName'] ?? '',
      ownerNumber: json['ownerNumber'] ?? '',
      ownerEmail: json['ownerEmail'] ?? '',
      requestStatus: json['requestStatus'] ?? '',
      furnishing: json['furnishing'] ?? '',
      description: json['Description'] ?? '',

      houseType: json['houseType'] ?? '',
      builtYear: json['builtYear'] ?? '',
      bedrooms: json['bedrooms'] ?? '',
      bathrooms: json['bathrooms'] ?? '',
      area: json['area'] ?? '',

      officeType: json['officeType'] ?? '',
      officeSize: json['officeSize'] ?? '',
      floorNumber: json['floorNumber'] ?? '',
      buildingType: json['buildingType'] ?? '',

      apartmentType: json['apartmentType'] ?? '',
      apartmentSize: json['apartmentSize'] ?? '',

      images: (json['images'] as List<dynamic>?)
          ?.map((imageJson) => RentAdImage.fromJson(imageJson))
          .toList() ?? [],
    );
  }
}
