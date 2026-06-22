import 'package:flutter_ecommerce_app/data/models/product_model.dart';
import 'package:get/get.dart';

class CartModel {
  final ProductModel product;
  RxInt quantity;

  CartModel({required this.product, int quantity = 1})
    : quantity = quantity.obs;
}
