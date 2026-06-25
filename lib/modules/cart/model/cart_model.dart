import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/data/models/product_model.dart';
import 'package:get/get.dart';

class CartModel {
  final ProductModel product;
  Color color;
  String? selectedStorage;
  RxInt quantity;
  RxBool isSelected;
  RxBool isEditingQty;

  CartModel({
    required this.product,
    required this.color,
    this.selectedStorage,
    int quantity = 1,
    bool isSelected = false,
    bool isEditingQty = false,
  }) : quantity = quantity.obs,
       isSelected = isSelected.obs,
       isEditingQty = false.obs;

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      product: ProductModel.fromJson(json['product']),
      color: Color(json['color']),
      selectedStorage: json['selectedStorage'],
      quantity: json['quantity'],
      isSelected: json['isSelected'] ?? false,
      isEditingQty: json['isEditingQty'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'color': color.toARGB32(),
      'selectedStorage': selectedStorage,
      'quantity': quantity.value,
      'isSelected': isSelected.value,
      'isEditingQty': isEditingQty.value,
    };
  }
}
