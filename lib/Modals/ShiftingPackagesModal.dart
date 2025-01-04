class ShiftingPackagesModal {
  final String name;
  final String service;
  final int company;
  final int price ;
  final int id;
  final String imagePath;
  ShiftingPackagesModal({
    required this.name,
    required this.id,
    required this.service,
    required this.company,
    required this.price,
    required this.imagePath,
  });

  factory ShiftingPackagesModal.fromJson(Map<String, dynamic> json) {
    return ShiftingPackagesModal(
      name: json['package_name'] ?? 'Unknown',
      id: json['id'] ?? 0,
      service: json['package_service'] ?? 'Unknown',
      price: json['package_price'] ?? 0,
      imagePath: json['package_image'] ?? '',
      company: json['company_id'] ?? 0,
    );
  }
}