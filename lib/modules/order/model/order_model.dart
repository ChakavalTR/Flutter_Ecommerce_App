import 'package:flutter_ecommerce_app/modules/cart/model/cart_model.dart';
import 'package:flutter_ecommerce_app/modules/checkout/model/shipping_address_model.dart';

class OrderModel {
  final String orderNumber;
  final String orderDate;
  final String paymentMethod;
  final ShippingAddressModel shippingAddress;
  final List<CartModel> orderItems;
  final double subTotal;
  final double shippingFee;
  final double discount;
  final double totalPaid;
  final String status;

  OrderModel({
    required this.orderNumber,
    required this.orderDate,
    required this.paymentMethod,
    required this.shippingAddress,
    required this.orderItems,
    required this.subTotal,
    required this.shippingFee,
    required this.discount,
    required this.totalPaid,
    this.status = 'Completed',
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderNumber: json['orderNumber'] ?? '',
      orderDate: json['orderDate'] ?? '',
      paymentMethod: json['paymentMethod'] ?? '',
      shippingAddress: ShippingAddressModel.fromJson(
        Map<String, dynamic>.from(json['shippingAddress']),
      ),
      orderItems: (json['orderItems'] as List<dynamic>? ?? [])
          .map((item) => CartModel.fromJson(Map<String, dynamic>.from(item)))
          .toList(),
      subTotal: (json['subTotal'] as num?)?.toDouble() ?? 0,
      shippingFee: (json['shippingFee'] as num?)?.toDouble() ?? 0,
      discount: (json['discount'] as num?)?.toDouble() ?? 0,
      totalPaid: (json['totalPaid'] as num?)?.toDouble() ?? 0,
      status: json['status'] ?? 'Completed',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderNumber': orderNumber,
      'orderDate': orderDate,
      'paymentMethod': paymentMethod,
      'shippingAddress': shippingAddress.toJson(),
      'orderItems': orderItems.map((item) => item.toJson()).toList(),
      'subTotal': subTotal,
      'shippingFee': shippingFee,
      'discount': discount,
      'totalPaid': totalPaid,
      'status': status,
    };
  }
}
