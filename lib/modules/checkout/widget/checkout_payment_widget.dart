import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/config/theme/app_theme.dart';
import 'package:flutter_ecommerce_app/modules/checkout/controller/checkout_controller.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class CheckoutPaymentWidget extends GetView<CheckoutController> {
  const CheckoutPaymentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.0, top: 8.0),
              child: Text(
                'Payment Method',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),

            GestureDetector(
              onTap: controller.toggleCardDropDown,
              child: Container(
                width: double.infinity,
                height: 55,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: controller.selectedPaymentMethod.value == 0
                      ? AppTheme.primary.withOpacity(0.1)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: controller.selectedPaymentMethod.value == 0
                        ? AppTheme.primary
                        : Colors.grey.shade300,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.credit_card, size: 28, color: Colors.blue),
                      SizedBox(width: 10),
                      Text(
                        'Credit / Debit Card',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      ...List.generate(controller.creditCardImages.length, (
                        index,
                      ) {
                        return Container(
                          width: 35,
                          height: 30,
                          margin: EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Image.asset(
                            controller.creditCardImages[index],
                            fit: BoxFit.contain,
                          ),
                        );
                      }),
                      Icon(
                        controller.isCardDropDownOpen.value
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            if (controller.isCardDropDownOpen.value) ...[
              ...List.generate(controller.savedCards.length, (index) {
                final card = controller.savedCards[index];
                return Slidable(
                  key: ValueKey(card.id),
                  endActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    extentRatio: 0.45,
                    children: [
                      SlidableAction(
                        onPressed: (_) {
                          controller.deleteSavedCard(index);
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () => controller.selectSavedCard(index),
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: controller.selectedCardIndex.value == index
                            ? AppTheme.primary.withOpacity(0.1)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: controller.selectedCardIndex.value == index
                              ? AppTheme.primary
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            controller.selectedCardIndex.value == index
                                ? Icons.check_circle
                                : Icons.radio_button_unchecked,
                            color: controller.selectedCardIndex.value == index
                                ? AppTheme.primary
                                : Colors.grey,
                          ),
                          SizedBox(width: 10),
                          Text(
                            controller.maskCardNumber(card.cardNumber),
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Image.asset(card.cardImage, width: 38, height: 28),
                        ],
                      ),
                    ),
                  ),
                );
              }),
              GestureDetector(
                onTap: controller.showAddCreditCardBottomSheet,
                child: Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppTheme.primary),
                        ),
                        child: Icon(
                          Icons.add,
                          color: AppTheme.primary,
                          size: 26,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Add New Card',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.credit_card, color: Colors.blue),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            ],

            GestureDetector(
              onTap: controller.selectCashOnDelivery,
              child: Container(
                width: double.infinity,
                height: 55,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: controller.selectedPaymentMethod.value == 1
                      ? AppTheme.primary.withOpacity(0.1)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: controller.selectedPaymentMethod.value == 1
                        ? AppTheme.primary
                        : Colors.grey.shade300,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.local_atm, size: 28, color: Colors.green),
                      SizedBox(width: 10),
                      Text(
                        'Cash on Delivery',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.delivery_dining_outlined,
                        size: 30,
                        color: controller.selectedPaymentMethod.value == 1
                            ? AppTheme.primary
                            : Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
