class CartItemsModal {
  final String clientName;
  final String location;
  final DateTime serviceDate;
  final String packageId;
  final String packagePrice;
  final String companyId;
  final String orderStatus;
  // final String orderPersonId;
  final String teamName;
  final int orderId;
  CartItemsModal({
    required this.clientName,
    required this.location,
    required this.serviceDate,
    required this.packageId,
    required this.packagePrice,
    required this.companyId,
    required this.orderStatus,
    // required this.orderPersonId,
    required this.teamName,
    required this.orderId,
  });


  factory CartItemsModal.fromJson(Map<dynamic, dynamic> json) {
    return CartItemsModal(
      clientName: json['client_name'] ?? '',
      location: json['location'] ?? '',
      serviceDate: DateTime.parse(json['service_date'] ?? DateTime.now().toString()),
      orderId: json['id'] ?? '',
      packageId: json['package_id'] ?? '',
      packagePrice: json['package_price'] ?? '',
      companyId: json['Company_id'] ?? '',
      orderStatus: json['order_status'] ?? '',
      // orderPersonId: json['OrderPersonId'] ?? '',
      teamName: json['team_name'] ?? '',
    );
  }

}
