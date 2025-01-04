class CompanyDataModal {
  final String name;
  final String address;
  final String email;
  final String service;
  final String logoPath;
  final int Companyid;
  final String MobileNo;

  CompanyDataModal({
    required this.name,
    required this.address,
    required this.email,
    required this.service,
    required this.logoPath,
    required this.Companyid,
    required this.MobileNo,
  });

  factory CompanyDataModal.fromJson(Map<String, dynamic> json) {
    return CompanyDataModal(
      name: json['company_name'],
      email: json['email'],
      address: json['location'],
      service: json['service'],
      logoPath: json['profile_image'],
      Companyid: json['id'],
      MobileNo: json['mobile_no'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'company_name': name,
      'email': email,
      'location': address,
      'service': service,
      'profile_image': logoPath,
      'id': Companyid,
      'mobile_no': MobileNo,
    };
  }
}