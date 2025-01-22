class AssignedTasksModal {
  final String companyId;
  final String clientName;
  final String location;
  final String serviceDate;
  final String packageId;
  final String packagePrice;
  final String teamName;
  final String orderStatus;

  AssignedTasksModal({
    required this.companyId,
    required this.clientName,
    required this.location,
    required this.serviceDate,
    required this.packageId,
    required this.packagePrice,
    required this.teamName,
    required this.orderStatus,
  });

  factory AssignedTasksModal.fromJson(Map<String, dynamic> json) {
    return AssignedTasksModal(
      companyId: json['Company_id'] ?? '',
      clientName: json['client_name'] ?? '',
      location: json['location'] ?? '',
      serviceDate: json['service_date'] ?? '',
      packageId: json['package_id'] ?? '',
      packagePrice: json['package_price'] ?? '',
      teamName: json['team_name'] ?? '',
      orderStatus: json['order_status'] ?? '',
    );
  }
}