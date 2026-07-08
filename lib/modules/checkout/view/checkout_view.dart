import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/modules/checkout/controller/checkout_controller.dart';
import 'package:flutter_ecommerce_app/modules/checkout/widget/bottom_navigation_bar_total_widget.dart';
import 'package:flutter_ecommerce_app/modules/checkout/widget/checkout_items_widget.dart';
import 'package:flutter_ecommerce_app/modules/checkout/widget/checkout_address_widget.dart';
import 'package:flutter_ecommerce_app/modules/checkout/widget/checkout_payment_widget.dart';
import 'package:flutter_ecommerce_app/modules/checkout/widget/checkout_price_summary_widget.dart';
import 'package:flutter_ecommerce_app/modules/checkout/widget/checkout_promocode_widget.dart';
import 'package:flutter_ecommerce_app/modules/checkout/widget/checkout_shipping_widget.dart';
import 'package:get/get.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        behavior: HitTestBehavior.opaque,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          padding: EdgeInsets.only(bottom: 40),
          child: _buildBody(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarTotalWidget(),
    );
  }

  //! Build AppBar
  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        'Checkout',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    );
  }

  //! Build Body
  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 5),
      child: Column(
        children: [
          //! Shipping Address Section
          CheckoutAddressWidget(),

          //! Item Method Section
          SizedBox(height: 10),
          CheckoutItemsWidget(),

          //! Shipping Fee Section
          SizedBox(height: 10),
          CheckoutShippingWidget(),

          //! Price Summary Section
          SizedBox(height: 10),
          CheckoutPriceSummaryWidget(),

          //! Payment Method Section
          SizedBox(height: 10),
          CheckoutPaymentWidget(),

          //! Promo Code Section
          SizedBox(height: 10),
          CheckoutPromoCodeWidget(),
        ],
      ),
    );
  }
}
