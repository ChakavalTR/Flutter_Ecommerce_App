import 'dart:convert';

import 'package:flutter_ecommerce_app/modules/order/model/order_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderController extends GetxController {
  //* Variables Section *\\
  static const String orderHistoryKey = "order_history";
  final orders = <OrderModel>[].obs;
  final isLoadingOrder = false.obs;

  //-------------------------------------------
  //* Lifecycle Section *\\
  @override
  void onInit() {
    super.onInit();
    loadOrders();
  }

  //-------------------------------------------
  //* Functions Section *\\
  //! Save New Order to Order History
  Future<bool> saveOrder(OrderModel order) async {
    try {
      final preferences = await SharedPreferences.getInstance();
      orders.insert(0, order);
      final orderData = orders.map((savedOrder) {
        return jsonEncode(savedOrder.toJson());
      }).toList();
      final isSaved = await preferences.setString(
        orderHistoryKey,
        jsonEncode(orderData),
      );
      if (!isSaved) {
        orders.removeWhere((savedOrder) {
          return savedOrder.orderNumber == order.orderNumber;
        });
      }
      return isSaved;
    } catch (error) {
      return false;
    }
  }

  //! Load Order History from Shared Preferences
  Future<void> loadOrders() async {
    try {
      isLoadingOrder.value = true;
      final preferences = await SharedPreferences.getInstance();
      final orderData = preferences.getStringList(orderHistoryKey) ?? [];
      final savedOrders = orderData.map((encodedOrder) {
        final decodedOrder = jsonDecode(encodedOrder);
        return OrderModel.fromJson(Map<String, dynamic>.from(decodedOrder));
      }).toList();
      savedOrders.sort((firstOrder, secondOrder) {
        final firstDate =
            DateTime.tryParse(firstOrder.orderDate) ??
            DateTime.fromMillisecondsSinceEpoch(0);
        final secondDate =
            DateTime.tryParse(secondOrder.orderDate) ??
            DateTime.fromMillisecondsSinceEpoch(0);
        return secondDate.compareTo(firstDate);
      });
      orders.assignAll(savedOrders);
    } catch (error) {
      orders.clear();
    } finally {
      isLoadingOrder.value = false;
    }
  }

  //! Find Order by Order Number
  OrderModel? findOrderByNumber(String orderNumber) {
    final index = orders.indexWhere((order) {
      return order.orderNumber == orderNumber;
    });
    if (index == -1) return null;
    return orders[index];
  }
}
