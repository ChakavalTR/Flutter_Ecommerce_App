import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/modules/checkout/controller/checkout_controller.dart';
import 'package:get/get.dart';

class AddCreditCardView extends GetView<CheckoutController> {
  const AddCreditCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Credit Card')),
      body: Center(child: Text('Add Credit Card Form Goes Here')),
    );
  }
}
