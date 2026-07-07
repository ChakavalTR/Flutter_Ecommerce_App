class ShippingAddressModel {
  final String id;
  final String fullName;
  final String phone;
  final String address;
  final String city;
  final String postalCode;
  final String country;
  final bool isDefault;
  ShippingAddressModel({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.address,
    required this.city,
    required this.postalCode,
    required this.country,
    this.isDefault = false,
  });
  ShippingAddressModel copyWith({
    String? id,
    String? fullName,
    String? phone,
    String? address,
    String? city,
    String? postalCode,
    String? country,
    bool? isDefault,
  }) {
    return ShippingAddressModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      city: city ?? this.city,
      postalCode: postalCode ?? this.postalCode,
      country: country ?? this.country,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  factory ShippingAddressModel.fromJson(Map<String, dynamic> json) {
    return ShippingAddressModel(
      id: json['id'],
      fullName: json['fullName'],
      phone: json['phone'],
      address: json['address'],
      city: json['city'],
      postalCode: json['postalCode'],
      country: json['country'],
      isDefault: json['isDefault'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'phone': phone,
      'address': address,
      'city': city,
      'postalCode': postalCode,
      'country': country,
      'isDefault': isDefault,
    };
  }
}
