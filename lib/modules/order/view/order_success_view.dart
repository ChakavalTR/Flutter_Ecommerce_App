import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_ecommerce_app/config/routes/app_pages.dart';
import 'package:flutter_ecommerce_app/modules/order/model/order_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderSuccessView extends StatefulWidget {
  const OrderSuccessView({super.key});

  @override
  State<OrderSuccessView> createState() => _OrderSuccessViewState();
}

class _OrderSuccessViewState extends State<OrderSuccessView>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> scaleAnimation;
  late ConfettiController confettiController;

  //! OnInit
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    scaleAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.elasticOut,
    );
    confettiController = ConfettiController(duration: Duration(seconds: 2));
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await animationController.forward();
      await Future.delayed(Duration(milliseconds: 300));
      if (mounted) {
        confettiController.play();
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final OrderModel order = Get.arguments as OrderModel;
    final orderDate = DateTime.tryParse(order.orderDate) ?? DateTime.now();
    return Scaffold(body: SafeArea(child: _buildBody(order, orderDate)));
  }

  //! Build Body
  Widget _buildBody(OrderModel order, DateTime orderDate) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0, left: 10),
              child: IconButton(
                onPressed: () {
                  RouteView.home.go(clearAll: true);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 26,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 25),
            Center(
              child: Column(
                children: [
                  ScaleTransition(
                    scale: scaleAnimation,
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green.withOpacity(0.10),
                      ),
                      child: Center(
                        child: Container(
                          width: 115,
                          height: 115,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green.withOpacity(0.18),
                          ),
                          child: Center(
                            child: CircleAvatar(
                              radius: 48,
                              backgroundColor: Colors.green,
                              child: Icon(
                                Icons.check_rounded,
                                size: 65,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  FadeTransition(
                    opacity: scaleAnimation,
                    child: Text(
                      'Order Placed Successfully!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  FadeTransition(
                    opacity: scaleAnimation,
                    child: Text(
                      'Yay! Your order has been placed and is\nbeing processed.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildOrderInfoRow(
                      icon: Icons.receipt_long_outlined,
                      title: 'Order Number',
                      value: order.orderNumber,
                      valueColor: Colors.green,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Divider(height: 1, color: Colors.grey[300]),
                    ),
                    _buildOrderInfoRow(
                      icon: Icons.calendar_month_outlined,
                      title: 'Order Date',
                      value: DateFormat(
                        'dd, MMM yyyy • hh:mm a',
                      ).format(orderDate),
                      valueColor: Colors.black,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Divider(height: 1, color: Colors.grey[300]),
                    ),
                    _buildOrderInfoRow(
                      icon: Icons.local_shipping_outlined,
                      title: 'Delivery Address',
                      value:
                          '${order.shippingAddress.address},\n'
                          '${order.shippingAddress.city},${order.shippingAddress.postalCode}',
                      isMultiLine: true,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Divider(height: 1, color: Colors.grey[300]),
                    ),
                    _buildOrderInfoRow(
                      icon: Icons.payment_outlined,
                      title: 'Payment Method',
                      value: order.paymentMethod,
                      valueColor: Colors.black,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Divider(height: 1, color: Colors.grey[300]),
                    ),
                    _buildOrderInfoRow(
                      icon: Icons.account_balance_wallet_outlined,
                      title: 'Total Paid',
                      value: '\$${order.totalPaid.toStringAsFixed(2)}',
                      valueColor: Colors.green,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  RouteView.home.go(clearAll: true);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.home, size: 26, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'Back to Home',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: 105,
          child: ConfettiWidget(
            confettiController: confettiController,
            blastDirection: pi / 2,
            blastDirectionality: BlastDirectionality.explosive,
            emissionFrequency: 0.05,
            numberOfParticles: 20,
            gravity: 0.20,
            shouldLoop: false,
            minimumSize: const Size(5, 5),
            maximumSize: const Size(11, 11),
          ),
        ),
      ],
    );
  }

  //! Build Order Info Row
  Widget _buildOrderInfoRow({
    required IconData icon,
    required String title,
    required String value,
    Color? valueColor,
    bool isMultiLine = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      child: Row(
        crossAxisAlignment: isMultiLine
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: isMultiLine ? 2 : 0),
            child: Icon(icon, size: 24, color: Colors.black),
          ),
          SizedBox(width: 12),
          SizedBox(
            width: 120,
            child: Padding(
              padding: EdgeInsets.only(top: isMultiLine ? 2 : 0),
              child: Text(
                title,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              maxLines: isMultiLine ? 2 : 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 15,
                height: isMultiLine ? 1.4 : 1,
                fontWeight: FontWeight.w600,
                color: valueColor ?? Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
