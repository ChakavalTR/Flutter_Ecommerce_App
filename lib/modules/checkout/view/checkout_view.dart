import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/modules/checkout/controller/checkout_controller.dart';
import 'package:get/get.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  //! Build AppBar
  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        'Cart',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    );
  }

  //! Build Body
  Widget _buildBody() {
    final items = controller.checkoutItems;
    return Column(
      children: [
        ...items.map(
          (item) => ListTile(
            title: Text(item.product.title),
            subtitle: Text('Quantity: ${item.quantity}'),
            trailing: Text('\$${item.product.price}'),
          ),
        ),
      ],
    );
  }
}
